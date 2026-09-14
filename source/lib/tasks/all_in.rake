namespace :all_in do
  desc "Print every lesson with its Vimeo status (quick check before launch)"
  task status: :environment do
    Lesson.ordered.each do |l|
      flag = l.video? ? (l.vimeo_id.present? ? "vimeo #{l.vimeo_id}" : "NO VIDEO") : "text"
      puts "#{l.position}. #{l.title.ljust(48)} #{flag}#{l.thumbnail.attached? ? '' : '  (no thumbnail)'}"
    end
  end

  desc "Make a user an admin: rake all_in:admin[email@example.com]"
  task :admin, [:email] => :environment do |_, args|
    u = User.find_by!(email: args[:email])
    u.update!(admin: true)
    puts "#{u.full_name} is now an admin."
  end

  desc "Reset one person's progress (for testing): rake all_in:reset[email@example.com]"
  task :reset, [:email] => :environment do |_, args|
    u = User.find_by!(email: args[:email])
    u.lesson_completions.destroy_all
    u.assessment_results.destroy_all
    u.appointment&.destroy
    u.update!(pathway_completed_at: nil)
    puts "Reset #{u.full_name}."
  end
end
