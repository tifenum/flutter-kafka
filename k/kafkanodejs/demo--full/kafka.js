'use strict';
const express = require('express');
let http = require('http').Server(express);
let io = require('socket.io')(http);
var Kafka = require('no-kafka');
const mongoose = require('./connect/connect.js');
const cors = require('cors');
const bcrypt = require('bcrypt');
const User = require('./models/user.js')
const port = 3010;

const app = express();
app.use(cors());
app.use(express.json()); 


io.on('connection', (socket) => {
    console.log('USER CONNECTED');
 
    socket.on('disconnect', function(){
      console.log('USER DISCONNECTED');
    });
   
  });
  
app.listen(port, function(){
    console.log("Server running on localhost:" + port);
    var consumer = new Kafka.SimpleConsumer({
connectionString: 'kafka.treetronix.com:9095',
        clientId: 'no-kafka-client'
    });
    async function insertData(data) {
      try {
        const collection = mongoose.connection.collection('mycollection');
        const result = await collection.insertOne(data);
        console.log('Data inserted into MongoDB:', result);
      } catch (error) {
        console.error('Error inserting data into MongoDB:', error);
      }
    }
    const ONE_DAY = 24 * 60 * 60 * 1000; 
    const ONE_WEEK = 7 * ONE_DAY;
    const ONE_MONTH = 30 * ONE_DAY;
    const THIRTY_DAYS = 30 * 24 * 60 * 60 * 1000; 


app.get('/api/values/last-day/:type', async (req, res) => {
  try {
    const collection = mongoose.connection.collection('mycollection');
    const startDate = new Date(Date.now() - ONE_DAY); 
    const type = req.params.type; 
    const data = await collection.find({ timestamp: { $gte: startDate } }).toArray();
    const result = data.map(entry => entry[type]); 
    res.json(result);
  } catch (error) {
    console.error('Error fetching data from last day:', error);
    res.status(500).json({ error: 'Internal server error' });
  } 
});

app.get('/api/values/last-week/:type', async (req, res) => {
  try {
    const collection = mongoose.connection.collection('mycollection');
    const startDate = new Date(Date.now() - ONE_WEEK);
    const type = req.params.type; 
    const data = await collection.find({ timestamp: { $gte: startDate } }).toArray();
    const result = data.map(entry => entry[type]);
    res.json(result);
  } catch (error) {
    console.error('Error fetching data from last week:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

app.get('/api/values/last-month/:type', async (req, res) => {
  try {
    const collection = mongoose.connection.collection('mycollection');
    const startDate = new Date(Date.now() - ONE_MONTH);
    const type = req.params.type; 
    const data = await collection.find({ timestamp: { $gte: startDate } }).toArray();
    const result = data.map(entry => entry[type]); 
    res.json(result);
  } catch (error) {
    console.error('Error fetching data from last month:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

app.get('/api/values', async (req, res) => {
  try {
      const collection = mongoose.connection.collection('mycollection');
      const latestValues = await collection.findOne({}, { sort: { _id: -1 } });
      res.json(latestValues);
  } catch (error) {
      console.error('Error fetching latest values:', error);
      console.log(res.message);
      res.status(500).json({ error: 'Internal server error' });
  }
});


app.post("/api/login", async (req, res) => {
  console.log("donne",req.body);
  try {
    const { email, password } = req.body;
    const user = await User.findOne({ email });
    if (!user) {
      return res.status(404).send({ message: "User not found" });
    }

    if (password !=user.password) {
      return res.status(401).send({ message: "Invalid password" });
    }

    res.status(200).send({ message: "Login successful", user });
  } catch (err) {
    console.error(err); 
    res.status(500).send("Internal Server Error");
  }
});
app.post('/api/register', async (req, res) => {
  try {
      const data = req.body;
      console.log(data);
      if (!data.username || !data.email || !data.password) {
          return res.status(400).send("Missing required fields");
      }
      

      
      
      const newUser = new User({
          username: data.username,
          email: data.email,
          password: data.password,
      });
      console.log(newUser);
      const savedUser = await newUser.save();
      res.status(200).send(savedUser);
  } catch (error) {
      console.error(error);
      res.status(400).send(error);
  }
});

var dataHandler = function (messageSet, topic, partition) {
  messageSet.forEach(async function (m) {
    var message = JSON.parse(m.message.value.toString('utf8'));

    if (message.DevEUI_uplink.DevEUI === '5555555555555555') {
      var payloadHex = message.DevEUI_uplink.payload_hex;
      console.log('Received payloadHex:', payloadHex);

      var buffer = Buffer.from(payloadHex, 'hex');
      console.log('Buffer length:', buffer.length);

      if (buffer.length >= 12) {
        try {
          var current = buffer.readFloatLE(0).toFixed(2); 
          var power = buffer.readFloatLE(4).toFixed(2); 
          var energy = buffer.readFloatLE(8).toFixed(2); 
          console.log("current", current, "power", power, "energy", energy);
          var timestamp = new Date();

          console.log("topic ", topic, "partition ", partition, "m.offset ", m.offset, "current ", current, "power ", power, "energy ", energy, "timestamp", timestamp);

          io.emit('message', { current: current, power: power, energy: energy });
          await insertData({ current: current, power: power, energy: energy, timestamp: timestamp });
        } catch (err) {
          console.error('Error reading buffer:', err);
        }
      } else {
        console.error('Buffer length insufficient:', buffer.length);
      }
    }
  });
};


return consumer.init().then(function () {

var v1 = consumer.subscribe('AS.Treetronix.v1', dataHandler);
var arr=[];
arr.push([v1]);
console.log("val:"+arr);
return arr;

});


});