using {com.bugstory as allEntities} from '../db/schema';

service AdminService @(requires_ : 'authenticated-user') {
    entity Users    as projection on allEntities.Users;
    entity Roles    as projection on allEntities.Roles;
    entity Projects as projection on allEntities.Projects;
    entity Issues   as projection on allEntities.Issues;
}
