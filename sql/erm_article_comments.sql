SELECT 


title, alias as url, c.comment 


FROM 

realign_etk_symfony.event_actor_feedback_comment c 
left join 
realign_etk_symfony.event_actor_feedback f on c.event_actor_feedback_id=f.event_actor_feedback_id

LEFT JOIN
realign_etk_drupal.node n ON f.object_nid = n.nid
LEFT JOIN
realign_etk_drupal.url_alias u ON f.object_nid = substring_index(u.source, '/', - 1)