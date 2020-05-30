namespace com.bugstory.user;


using {
    managed,
    cuid,
    temporal
} from '@sap/cds/common';


entity Users : managed {
    key userName : String;
        name     : String;
        email    : String;
}

entity Roles : managed {
    key name        : String;
        description : String;
}
