using {com.bugstory as allEntities} from '../../launchpad/db/schema';

@path : '/user'
service UserService {
    @readonly
    entity Users as select from allEntities.user.Users;

    @readonly
    entity Roles as select from allEntities.user.Roles;
}
