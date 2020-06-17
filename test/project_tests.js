const chai = require("chai");
const chaiHttp = require("chai-http");
const server = require("./server");
const { it, before } = require("mocha");
var expect = chai.expect;

// Configure chai
chai.use(chaiHttp);
chai.should();

let app = null;

before((done) => {
    server.then((result) => {
        app = result;
        done();
    });
});

it('should create Project', (done) => {
    chai
        .request(app)
        .post("/project/Projects")
        .send({ project_name: '123', description: '123', plannedStartDate: "2020-05-16T13:38:45.995Z", plannedEndDate: "2020-08-16T13:38:45.995Z", actualStartDate: "2020-06-16T13:38:45.995Z" })
        .end(function(err, res) {
            expect(err).to.be.null;
            expect(res).to.have.status(201);
            done();
        });
});