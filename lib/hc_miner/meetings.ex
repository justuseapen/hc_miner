defmodule HcMiner.Meetings do
  @moduledoc """
  This module is the context API for dealing with Meetings.
  """

  import Ecto.Query

  alias HcMiner.Meetings.Meeting
  alias HcMiner.Repo

  def create_meeting(attrs \\ %{}) do
    %Meeting{}
    |> Meeting.changeset(attrs)
    |> Repo.insert()
  end

  def scrape_meetings() do
    maps =
      HcMiner.CouncilIndexScraper.run()
      |> Enum.map(fn meeting_map ->
        {:ok, datetime} = Timex.parse(meeting_map.video_date, "%b %d, %Y", :strftime)
        date = Timex.to_date(datetime)

        now = DateTime.utc_now() |> DateTime.to_naive() |> NaiveDateTime.truncate(:second)

        %{
          agenda_url: meeting_map.agenda_url,
          date: date,
          detail_url: meeting_map.video_url,
          inserted_at: now,
          updated_at: now
        }
      end)

    Repo.insert_all(Meeting, maps)
  end

  def grab_transcripts do
    Meeting
    |> where([m], is_nil(m.transcript))
    |> Repo.all()
    |> Enum.each(fn meeting ->
      IO.inspect("Scraping transcript for #{meeting.detail_url}")

      %{transcript: transcript} =
        HcMiner.MeetingDetailScraper.run(meeting.detail_url)
        |> IO.inspect(label: "MeetingDetailScraper.run(#{meeting.detail_url})")

      meeting
      |> Meeting.changeset(%{transcript: transcript})
      |> Repo.update()
    end)
  end

  # Summarize the meeting transcript by calling our Summarizer API
  # Tag the meeting by calling the Tag API on the transcript
end
