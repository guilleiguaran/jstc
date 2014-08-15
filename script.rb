#!/usr/bin/env ruby

require "bundler/setup"
require "capybara"
require "capybara/dsl"
require "capybara/poltergeist"

Capybara.run_server = false
Capybara.current_driver = :poltergeist
Capybara.app_host = "http://cabalgata.bucaramanga.gov.co"

module Test
  class Jstc
    include Capybara::DSL

    USER_AGENT = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1944.0 Safari/537.36"

    def vote
      page.driver.add_header("User-Agent", USER_AGENT)
      visit '/'
      find(:css, '#Opciones_1').click
      x = find(:css, '#lbla').text.to_i
      y = find(:css, '#lblb').text.to_i
      result = x + y
      fill_in "txtsuma", with: result
      # save_screenshot("1_fill_captcha.png")
      click_button "btnacerptar"
      # save_screenshot("2_click_send.png")
    end
  end
end

bot = Test::Jstc.new
bot.vote
