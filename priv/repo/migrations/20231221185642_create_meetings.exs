defmodule HcMiner.Repo.Migrations.CreateMeetings do
  use Ecto.Migration

  def change do
    create table(:meetings) do
      add :agenda_url, :string
      add :date, :date
      add :detail_url, :string, null: false
      add :transcript, :text

      timestamps()
    end
  end
end
