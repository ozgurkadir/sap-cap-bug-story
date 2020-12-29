const cds = require("@sap/cds");
const dayjs = require("dayjs");

const gettotalDaysDAYJS = (issueList) =>
  issueList.map(
    (currentValueSprintLine) => ({
        description: currentValueSprintLine.description,
        ID: currentValueSprintLine.ID,
        daysRemaining: 0,
        daysPlanned: currentValueSprintLine.issues.reduce(
          (accumulatorIssueLine, currentValueIssueLine) =>
            (accumulatorIssueLine += _getDateDifferenceDAYJS(
              dayjs(currentValueIssueLine.plannedStartDate),
              dayjs(currentValueIssueLine.plannedEndDate)
            )),
            0
        ),

        daysSpent: currentValueSprintLine.issues.reduce(
          (accumulatorIssueLine, currentValueIssueLine) =>
            (accumulatorIssueLine += _getActualDateDifferenceDAYJS(
              dayjs(currentValueIssueLine.actualStartDate),
              dayjs(currentValueIssueLine.actualEndDate)
            )),
            0
        ),              
    }),
    {}
  );


/*
const gettotalDaysDAYJS = (issueList) =>
  issueList.reduce(
    (accumulatorSprintLine, currentValueSprintLine) => ({
      ...accumulatorSprintLine,
       
        description: currentValueSprintLine.description,
        ID: currentValueSprintLine.ID,
        daysLeft: 0,
        totalDays: currentValueSprintLine.issues.reduce(
          (accumulatorIssueLine, currentValueIssueLine) =>
            (accumulatorIssueLine += _getDateDifferenceDAYJS(
              dayjs(currentValueIssueLine.plannedStartDate),
              dayjs(currentValueIssueLine.plannedEndDate)
            )),
            ( parseInt(accumulatorSprintLine.totalDays) || 0 ) + 0
        ),

        usedDays: currentValueSprintLine.issues.reduce(
          (accumulatorIssueLine, currentValueIssueLine) =>
            (accumulatorIssueLine += _getActualDateDifferenceDAYJS(
              dayjs(currentValueIssueLine.actualStartDate),
              dayjs(currentValueIssueLine.actualEndDate)
            )),
            ( parseInt(accumulatorSprintLine.usedDays) || 0 )  + 0
        ),              
    }),
    {}
  );
*/

  const readsprintIssues = (Sprints, req) => cds.tx(req).run(
    SELECT.from(Sprints, (s) => {
      s.ID,
        s.description,
        s.issues((si) => {
          si.description,
            si.plannedStartDate,
            si.plannedEndDate,
            si.actualStartDate,
            si.actualEndDate;
        });
    })
  );

const _getDateDifferenceDAYJS = (dateFirst, dateLast) =>
  dateLast.diff(dateFirst, "day");

  const _getActualDateDifferenceDAYJS = (dateFirst, dateLast) =>
  isNaN(dateFirst) ? 0 : (isNaN(dateLast)  ? _getDateDifferenceDAYJS(dateFirst, dayjs()) : _getDateDifferenceDAYJS(dateFirst, dateLast) );

module.exports = {
  gettotalDaysDAYJS,
  readsprintIssues
};
