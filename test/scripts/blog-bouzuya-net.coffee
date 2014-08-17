{Robot, User, TextMessage} = require 'hubot'
assert = require 'power-assert'
path = require 'path'
sinon = require 'sinon'

describe 'blog-bouzuya-net', ->
  beforeEach (done) ->
    @sinon = sinon.sandbox.create()
    # for warning: possible EventEmitter memory leak detected.
    # process.on 'uncaughtException'
    @sinon.stub process, 'on', -> null
    @robot = new Robot(path.resolve(__dirname, '..'), 'shell', false, 'hubot')
    @robot.adapter.on 'connected', =>
      @robot.load path.resolve(__dirname, '../../src/scripts')
      done()
    @robot.run()

  afterEach (done) ->
    @robot.brain.on 'close', =>
      @sinon.restore()
      done()
    @robot.shutdown()

  describe 'listeners[0].regex', ->
    beforeEach ->
      @sender = new User 'bouzuya', room: 'hitoridokusho'
      @callback = @sinon.spy()
      @robot.listeners[0].callback = @callback

    describe 'receive "@hubot blog.bouzuya.net"', ->
      beforeEach ->
        message = '@hubot blog.bouzuya.net'
        @robot.adapter.receive new TextMessage(@sender, message)

      it 'matches', ->
        assert @callback.callCount is 1
        match = @callback.firstCall.args[0].match
        assert match.length is 2
        assert match[0] is '@hubot blog.bouzuya.net'
        assert match[1] is undefined

    describe 'receive "@hubot blog.bouzuya.net 2"', ->
      beforeEach ->
        message = '@hubot blog.bouzuya.net 2'
        @robot.adapter.receive new TextMessage(@sender, message)

      it 'matches', ->
        assert @callback.callCount is 1
        match = @callback.firstCall.args[0].match
        assert match.length is 2
        assert match[0] is '@hubot blog.bouzuya.net 2'
        assert match[1] is '2'

  describe 'listeners[0].callback', ->
    beforeEach ->
      @callback = @robot.listeners[0].callback
      json = [
        { date: '2014-08-16', title: 'hoge' }
        { date: '2014-08-17', title: 'fuga' }
      ]
      @sinon.stub @robot, 'arm', -> -> then: (cb) -> cb json: json
      @send = @sinon.spy()

    describe 'receive "@hubot blog.bouzuya.net"', ->
      beforeEach ->
        @callback
          match: ['@hubot blog.bouzuya.net']
          send: @send
          robot: @robot

      it 'send "2014-08-17 fuga ..."', ->
        assert @send.callCount is 1
        assert @send.firstCall.args[0] is '''
          2014-08-17 fuga
            http://blog.bouzuya.net/2014-08-17
        '''

    describe 'receive "@hubot blog.bouzuya.net 2"', ->
      beforeEach ->
        @callback
          match: ['@hubot blog.bouzuya.net', '2']
          send: @send
          robot: @robot

      it 'send "2014-08-17 fuga ... 2014-08-16 hoge ..."', ->
        assert @send.callCount is 1
        assert @send.firstCall.args[0] is '''
          2014-08-17 fuga
            http://blog.bouzuya.net/2014-08-17
          2014-08-16 hoge
            http://blog.bouzuya.net/2014-08-16
        '''
