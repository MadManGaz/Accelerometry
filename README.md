# Accelerometry 📈

A small app for iOS to send raw accelerometry data to a server over WebSocket.

![App Screenshot with Frame](https://github.com/madmangaz/accelerometry/blob/main/screenshots/mainScreen.png?raw=true)

## Usage

* Enter the URL of your WebSocket server, and click start to open a connection and begin streaming raw calibrated accelerometer data at 60Hz.
* Click stop to stop streaming data and close your connection to server.

## Data Interchange Format

The app transmits a simple comma seperated string over the WebSocket connection.

```
x,y,z
```

Only effort required to parse the data serverside is split the string on a `,` delimiter and cast the string to Double. These are guaranteed to be double precision floating point numbers.
