SELECT

(CASE WHEN cs.uuid is not null then 1 else 0 end) cs_profiles,
(CASE WHEN re.uuid is not null then 1 else 0 end) re_profiles,
(CASE WHEN vjs.uuid is not null then 1 else 0 end) vjs_profiles,
(CASE WHEN erm.uuid is not null then 1 else 0 end) erm_profiles,
(CASE WHEN cs.uuid is null and re.uuid is null and vjs.uuid is null and erm.uuid is null then 1 else 0 end) no_profiles

FROM

Reporting_chamber.chamber_users cu

LEFT JOIN realign_career_spark.user cs on cs.uuid=cu.uuid
LEFT JOIN realign_hiring_our_heroes.user re on re.uuid=cu.uuid
LEFT JOIN realign_vjs.user vjs on vjs.uuid=cu.uuid
LEFT JOIN realign_etk_symfony.user erm on erm.uuid=cu.uuid
