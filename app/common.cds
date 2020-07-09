using {com.bugstory as bugstory} from '../db/schema';


annotate bugstory.Projects with @(UI : {
    Identification  : [{Value : project_name}],
    SelectionFields : [
    project_name,
    description,
    ],
    LineItem        : [
    {Value : project_name, Label : 'Project Name'},
    {Value : description, Label : 'Description'}
    ]
});
