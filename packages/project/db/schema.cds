namespace com.bugstory.project;

using {
    managed,
    cuid,
    temporal
} from '@sap/cds/common';

using {
    IssueType,
    ActionType,
    IssuePriority,
    dateInfo
} from './custom-types';

using {com.bugstory.user.Users} from '../../user/db/schema';


entity Projects : managed, cuid, dateInfo {
    project_name : String;
    description  : String;
    issues       : Composition of many Issues
                       on issues.project_id = $self;
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
    description : String;
}

entity Backlog : managed, cuid {
    description : String;
    issues      : Composition of many Issues
                      on issues.ID = $self;
}
