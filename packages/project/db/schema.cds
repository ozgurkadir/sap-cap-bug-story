namespace com.bugstory.project;

using {
    managed,
    cuid,
    temporal
} from '@sap/cds/common';

using {
    IssueType,
    IssuePriority,
    dateInfo
} from './custom-types';

entity Projects : managed, dateInfo {
    key project_name : String;
        description  : String;
        issues       : Composition of many Issues
                           on issues.project_name = $self;
}

entity Issues : managed, cuid, dateInfo {
    key ID           : Association to Backlog;
        type         : IssueType;
        description  : String;
        project_name : Association to Projects;
        priority     : IssuePriority;
}

entity Sprints : managed, cuid, dateInfo {
    description : String;
}

entity Backlog : managed, cuid {
    description : String;
    issues      : Composition of many Issues
                      on issues.ID = $self;
}
