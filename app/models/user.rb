class User < ApplicationRecord
  # :confirmable is used ONLY for email changes (reconfirmable): new sign-ups are auto-confirmed
  # below so nobody is blocked from starting All In, but changing your email requires clicking a
  # link sent to the new address before it takes effect.
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable
  before_create :skip_confirmation!

  has_many :lesson_completions, dependent: :destroy
  has_many :completed_lessons, through: :lesson_completions, source: :lesson
  has_many :assessment_results, dependent: :destroy
  has_many :growth_interests, dependent: :destroy
  has_one  :appointment, dependent: :destroy

  validates :first_name, :last_name, presence: true
  normalizes :first_name, :last_name, with: ->(v) { v.strip }
  validates :phone_country, inclusion: { in: CountryCodes::LIST.map { |_, iso, _| iso } }

  # Phone is stored as E.164 ("+15855550123"). Forms edit the national part separately.
  attr_writer :phone_number
  before_validation :compose_phone

  def phone_number
    @phone_number || (phone.present? ? phone.delete_prefix("+#{CountryCodes.dial(phone_country)}") : "")
  end

  def phone_display
    phone.present? ? "+#{CountryCodes.dial(phone_country)} #{phone_number}" : nil
  end

  def send_password_change_link
    send_reset_password_instructions
  end

  private

  def compose_phone
    return if @phone_number.nil?
    digits = @phone_number.gsub(/\D/, "")
    self.phone = digits.present? ? "+#{CountryCodes.dial(phone_country)}#{digits}" : nil
  end

  public

  def full_name = "#{first_name} #{last_name}"
  def initials  = "#{first_name.first}#{last_name.first}".upcase

  def completed?(lesson) = completed_lesson_ids.include?(lesson.id)
  def completed_lesson_ids = @completed_lesson_ids ||= lesson_completions.pluck(:lesson_id)

  def result_for(assessment)
    assessment_results.find { |r| r.assessment_id == assessment.id }
  end

  def pathway = @pathway ||= Pathway.new(self)

  # ---- Profile: what the assessments say about this person ----
  # Top categories across every completed assessment: [[assessment, [[category, score], ...]], ...]
  def strengths
    assessment_results.includes(:assessment).select(&:complete?).sort_by { |r| r.assessment.position }
      .map { |r| [r.assessment, r.top] }
  end

  # Categories the person asked to learn more about, grouped by assessment.
  def growth_areas
    growth_interests.includes(:assessment).group_by(&:assessment).sort_by { |a, _| a.position }
      .map { |a, list| [a, list.map(&:category)] }
  end

  def growth_interest?(assessment, category)
    growth_interests.any? { |g| g.assessment_id == assessment.id && g.category == category }
  end
end
