var expect  = require('chai').expect;
var request = require('request');

describe('Status and content', function() {
    describe ('Main page', function() {
        it('status', function(done){
            request('http://localhost:5000/', function(error, response, body) {
                expect(response.statusCode).to.equal(200);
                done();
            });
        });
    });
});
