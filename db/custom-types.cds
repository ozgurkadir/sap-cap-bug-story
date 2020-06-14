type IssueType : Association to bugstory.common.IssueTypes;
type IssuePriority : Association to bugstory.common.IssuePriorities;
type ActionType : Association to bugstory.common.Actions;
type SprintStatu : Association to bugstory.common.SprintStatu;

context bugstory.common {

    entity IssueTypes {
        key issueType : String enum {
                Epic  = 'E';
                Task  = 'T';
                Bug   = 'B';
                Story = 'S';
            };
    }

    entity Actions {
        key actionType : Integer enum {
                Started = 1;
                Updated = 2;
                Closed  = 3;
                Cancel  = 4;
            };
    }

    entity IssuePriorities {
        key issuePriority : String enum {
                High   = 'H';
                Medium = 'M';
                Low    = 'L';
            }
    }

    entity SprintStatu {
        key sprintStatu : Integer enum {
                Started = 1;
                Closed  = 2;
            };
    }
}

aspect dateInfo {
    plannedStartDate : Timestamp;
    plannedEndDate   : Timestamp;
    actualStartDate  : Timestamp;
    actualEndDate    : Timestamp;
}
