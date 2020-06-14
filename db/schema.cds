namespace com.bugstory;

using {
    managed,
    cuid,
    temporal
} from '@sap/cds/common';


using {
    IssueType,
    ActionType,
    IssuePriority,
    dateInfo,
    SprintStatu
} from './custom-types';

entity Projects : managed, dateInfo, cuid {
    project_name : String;
    description  : String;
    issues       : Composition of many Issues
                       on issues.project_id = $self;
}

entity Issues : managed, cuid, dateInfo {
    key ID           : Association to Backlog;
        type         : IssueType;
        description  : String;
        project_id   : Association to Projects;
        priority     : IssuePriority;
        sprintIssues : Composition of many SprintIssues
                           on sprintIssues.issue = $self;
}

entity IssueActions : managed, cuid {
    issue_id    : Association to Issues;
    actiontype  : ActionType;
    actionlevel : String;
    actionbody  : String;
    actionNum   : Integer;
}

entity Sprints : managed, cuid, dateInfo {
    name        : String;
    description : String;
    status      : SprintStatu;
}

entity SprintIssues : managed {
    key issue  : Association to Issues;
    key sprint : Association to Sprints;
}

entity Backlog : managed, cuid {

    description : String;
    issues      : Composition of many Issues
                      on issues.ID = $self;
}
