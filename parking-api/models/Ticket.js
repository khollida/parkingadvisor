var mongoose = require('mongoose');
var TicketSchema = new mongoose.Schema({
  violation_date: String,
  violation_time: String,
  location: String,
  type: String,
  violation_id: String,
  amount: Number
});
module.exports = mongoose.model('Ticket', TicketSchema);
