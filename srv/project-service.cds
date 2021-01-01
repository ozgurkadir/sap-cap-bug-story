using {com.bugstory as allEntities} from '../db/schema';

@path : '/project'
service ProjectsService {

    entity Projects              as projection on allEntities.Projects;

    entity Issues                as projection on allEntities.Issues

    actions {
        action startIssue();
        action closeIssue();
        action cancelIssue();
        action assignUser(userid : String) returns UserValueHelp;
    };


    entity SprintIssuesforCharts as select from allEntities.SprintIssuesforCharts;

    entity Sprints               as
        select from allEntities.Sprints {
            *,
            null as numberOfIssues : Integer,
        //cast( issuesForChart as IssuesForChart ) as IssuesForCharts
        };

    //function getIssuesForChart() returns array of IssuesForChart;


    entity Comments              as projection on allEntities.Comments;
    entity externalUser          as projection on allEntities.externalUser;
    entity UserValueHelp         as projection on allEntities.Users;
}
