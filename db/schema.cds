namespace com.bugstory;

using {
    managed,
    cuid,
    temporal
} from '@sap/cds/common';


using {
    IssueType,
    IssuePriority,
    dateInfo,
    SprintStatu,
    IssueStatu
} from './custom-types';


type IssuesForChartd : {
    status           : Integer; //Redirection for sub elements not supported yet
    calculatedIssues : Integer;
};


entity Projects : managed, dateInfo, cuid {
    projectName : String;
    description : String;
    sprints     : Composition of many Sprints
                      on sprints.projectId = $self;
}

entity Issues : managed, cuid, dateInfo {
    //    key ID          : Association to Backlog;
    type                          : IssueType;
    description                   : String;
    projectId                     : Association to Projects;
    priority                      : IssuePriority;
    sprint                        : Association to Sprints;
    comments                      : Composition of many Comments
                                        on comments.issue = $self;
    issueStatu                    : String  @assert.range enum {
        Created                             @(title : 'Created');
        Started                             @(title : 'Started');
        Closed                              @(title : 'Closed');
        Cancelled                           @(title : 'Cancelled');
    } default 'Created';
    user                          : Association to Users;
    virtual criticality           : Integer @assert.range enum {
                 Neutral = 0          @(title : 'Neutral');
                Negative = 1 @(title : 'Negative');
                Critical = 2 @(title : 'Critical');
                Positive = 3                @(title : 'Positive');
    };
}

/*
entity Users2Issues  { //Defined for many-to-many Association
    key user : Association to Users;
    key issue : Association to Issues;
}
*/

entity Sprints : managed, cuid, dateInfo {
    description : String;
    status      : String @assert.range enum {
        Created          @(title : 'Created');
        Started          @(title : 'Started');
        Closed           @(title : 'Closed');
        Cancelled        @(title : 'Cancelled');
    };
    issues      : Composition of many Issues
                      on issues.sprint = $self;
    projectId   : Association to Projects;
}

entity Comments : managed, cuid, dateInfo {
    issue   : Association to Issues;
    comment : String;
}


@cds.persistence.skip
entity SprintIssuesforCharts {
    key ID          : UUID;
        description : String;
        totalDays   : Integer;
        usedDays    : Integer;
        daysLeft    : Integer;
};

@cds.odata.valuelist
entity Users {
    key userID   : String @(title : 'User ID', );
        UserName : String @(title : 'User Name', );

};


@cds.persistence.skip
entity externalUser {
    key id                   : UUID;
        externalId           : String;
        meta                 : {
            version          : String;
            created          : String;
            lastModified     : String;
        };
        userName             : String;
        name                 : {
            familyName       : String;
            givenName        : String;
        };
        emails               : String;
        groups               : String;
        approvals            : String;
        active               : Boolean;
        verified             : Boolean;
        origin               : String;
        zoneId               : String;
        passwordLastModified : String;
        previousLogonTime    : String;
        lastLogonTime        : String;
        schemas              : String;

}
