using {com.bugstory as allEntities} from '../db/schema';

@path : '/user'
service UsersService {

    entity User  as projection on allEntities.Users;
    

}
