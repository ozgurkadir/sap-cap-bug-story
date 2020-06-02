using {com.bugstory as allEntities} from '../../launchpad/db/schema';

@path:'/user'
service UserService {
    entity Users as projection on allEntities.user.Users;
    entity Roles as projection on allEntities.user.Roles;
}
