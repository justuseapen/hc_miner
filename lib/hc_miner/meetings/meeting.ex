defmodule HcMiner.Meetings.Meeting do
  use Ecto.Schema
  import Ecto.Changeset

  schema "meetings" do
    field(:agenda_url, :string)
    field(:date, :date)
    field(:detail_url, :string)
    field(:transcript, :string)

    timestamps()
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:agenda_url, :date, :detail_url, :transcript])
    |> validate_required([:detail_url])
    |> unique_constraint(:detail_url)
  end
end
