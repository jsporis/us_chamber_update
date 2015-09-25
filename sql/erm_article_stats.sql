SELECT
  a.object_nid,
title,
alias as url,
type, 
read_count,
ifnull(is_helpful_yes, 0) is_helpful_yes,
ifnull(is_helpful_no, 0) is_helpful_no

FROM

( 
SELECT 
t.object_nid,
count(distinct t.event_actor_id) read_count
FROM
realign_etk_symfony.event_tracking t



where event like 'READ'

group by t.object_nid

) a

LEFT JOIN

(
SELECT 

object_nid,
sum((CASE WHEN is_helpful = 1 then 1 else 0 end)) is_helpful_yes, 
sum((CASE WHEN is_helpful = 0 then 1 else 0 end)) is_helpful_no 

FROM
realign_etk_symfony.event_actor_feedback f

group by object_nid

) b on a.object_nid=b.object_nid

LEFT JOIN
realign_etk_drupal.node n ON a.object_nid = n.nid
LEFT JOIN
realign_etk_drupal.url_alias u ON a.object_nid = substring_index(u.source, '/', - 1)