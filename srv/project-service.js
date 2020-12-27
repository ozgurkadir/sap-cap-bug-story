const cds = require("@sap/cds");
const dayjs = require("dayjs");
const serviceDal = require("./data-access")

module.exports = (srv) => {
  const { Issues, Sprints, externalUser } = srv.entities;
  

  srv.on("READ", "externalUser", async (req) => {
    
    //const service = await cds.connect.to('userExtService');    
    //return  service.tx(req).run(req.query);
	});

  srv.on("CREATE", "Projects", (req) => {
    console.log("User ID is : " + req.user.id);
    console.log("Is user authenticated ? : " + req.user.is("bug-story-pm"));
    console.log("Auth Info Data " + req);
  });

  srv.on("UPDATE", "Sprints", (req) => {});

  srv.after("READ", "Sprints", (sprints, req) => {
    return Promise.all(
      sprints.map(async (sprint) => {
        const issuesAll = await cds
          .transaction(req)
          .run(SELECT.from(Issues).where({ sprint_ID: sprint.ID }));
        // sprint.numberOfIssues = issuesAll.length;
      })
    );
  });

  srv.on("READ", "SprintIssuesforCharts", async (req) => {

    const sprintIssues = await serviceDal.readsprintIssues(Sprints, req)

    const totalDays = gettotalDays(sprintIssues);
    const totalDAYJS = serviceDal.gettotalDaysDAYJS(sprintIssues);    
    return totalDAYJS
  });

  srv.after("READ", "Issues", (issues, req) => {
    return Promise.all(
      issues.map(async (issue) => {
        const _MS_PER_DAY = 1000 * 60 * 60 * 24;
        const plannedEndDate = new Date(issue.plannedEndDate);
        const actualEndDate = new Date(issue.actualEndDate);
        const currentDate = new Date(Date.now());

        const utcPlannedEndDate = Date.UTC(
          plannedEndDate.getFullYear(),
          plannedEndDate.getMonth(),
          plannedEndDate.getDate()
        );
        const utcActualEndDate = Date.UTC(
          actualEndDate.getFullYear(),
          actualEndDate.getMonth(),
          actualEndDate.getDate()
        );
        const utcCurrentDate = Date.UTC(
          currentDate.getFullYear(),
          currentDate.getMonth(),
          currentDate.getDate()
        );

        if (
          Math.floor((utcActualEndDate - utcPlannedEndDate) / _MS_PER_DAY) > 0
        ) {
          issue.criticality = 1;
        } else if (
          Math.floor((utcPlannedEndDate - utcCurrentDate) / _MS_PER_DAY) < 0
        ) {
          issue.criticality = 2;
        } else if (
          Math.floor((utcCurrentDate - actualEndDate) / _MS_PER_DAY) > 0
        ) {
          issue.criticality = 3;
        } else {
          issue.criticality = 0;
        }
      })
    );
  });

  srv.on("CREATE", "Issues", (req) => {
    //req.data.issueStatu = 1;
  });

  srv.on("startIssue", "Issues", async (req) => {
    let [issueID] = req.params;

    const n = await UPDATE("com_bugstory_Issues")
      .set({
        issueStatu: "Started",
        actualStartDate: Date.now(),      
      })
      .where({ ID: issueID });
    n > 0 || req.error(409, "Update failed!");
  });
  
  srv.on("closeIssue", "Issues", async (req) => {
    let [issueID] = req.params;

    const n = await UPDATE("com_bugstory_Issues")
      .set({
        issueStatu: "Closed",
        actualEndDate: Date.now(),      
      })
      .where({ ID: issueID });
    n > 0 || req.error(409, "Update failed!");
  });


  srv.on("cancelIssue", "Issues", async (req) => {
    let [issueID] = req.params;

    const n = await UPDATE("com_bugstory_Issues")
      .set({
        issueStatu: "Cancelled"
      })
      .where({ ID: issueID });
    n > 0 || req.error(409, "Update failed!");
  });

  /*
  srv.on("getIssuesForChart", (req) => {
    console.log("getIssuesForChartgetIssuesForChartgetIssuesForChart");

    const ret = [];

    ret.push({
      status: 2,
      calculatedIssues: 3,
    });

    ret.push({
      status: 5,
      calculatedIssues: 8,
    });

    return ret;
  });
  */
};

const getUTCDate = (inputDate) =>
  Date.UTC(inputDate.getFullYear(), inputDate.getMonth(), inputDate.getDate());

const getDateDifference = (dateFirst, dateLast) =>
  Math.floor(getUTCDate(new Date(dateLast)) - getUTCDate(new Date(dateFirst))) /
  (1000 * 60 * 60 * 24);

/*
const getDateDifferenceDAYJS = (dateFirst, dateLast) =>
  dateLast.diff(dateFirst, "day");
*/

/*
const getActualDateDifferenceDAYJS = (dateFirst, dateLast) =>
  (dateFirst == null) ? 0 : ((dateLast == null) ? getDateDifferenceDAYJS(dayjs(), dateFirst) : getDateDifferenceDAYJS(dateLast, dateFirst) );
*/

/*
const gettotalDays = (issueList) => ( issueList.map(issueLine => (
  issueLine.issues
))).reduce((acc, cur) => (
  console.log(acc)
))
*/

/*
const gettotalDays = (issueList) => ( issueList.map(issueLine => (

  issueLine.issues.reduce((acc, cur) => (
    
    console.log("acc : " + JSON. stringify(acc) + "cur : " + JSON. stringify(cur))
    return cur
  ))
    
)))

*/

/*
const gettotalDaysDAYJS = (issueList) =>
  issueList.reduce(
    (accumulatorSprintLine, currentValueSprintLine) => ({
      ...accumulatorSprintLine,
      [currentValueSprintLine.ID]: {
        description: currentValueSprintLine.description,
        ID: currentValueSprintLine.ID,
        plannedTotalDays: currentValueSprintLine.issues.reduce(
          (accumulatorIssueLine, currentValueIssueLine) =>
            (accumulatorIssueLine += getDateDifferenceDAYJS(
              dayjs(currentValueIssueLine.plannedStartDate),
              dayjs(currentValueIssueLine.plannedEndDate)
            )),
          0
        ),

        actualTotalDays: currentValueSprintLine.issues.reduce(
          (accumulatorIssueLine, currentValueIssueLine) =>
            (accumulatorIssueLine += getActualDateDifferenceDAYJS(
              dayjs(currentValueIssueLine.actualStartDate),
              dayjs(currentValueIssueLine.actualEndDate)
            )),
          0
        ),
      },
    }),
    {}
  );
*/

const gettotalDays = (issueList) =>
  issueList.reduce(
    (accumulatorSprintLine, currentValueSprintLine) => ({
      ...accumulatorSprintLine,
      [currentValueSprintLine.ID]: {
        description: currentValueSprintLine.description,
        ID: currentValueSprintLine.ID,
        totalDays: currentValueSprintLine.issues.reduce(
          (accumulatorIssueLine, currentValueIssueLine) =>
            (accumulatorIssueLine += getDateDifference(
              currentValueIssueLine.plannedStartDate,
              currentValueIssueLine.plannedEndDate
            )),
          0
        ),
      },
    }),
    {}
  );

/*
const gettotalDays = (issueList) => (
  issueList.map( sprintLine => (
    sprintLine.issues.reduce((acc, cur) => (
      console.log(acc)
    )
  ))
))
*/
