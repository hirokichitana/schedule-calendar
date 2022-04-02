crumb :root do
  link "Home", root_path
end

crumb :schedules_edit do
  link "スケジュールの編集", edit_schedule_path
  parent :schedules_show
end

crumb :schedules_new do
  link "新規スケジュール", new_schedule_path
  parent :root
end

crumb :schedules_show do
  link "スケジュールの詳細", schedule_path(current_user.id)
  parent :root
end

crumb :registrations_edit do
  link "ユーザー情報の編集", edit_user_registration_path
  parent :users_show
end

crumb :registrations_new do
  link "新規ユーザー登録", new_user_registration_path
  parent :root
end

crumb :sessions_new do
  link "ログイン", new_user_session_path
  parent :root
end

crumb :users_show do
  link "マイページ", user_path(current_user.id)
  parent :root
end


# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).