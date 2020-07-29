using {com.bugstory as allEntities} from '../db/schema';

@path:'/test'
service TestService {
    entity TestEnt as projection on allEntities.TestEnt;
}
