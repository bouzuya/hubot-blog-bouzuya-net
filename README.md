# hubot-blog-bouzuya-net

A Hubot script that display the blog.bouzuya.net posts.

## Installation

    $ npm install git://github.com/bouzuya/hubot-blog-bouzuya-net.git

or

    $ # TAG is the package version you need.
    $ npm install 'git://github.com/bouzuya/hubot-blog-bouzuya-net.git#TAG'

## Example

    bouzuya> hubot help blog.bouzuya.net
      hubot> hubot blog.bouzuya.net [<N>] - display the blog.bouzuya.net <N> posts.

    bouzuya> hubot blog.bouzuya.net
      hubot> 2014-08-16 hubot-auto-nomulish をつくった
              http://blog.bouzuya.net/2014-08-16

## Configuration

See [`src/scripts/blog-bouzuya-net.coffee`](src/scripts/blog-bouzuya-net.coffee).

## Development

### Run test

    $ npm test

### Run robot

    $ npm run robot

## License

[MIT](LICENSE)

## Author

[bouzuya][user] &lt;[m@bouzuya.net][mail]&gt; ([http://bouzuya.net][url])

## Badges

[![Build Status][travis-badge]][travis]
[![Dependencies status][david-dm-badge]][david-dm]

[travis]: https://travis-ci.org/bouzuya/hubot-blog-bouzuya-net
[travis-badge]: https://travis-ci.org/bouzuya/hubot-blog-bouzuya-net.svg?branch=master
[david-dm]: https://david-dm.org/bouzuya/hubot-blog-bouzuya-net
[david-dm-badge]: https://david-dm.org/bouzuya/hubot-blog-bouzuya-net.png
[user]: https://github.com/bouzuya
[mail]: mailto:m@bouzuya.net
[url]: http://bouzuya.net
