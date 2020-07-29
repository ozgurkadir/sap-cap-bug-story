using {com.bugstory as allEntities} from '../db/schema';

@path:'/sprint'
service SprintsService {
    entity Sprints as projection on allEntities.Sprints;
}
