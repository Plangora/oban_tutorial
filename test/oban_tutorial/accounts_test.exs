defmodule ObanTutorial.AccountsTest do
  use ObanTutorial.DataCase, async: true

  alias ObanTutorial.{Accounts, Fixtures}
  alias Accounts.User

  describe "users" do
    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} =
               Accounts.create_user(%{email: "test@test.com", password: "testpass"})

      assert user.email == "test@test.com"
      assert user.password_digest != nil
      assert_enqueued(worker: Accounts.Jobs.WelcomeEmail, queue: :default, args: %{"email" => "test@test.com"})
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(%{email: nil, password: nil})
      refute_enqueued(worker: Accounts.Jobs.WelcomeEmail)
    end
  end

  describe "user created" do
    setup do: {:ok, user: Fixtures.user_fixture()}

    test "list_users/0 returns all users", %{user: user} do
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id", %{user: user} do
      assert Accounts.get_user!(user.id) == user
    end

    test "update_user/2 with valid data updates the user", %{
      user: %{password_digest: pass_hash} = user
    } do
      assert {:ok, %User{} = user} =
               Accounts.update_user(user, %{
                 email: "updated@email.com",
                 password: "updated_password"
               })

      assert user.email == "updated@email.com"
      assert user.password_digest != pass_hash
    end

    test "update_user/2 with invalid data returns error changeset", %{user: user} do
      assert {:error, %Ecto.Changeset{}} =
               Accounts.update_user(user, %{email: nil, password: nil})

      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user", %{user: user} do
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset", %{user: user} do
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
