Unveiling insights with Elasticsearch

I like to be able to store everything in my database knowing that later on if I want to get information out of it, it won't be a problem, as long as it is designed correctly.

This is really never the case.  Even in postgres, there are times when you will need to denormalize data in order to make it performant.

I think that understanding a technology is built from using it.  And the more you extend that, the more you understand it.  In this talk I want to impart some understanding into why you would choose certain approaches.

For our working example, let's try to build a real estate index.

Example question:
- What if we want to find a house with 2 bedrooms and combined sqft of 200 for these bedrooms?

Can do the 




I want to explore how you can use Elastic to find information from your dataset.

The goal database is extract information at a later time.
Some databases are pretty simple like say S3, which just tells you what you gave it.  It's a key/value store.
Some database technologies allow you extract insights out of the data, especially from the aggregate.
Ex use cases:
- Recommendation engines
- Anomalies/Errors
- Optimization


Start off with fairly simple cases:
- Find all logs in a date range with 500 errors
- Find max timeframe of 500 errors


#This will cause an error
POST /.ds-kibana_sample_data_logs-2023.06.19-000001/_search
{
  "size": 0,
  "aggs": {
    "rates": {
      "filter": {
        "range": {
          "response": {
            "gte": 500
          }
        }
      },
      "aggs": {
        "histo": {
          "date_histogram": {
            "field": "@timestamp",
            "calendar_interval": "minute",
            "order": {
              "_count": "desc"
            }
          }
        }
      }
    }
  }
}

#This will work
POST /.ds-kibana_sample_data_logs-2023.06.19-000001/_search
{
  "size": 0,
  "aggs": {
    "rates": {
      "filter": {
        "range": {
          "response": {
            "gte": 500
          }
        }
      },
      "aggs": {
        "histo": {
          "date_histogram": {
            "field": "@timestamp",
            "calendar_interval": "hour",
            "order": {
              "_count": "desc"
            }
          }
        }
      }
    }
  }
}




Move to a different thing, with more complex stuff:
- Figure out how much will I be making in 5 days? -- get moving average.
- Are there any repeat buyers? -- aggregate on user?
- Are there buyers that are buying similar things?  -- lots of interesting things, extra work.


Can you find logical anomalies?
- Is request date > order date?

Maybe there are similarities between users.  Let's see if we can update the schema to include 






Other cool features:
* Point in time
* Async search




Let's see how elastic handles this use case.
- What if we want to find a house with 2 bedrooms and combined sqft of 200 for these bedrooms?
