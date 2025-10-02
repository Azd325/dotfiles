{ username, userHome, ... }:
{
  users.users.${username}.home = userHome;
}
