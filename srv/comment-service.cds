using {com.bugstory as allEntities} from '../db/schema';

@path:'/comment'
service CommentsService {
    entity Comments as projection on allEntities.Comments;
}
