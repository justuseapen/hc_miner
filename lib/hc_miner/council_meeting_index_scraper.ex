defmodule CouncilMeetingIndexScraper do
  use Crawly.Spider

  @impl Crawly.Spider
  def base_url(), do: "https://harfordcountymd.new.swagit.com/views/369/"

  @impl Crawly.Spider
  def init() do
    [start_urls: ["https://harfordcountymd.new.swagit.com/views/369/"]]
  end

  @impl Crawly.Spider
  def parse_item(response) do
    {:ok, document} = Floki.parse_document(response.body)

    items =
      document
      |> Floki.find(".videos")
      |> Floki.find("tbody")
      |> Floki.find("tr")
      |> Enum.map(fn row ->
        %{
          video_url: extract_video_url(row),
          video_date: extract_video_date(row),
          video_length: extract_video_length(row),
          agenda_url: extract_agenda_url(row)
        }
      end)

    %{items: items}
  end

  defp extract_video_url(row) do
    row
    |> Floki.find("td:nth-child(4) a:first-child")
    |> Floki.attribute("href")
    |> List.first()
  end

  defp extract_video_date(row) do
    row
    |> Floki.find("td:nth-child(2)")
    |> Floki.text()
    |> String.trim()
  end

  defp extract_video_length(row) do
    row
    |> Floki.find("td:nth-child(3)")
    |> Floki.text()
    |> String.trim()
  end

  defp extract_agenda_url(row) do
    row
    |> Floki.find("td:nth-child(4) a:nth-child(2)")
    |> Floki.attribute("href")
    |> List.first()
  end
end
