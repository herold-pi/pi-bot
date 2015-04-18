wol = require "wake_on_lan"

module.exports = (robot) ->
  robot.respond /wake (\w+)/i, (msg) ->
    name = msg.match[1]
    machines = robot.brain.get("wakeup-machines") or {}
    if name of machines
      wol.wake machines[name], (err) ->
        if err
          msg.send "Failed to wake *#{name}*"
        else
          msg.send "Ok, *#{name}* is starting"
    else
      msg.send "I don't know *#{name}*"

  robot.respond /mac ([0-9a-f:-]+) is (\w+)/i, (msg) ->
    mac = msg.match[1]
    name = msg.match[2]

    machines = robot.brain.get("wakeup-machines") or {}
    machines[name] = mac
    robot.brain.set("wakeup-machines", machines)
    msg.send "From now on *#{name}* has MAC `#{mac}`"

  robot.respond /list machines/i, (msg) ->
    machines = robot.brain.get("wakeup-machines")
    unless machines
      msg.send "I know nothing"
    else
      message = for name, mac of machines
        "*#{name}* has MAC `#{mac}`"
      msg.send message.join("\n")
