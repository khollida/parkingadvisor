var express = require('express');
var router = express.Router();

var mongoose = require('mongoose');
var Tickets = require('../models/Ticket.js');

/* GET all tickets listing. */
router.get('/', function(req, res, next) {
  Tickets.find(function (err, parking) {
    if (err) return next(err);
    res.json(parking);
  });
});

/* GET /parking/:id */
router.get('/:id', function(req, res, next) {
  Tickets.findById(req.params.id, function (err, post) {
    if (err) return next(err);
    res.json(post);
  });
});

/* GET /parking/location/:location
   Finds Tickets by location
*/
router.get('/location/:location', function (req, res, next) {
        Tickets.find({ location: req.params.location }, function (err, citations) {
            if (err) return next(err);
            res.json(citations);
        });
});

/* GET /parking/amount/:amount */
router.get('/amount/:amount', function (req, res, next) {
        Tickets.find({ amount: req.params.amount }, function (err, citations) {
            if (err) return next(err);
            res.json(citations);
        });
});

/* GET /parking/location/:location/total
   Gives total sum of fines per location */
router.get('/location/:location/total', function (req, res, next) {
        Tickets.aggregate({ $match: { location: req.params.location } }, { $group: { _id: req.params.location, totalAmount: { $sum:  "$amount" } } },
        function (err, citations) {
            if (err) return next(err);
            res.json(citations);
        });
});



// router.get('/location/:location/total', function (req, res, next) {
//         Tickets.aggregate({ $group: { _id: null, totalAmount: { $sum:  "$amount" } } },
//         function (err, citations) {
//             if (err) return next(err);
//             res.json(citations);
//         });
// });

module.exports = router;
