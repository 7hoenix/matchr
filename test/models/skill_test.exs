defmodule Matchr.SkillTest do
  use Matchr.ModelCase

  alias Matchr.Skill

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Skill.changeset(%Skill{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Skill.changeset(%Skill{}, @invalid_attrs)
    refute changeset.valid?
  end
end
