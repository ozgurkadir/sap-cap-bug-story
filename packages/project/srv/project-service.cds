using {com.bugstory as allEntities} from '../../launchpad/db/schema';

@path : '/adminService'
service AdminService {
    entity Users        as projection on allEntities.user.Users;
    entity Roles        as projection on allEntities.user.Roles;
    entity Projects     as projection on allEntities.project.Projects;
    entity Issues       as projection on allEntities.project.Issues;
    entity IssueActions as projection on allEntities.project.IssueActions;
}
