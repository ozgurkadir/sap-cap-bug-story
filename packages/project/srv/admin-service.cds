using {com.bugstory as allEntities} from '../db/schema';

service AdminService @(requires_ : 'authenticated-user') {
    entity Users    as projection on allEntities.user.Users;
    entity Roles    as projection on allEntities.user.Roles;
    entity Projects as projection on allEntities.Projects;
    entity Issues   as projection on allEntities.Issues;
}
