fields @timestamp, `HTTP Status`, `URL`
| filter (`URL` not like /http:\/\/[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+:.*/ and `URL` not like /https:\/\/[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+:.*/)
| stats count(*) as totalRequests by `URL`, `HTTP Status`
| sort `URL`, `HTTP Status`
| limit 100


| stats count(*) as totalRequests by `HTTP Status`, `HTTP Status` 
| sort `URL`, `HTTP Status` 
| limit 50

