Before do
  @login_page = LoginPage.new
  @movie_page = MoviePage.new
  @sidebar = SideBarView.new

  # page.driver.browser.manage.window.maximize
  page.current_window.resize_to(1140, 900)
end

Before ('@login') do
  user = CONFIG['users']['cat_manager']
  @login_page.go
  @login_page.with(user['email'], user['pass'])
end

After do |scenario|
  if scenario.failed?
    temp_shot = page.save_screenshot('log/temp_shot.png')
    screenshot = Base64.encode64(File.open(temp_shot, 'rb').read)
    embed(screenshot, 'image/png', 'Screenshot')
  end
end