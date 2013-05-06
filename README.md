# [Faceholder](http://faceholder.co/)

Faceholder is an easy way to get faces for mockups. I'm using [Sarah Parmenter's avatar set](http://www.sazzy.co.uk/2011/11/downloadable-pack-of-avatars-for-webpsd-mock-ups/) but use whatever you want.

No idea how scalable this is; probably not very. I'm crap at caches.

# CONTRIBUTING

If someone could tell me the best way to make my server not hate me that would be amazing.

This is a continuation of [Spaceholder](http://github.com/jongd/spaceholder) — I guess whilst doing hacks I tend to need to roll my own placeholder image services…

## Usage
- Clone the repo
- Add a directory of [rad face images](http://www.sazzy.co.uk/2011/11/downloadable-pack-of-avatars-for-webpsd-mock-ups/) to /raw
- You might also need to ```mkdir -p tmp/cache/body tmp/cache/meta```
- Locally, ```rackup config.ru``` will work. On a server do your nginx thing.