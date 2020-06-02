type IssueType : Association to bugstory.common.IssueTypes;
type IssuePriority : Association to bugstory.common.IssuePriorities;
type ActionType : Association to bugstory.common.ActionTypes;

context bugstory.common {

    entity IssueTypes {
        key issueType : String enum {
                Epic  = 'E';
                Task  = 'T';
                Bug   = 'B';
                Story = 'S';
            };
    }

    entity ActionTypes {
        key actionType : Integer enum {
                Closed = 1;
                Cancel = 2;
            };
    }

    entity IssuePriorities {
        key issuePriority : String enum {
                High   = 'H';
                Medium = 'M';
                Low    = 'L';
            }
    }

}

aspect dateInfo {
    plannedStartDate : Timestamp;
    plannedEndDate   : Timestamp;
    actualStartDate  : Timestamp;
    actualEndDate    : Timestamp;
}
