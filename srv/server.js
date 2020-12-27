const proxy = require("@sap/cds-odata-v2-adapter-proxy");
const cds = require("@sap/cds")
const helmet = require("helmet")

cds.on("bootstrap", (app) => {
  //app.use(helmet())
  app.use(proxy())
})
module.exports = cds.server;
