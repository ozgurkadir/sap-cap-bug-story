using {com.bugstory as bugstory} from '../db/schema';

annotate bugstory.Users with @(UI : {
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

annotate bugstory.Projects with @(UI : {
    Identification  : [{Value : project_name}],
    SelectionFields : [
    project_name,
    description,
    ],
    LineItem        : [
    {Value : project_name},
    {Value : description}
    ]
});
