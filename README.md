# HcMiner
POC application to scrape data from the Harford County Government website and sort through it all.

# Database Design
Meetings: (date, detail_url, transcript, agenda_url)

# Pipeline Design
1. Create the Meetings
    1. detail_url must be unique
    1. if detail_url is taken, skip
    1. grab transcripts for each meeting
2. Summarize the meeting into a 1 pager
    1. Chunk the transcript into bite sized pieces and send to GPT
        1. Do this recursively, until you've distilled the meeting transcript to a one pager
        1. Pros: Easy
        1. Cons: Expensive
    2. Can we roll our own summarizer, either locally, or in the cloud using state of the art Mistral models?
        1. Apparently, more performant than GPT, especially when fine tuned for our use case
        1. Pros: (see above)
        1. Cons: hard, and potentially also expensive if running in the cloud.
3. Tag the meeting with Key Words
4. Index the meeting on Keywords

# User Stories
1. As a citizen, I want to search through county meetings by key word, transcript text, etc. so I can get a clear sense of what my county govt is working on (lol)
2. As a citizen, I want to have a conversation with my county government, so I can understand their public actions without searching their terrible website.
