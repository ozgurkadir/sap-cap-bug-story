using {com.bugstory as allEntities} from '../db/schema';

@path : '/user'
service UserService {
    @readonly
    entity Users as projection on allEntities.Users;

    @readonly
    entity Roles as projection on allEntities.Roles;
}
