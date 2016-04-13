require 'eventmachine'
require 'telegram'
require 'redis'
require 'json'
$redis = Redis.new(:host => '192.168.99.100', :port=> 6379)

def push_event(user_ids, event_type, data = nil, guest_ids = [])
  event = {}
  event[:user_ids] = user_ids
  event[:type] = event_type
  event[:data] = data
  event[:guest_ids] = guest_ids
  $redis.publish 'message-created', event.to_json
end

EM.run do
  telegram = Telegram::Client.new do |cfg|
    cfg.daemon = '/tmp/tg/bin/telegram-cli'
    cfg.key = '/tmp/tg/tg_server.pub'
    cfg.key = '/tmp/tg/tg_sock.sock'
  end

  telegram.connect do
    # This block will be executed when initialized.

    # See your telegram profile
    puts telegram.profile

    telegram.contacts.each do |contact|
      puts contact
    end

    telegram.chats.each do |chat|
      puts chat
    end

    # Event listeners
    # When you've received a message:
    telegram.on[Telegram::EventType::RECEIVE_MESSAGE] = Proc.new { |event|
      # `tgmessage` is TelegramMessage instance
      puts event.tgmessage
      push_event([], event.tgmessage.class, event.tgmessage)
      # redis.push ()
    }
    # When you've sent a message:
    telegram.on[Telegram::EventType::SEND_MESSAGE]= Proc.new { |event|
      puts event
      push_event([], event.tgmessage.class, event.tgmessage)
    }
  end
end
