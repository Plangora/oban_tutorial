defmodule ObanTutorial.Fixtures do
  alias ObanTutorial.Accounts

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{email: "test@test.com", password: "testpass"})
      |> Accounts.create_user()

    %{user | password: nil}
  end
end
