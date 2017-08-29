defmodule ChatV6.Repo.Migrations.CreateMensajes do
  use Ecto.Migration

  def change do
    create table(:mensajes) do
      add :name, :string
      add :body, :string

      timestamps()
    end

  end
end
