require 'eventmachine'
require 'telegram'
require 'redis'
require 'json'
$redis = Redis.new(:host => '192.168.99.100', :port=> 6379)

def push_event(event_name, user_ids, event_type, data = nil, guest_ids = [])
  event = {}
  event[:user_ids] = user_ids
  event[:type] = event_type
  event[:data] = data
  event[:guest_ids] = guest_ids
  $redis.publish event_name, event.to_json
end

def json_convert(contact)
  {name: contact.name, username: contact.name, phone: contact.phone}
end
EM.run do
  telegram = Telegram::Client.new do |cfg|
    cfg.daemon = './bin/telegram-cli'
    cfg.key = './tg_server.pub'
  end

  telegram.connect do
    # This block will be executed when initialized.

    # See your telegram profile

    telegram.contacts.each do |contact|
      push_event('contacts-loaded', [], contact.class, json_convert(contact))
    end

    telegram.chats.each do |chat|
      puts chat
    end

    # Event listeners
    # When you've received a message:
    telegram.on[Telegram::EventType::RECEIVE_MESSAGE] = Proc.new { |event|
      # `tgmessage` is TelegramMessage instance
      message = event.message
      push_event('message-created', [], event.tgmessage.class, {text: message.text, from: json_convert(message.from), to: json_convert(message.to)} )
      # redis.push ()
    }
    # When you've sent a message:
    telegram.on[Telegram::EventType::SEND_MESSAGE]= Proc.new { |event|
      message = event.message
      push_event('message-created', [], event.tgmessage.class, {text: message.text, from: json_convert(message.from), to: json_convert(message.to)})
    }
  end
end