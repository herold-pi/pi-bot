moment  = require "moment"
exec    = require("child_process").exec

CMD = "ps -eo pid,lstart | grep `cat /var/run/pibot.pid` | awk '{for (i=2; i<NF; i++) printf $i \" \"; print $NF}'"
DATE_FORMAT = "ddd MMM DD HH:mm:ss YYYY"

module.exports = (robot) ->
  robot.respond /uptime/i, (res) ->
    exec CMD, (error, stdout, stderr) ->
      if error
        res.send "Don't know when I started."
      else
        res.send "I was started #{moment(stdout, DATE_FORMAT).fromNow()}."
  
