let express = require("express");
const app = express();
app.use(express.static('html'));
app.listen("3000",function (error) {
    console.log("地址:http://192.168.3.31:3000");
});