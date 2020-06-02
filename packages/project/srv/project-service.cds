using {com.bugstory as allEntities} from '../../launchpad/db/schema';

@path:'/project'
service ProjectsService {
    entity Projects as projection on allEntities.project.Projects;
    entity Issues   as projection on allEntities.project.Issues;
}
