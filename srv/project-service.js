const cds = require('@sap/cds')
module.exports = function (){
  this.on ('CREATE','Projects', (req)=>{
    console.log("User ID is : " + req.user.id );
    console.log("Is user authenticated ? : " + req.user.is('bug-story-pm') );
    console.log("Auth Info Data " + req );
  })
}