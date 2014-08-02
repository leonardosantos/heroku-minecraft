# Heroku Minecraft

#### Minecraft finds a way.

This is a very alpha-quality Heroku app that runs a Minecraft server on a single dyno.

#### Limitations

Since Heroku is a bit of a weird platform, there are a couple of caveats to running a Minecraft server on it.

* Since Heroku no longer supports TCP routing, we're proxying the connection through WebSockets. This means each client will have to run a little tool to turn the WebSocket connection back into a regular TCP Minecraft connection. This is detailed below in the "Client" section.

* Heroku has no persistant storage, so you will have to have an [Amazon AWS](http://aws.amazon.com) account and an Amazon S3 bucket ready to store your world data. Your world data will be automatically synced to and from S3 in the background.

## Server Setup

1. Clone this repository using git (or, if it's easier, [GitHub for Mac](http://mac.github.com), or [GitHub for Windows](http://windows.github.com)).

2. Create a new Heroku app with a custom buildpack.

   ```
   heroku create my-app-name --buildpack https://github.com/ddollar/heroku-buildpack-multi.git
   ```

3. Choose your minecraft server version (default: 1.7.10).

   ```
   heroku config:add MC_VERSION=1.7.10
   ```

4. Add your Amazon AWS credentials and S3 bucket name to the Heroku configuration. This enables data persistence. Otherwise, your server will be wiped each time it is restarted.

   ```
   heroku config:add AWS_KEY=xxxxxxx AWS_SECRET=yyyyyyyyyyyyyyyyy S3_BUCKET=my-bucket-name
   ```

5. Push the app to Heroku.

   ```
   git push heroku master
   ```

## Client Setup

Use https://github.com/leonardosantos/hmwtc, then

  ```
  hmwtc my-app-name.herokuapp.com
  ```

## Credits

Much of the original Heroku setup by [Jacob Gillespie](https://github.com/jacobwg).

Updates, refactoring, and the WebSockets proxying by [Wil Gieseler](https://github.com/wilg).
