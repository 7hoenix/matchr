defmodule Matchr.UserSkillController do
  use Matchr.Web, :controller

  alias Matchr.UserSkill

  def index(conn, _params) do
    user_skills = Repo.all(UserSkill)
    render(conn, "index.json", user_skills: user_skills)
  end

  def create(conn, %{"user_skill" => user_skill_params}) do
    changeset = UserSkill.changeset(%UserSkill{}, user_skill_params)

    case Repo.insert(changeset) do
      {:ok, user_skill} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", user_skill_path(conn, :show, user_skill))
        |> render("show.json", user_skill: user_skill)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Matchr.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user_skill = Repo.get!(UserSkill, id)
    render(conn, "show.json", user_skill: user_skill)
  end

  def update(conn, %{"id" => id, "user_skill" => user_skill_params}) do
    user_skill = Repo.get!(UserSkill, id)
    changeset = UserSkill.changeset(user_skill, user_skill_params)

    case Repo.update(changeset) do
      {:ok, user_skill} ->
        render(conn, "show.json", user_skill: user_skill)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Matchr.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user_skill = Repo.get!(UserSkill, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(user_skill)

    send_resp(conn, :no_content, "")
  end
end
