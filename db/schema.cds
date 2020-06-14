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


entity Users : managed {
    key userName : String;
        name     : String;
        email    : String;
}

entity Roles : managed {
    key name        : String;
        description : String;
}

entity Projects : managed, dateInfo {
    key project_name : String;
        description  : String;
        issues       : Composition of many Issues
                           on issues.project_name = $self;
}

entity Issues : managed, cuid, dateInfo {
    key ID          : Association to Backlog;
        type        : IssueType;
        description : String;
        project_id  : Association to Projects;
        priority    : IssuePriority;
}

entity IssueActions : managed, cuid {
    issue_id    : Association to Issues;
    userName    : Association to Users;
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

entity Backlog : managed, cuid {

    description : String;
    issues      : Composition of many Issues
                      on issues.ID = $self;
}
