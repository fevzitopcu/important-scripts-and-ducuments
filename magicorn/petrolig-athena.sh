SELECT
    time,
    request_verb,
    request_url,
    (request_processing_time + target_processing_time + response_processing_time) AS total_response_time
FROM
    "default"."alb_logs"
WHERE
    elb_status_code = 200
    AND parse_datetime(time, 'yyyy-MM-dd''T''HH:mm:ss.SSSSSS''Z') BETWEEN TIMESTAMP '2024-05-22 11:00:00' AND TIMESTAMP '2024-05-22 11:10:59'
ORDER BY
    total_response_time DESC
LIMIT 20;

####################################33
SELECT
    time,
    request_verb,
    request_url,
    request_processing_time,
    target_processing_time,
    response_processing_time,
    (request_processing_time + target_processing_time + response_processing_time) AS total_response_time
FROM
    "default"."alb_logs"
WHERE
    elb_status_code = 200
    AND parse_datetime(time, 'yyyy-MM-dd''T''HH:mm:ss.SSSSSS''Z') BETWEEN TIMESTAMP '2023-05-22 11:00:00' AND TIMESTAMP '2024-05-22 11:10:59'

ORDER BY
    total_response_time DESC
LIMIT 20;

##############

fields @timestamp, "HTTP Method", `URL`,`HTTP Status`, `Request Time`, `Backend Time`, `Response Time`
| filter `HTTP Status` = 200
| stats (`Request Time`+ `Backend Time`+ `Response Time`) as total_response_time by @timestamp ,`HTTP Method`, `URL`, `Request Time`, `Backend Time`, `Response Time`
| sort total_response_time desc
| limit 20


fields @timestamp, "HTTP Method", `URL`,`HTTP Status`, `Request Time`, `Backend Time`, `Response Time`
| filter `HTTP Status` = 200
| filter (`URL` like 'https://api.sosyallig.com:')
| stats (`Request Time`+ `Backend Time`+ `Response Time`) as total_response_time by @timestamp ,`HTTP Method`,`HTTP Status`, `URL`, `Request Time`, `Backend Time`, `Response Time`
| sort total_response_time desc
| limit 20
