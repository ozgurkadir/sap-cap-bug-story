type IssueType : Association to bugstory.common.IssueTypes;
type IssuePriority : Association to bugstory.common.IssuePriorities;
type SprintStatu : Association to bugstory.common.SprintStatu;
type IssueStatu : Association to bugstory.common.IssueStatu;

context bugstory.common {


    entity IssueTypes {
        key issueType : String @assert.range enum {
                Epic  @(title : 'Epic');
                Task  @(title : 'Task'); 
                Bug   @(title : 'Bug');
                Story @(title : 'Story');
            };
    }

    entity IssuePriorities {
        key issuePriority : String @assert.range enum {
                High   @(title : 'High');
                Medium @(title : 'Medium');
                Low    @(title : 'Low');
            }
    }

    entity SprintStatu {
        key sprintStatu : Integer @assert.range enum {
                Created = 1;
                Started = 2;
                Closed  = 3;
                Cancelled = 4;
            };
    }

    entity IssueStatu {
        key issueStatu : Integer @assert.range enum {
                Created = 1;
                Started = 2;
                Closed  = 3;
                Cancelled = 4;
            };
    }

}

aspect dateInfo {
    plannedStartDate : Timestamp;
    plannedEndDate   : Timestamp;
    actualStartDate  : Timestamp;
    actualEndDate    : Timestamp;
}
