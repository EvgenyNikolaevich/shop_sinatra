# frozen_string_literal: true

module Notify
  class << self
    def error(exception, tabs = {})
      bugsnag wrap(exception), tabs: tabs, severity: :error
    end

    def warning(exception, tabs = {})
      bugsnag wrap(exception), tabs: tabs, severity: :warning
    end

    def info(exception, tabs = {})
      bugsnag wrap(exception), tabs: tabs, severity: :info
    end

    def debug(exception, tabs = {})
      bugsnag wrap(exception), tabs: tabs, severity: :debug
    end

    private

    def wrap(exception)
      case exception
      when String then StandardError.new(exception)
      when Exception then exception
      else error 'Unknown error type'
      end
    end

    def bugsnag(exception, tabs: {}, severity: '')
      Bugsnag.notify(exception) do |report|
        tabs.each { |tab, value| report.add_tab(tab, value) }
        report.severity = severity unless severity.empty?
      end
    end
  end
end
