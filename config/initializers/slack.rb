PROJECT501_NOTIFIER = Slack::Notifier.new(
    ENV["SLACK_SECRET"],
    channel: '#project501'
)
