using {com.bugstory as bugstory} from '../../launchpad/db/schema';

annotate bugstory.user.Users with @(UI : {
    Identification  : [{Value : userName}],
    SelectionFields : [
    userName,
    name,
    ],
    LineItem        : [
    {Value : userName, Label: 'Custom User Name'},
    {Value : name},
    {Value : email},
    ]
});
