using {com.bugstory as allEntities} from '../db/schema';

@path:'/user'
service UserService {
    entity Users as projection on allEntities.Users;
    entity Roles as projection on allEntities.Roles;
}
