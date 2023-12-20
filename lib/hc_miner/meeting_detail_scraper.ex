defmodule HcMiner.MeetingDetailScraper do
  @moduledoc """
  Given a URL to a meeting detail page, scrape the page for the meeting details
  """
  @example_url "https://harfordcountymd.new.swagit.com/videos/291838"

  def run() do
    run(@example_url)
  end

  def run(url) do
    %{
      transcript: transcript(url),
      agenda_pdf_url: agenda_pdf_url(url)
    }
  end

  defp transcript(url) do
    (url <> "/transcript")
    |> Crawly.fetch()
    |> Map.get(:body)
    |> String.trim()
  end

  def agenda_pdf_url() do
    agenda_pdf_url(@example_url)
  end

  def agenda_pdf_url(url) do
    url
    |> Crawly.fetch()
    |> Map.get(:body)
    |> Floki.parse_document!()
    |> Floki.find("#agendaframe")
    |> Floki.find("script")
    |> List.first()
    |> extract_source()
  end

  def extract_source({_, _, [script_string]}) do
    regex = ~r/src=\"(.*?)\"/

    Regex.scan(regex, script_string)
    |> Enum.at(1)
    |> List.last()
  end
end
