CREATE TABLE source
(
    eventIid             varchar ,
    sourceCountry        varchar
) WITH (
      'connector' = 'http-x'
      ,'url' = 'https://10.100.14.169/backend/ipt/eveNet/getTable'
      ,'intervalTime'= '3000'
       ,'method'='post'
        ,'dataSubject'= '${data.list}'
        ,'decode'= 'json'
        ,'body'= '[
              {
              "key": "data-raw",
              "value": "{\"searchObject\":[{\"conditionId\":\"create_time\",\"conditionValue\":[\"2023-08-01 00:00:00\",\"2023-08-21 10:17:18\"],\"type\":\"between\"}],\"pageSize\":20,\"pageNo\":1}",
              "type": "String"
              }
            ]'
        ,'header'='[
              {
                "key": "System-Authorization",
                "value": "eyJ0eXBlIjoiSldUIiwiYWxnIjoiSFM1MTIifQ.eyJzdWIiOiJhZG1pbiIsImV4cCI6MTY5MjYwMTg4MX0.VoHG9--ZLoHinW0PvRPzOEvL0Ctge_c_G0dLtYT75Lx2rWsktGbat3AU3zVY44jSgJ4i3i2fiDnub1h3BdrzFQ"
              },
              {
                "key": "Content-Type",
                "value": "application/json"
              }
            ]'
            ,'column'='[
              {
                "name": "eventIid",
                "type": "varchar"
              },
              {
                "name": "sourceCountry",
                "type": "varchar"
              }
            ]'
      );

CREATE TABLE sink
(
    eventIid             varchar ,
    sourceCountry        varchar
) WITH (
      'connector' = 'stream-x'
      );

insert into sink
select *
from source u;
