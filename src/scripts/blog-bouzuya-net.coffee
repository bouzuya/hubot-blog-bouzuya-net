# Description
#   A Hubot script that display the blog.bouzuya.net posts.
#
# Dependencies:
#   "hubot-arm": "git://github.com/bouzuya/hubot-arm.git#0.1.0",
#   "hubot-request-arm": "git://github.com/bouzuya/hubot-request-arm.git#0.1.0"
#
# Configuration:
#   None
#
# Commands:
#   hubot blog.bouzuya.net [<N>] - display the blog.bouzuya.net <N> posts.
#
# Author:
#   bouzuya <m@bouzuya.net>
#
module.exports = (robot) ->
  require('hubot-arm') robot

  robot.respond /blog\.bouzuya\.net(?:\s+(\d+))?\s*$/i, (res) ->
    count = res.match[1] ? '1'
    res.robot.arm('request')
      method: 'get'
      url: 'http://blog.bouzuya.net/posts.json'
      format: 'json'
    .then (ret) ->
      posts = ret.json.slice(-1 * count)
      posts.reverse()
      message = posts
        .map (p) ->
          """
            #{p.date} #{p.title}
              http://blog.bouzuya.net/#{p.date}
          """
        .join '\n'
      res.send message
