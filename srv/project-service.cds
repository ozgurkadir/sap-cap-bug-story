using {com.bugstory as allEntities} from '../db/schema';

@path:'/project'
service ProjectsService {
    entity Projects as projection on allEntities.Projects;
    entity Issues   as projection on allEntities.Issues;
}
