class Lesson < ApplicationRecord
  KINDS = %w[video text].freeze

  belongs_to :step
  has_many :lesson_completions, dependent: :destroy
  has_one_attached :thumbnail

  validates :position, :slug, :title, presence: true
  validates :kind, inclusion: { in: KINDS }

  scope :ordered,   -> { order(:position) }
  scope :published, -> { where(published: true) }

  def to_param = slug
  def video? = kind == "video"
  def text?  = kind == "text"
  def video_ready? = video? && vimeo_id.present?

  def vimeo_embed_url
    return nil if vimeo_id.blank?
    params = { badge: 0, autopause: 0, player_id: 0, app_id: 58479, dnt: 1 }
    params[:h] = vimeo_hash if vimeo_hash.present?
    "https://player.vimeo.com/video/#{vimeo_id}?#{params.to_query}"
  end

  def thumbnail_variant
    thumbnail.attached? ? thumbnail.variant(resize_to_fill: [640, 360]) : nil
  end
end
