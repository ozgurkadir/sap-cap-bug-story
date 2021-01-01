using ProjectsService from '../srv/project-service';


annotate ProjectsService.Issues actions {
    assignUser(userid @(
        title  : 'Select a user',
        
        Common : {
                  //ValueListWithFixedValues : true,
                 ValueList : {
            $Type          : 'Common.ValueListType',
            CollectionPath : 'UserValueHelp',
            Parameters     : [
            {
                $Type             : 'Common.ValueListParameterInOut',
                LocalDataProperty : userid,
                ValueListProperty : 'userID'
            },
            {
                $Type             : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'UserName'
            }
            ],
        }}
    )
    )
}
