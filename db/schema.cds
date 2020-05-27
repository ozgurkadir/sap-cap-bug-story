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

namespace com.bugstory;

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
    key name        : String;
        description : String;
}

entity Issues : managed, cuid, dateInfo {
    type        : IssueType;
    description : String;
    priority    : IssuePriority;
}

entity Sprints : managed, cuid, dateInfo {
    description : String;
}

entity Backlog : managed, cuid {
    description : String;
    issues      : Composition of many Issues
                      on issues.ID = $self;
}
