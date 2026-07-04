cask "karabiner-elements@15.6" do
  version "15.6.0"
  sha256 "91bea73e33bfba68b12c32fce297f48ce034ba994bef12d44db233599ab16ea1"

  url "https://github.com/pqrs-org/Karabiner-Elements/releases/download/v#{version}/Karabiner-Elements-#{version}.dmg",
      verified: "github.com/pqrs-org/Karabiner-Elements/"
  name "Karabiner Elements"
  desc "Keyboard customiser"
  homepage "https://karabiner-elements.pqrs.org/"

  depends_on :macos

  pkg "Karabiner-Elements.pkg"

  binary "/Library/Application Support/org.pqrs/Karabiner-Elements/bin/karabiner_cli"

  uninstall early_script: {
              executable: "/Library/Application Support/org.pqrs/Karabiner-DriverKit-VirtualHIDDevice/scripts/uninstall/remove_files.sh",
              sudo:       true,
            },
            launchctl:    [
              "org.pqrs.karabiner.agent.karabiner_grabber",
              "org.pqrs.karabiner.agent.karabiner_observer",
              "org.pqrs.karabiner.karabiner_console_user_server",
              "org.pqrs.karabiner.karabiner_grabber",
              "org.pqrs.karabiner.karabiner_observer",
              "org.pqrs.karabiner.karabiner_session_monitor",
              "org.pqrs.karabiner.NotificationWindow",
            ],
            signal:       [
              ["TERM", "org.pqrs.Karabiner-Menu"],
              ["TERM", "org.pqrs.Karabiner-NotificationWindow"],
            ],
            script:       {
              executable: "/Library/Application Support/org.pqrs/Karabiner-Elements/uninstall_core.sh",
              sudo:       true,
            },
            pkgutil:      [
              "org.pqrs.Karabiner-DriverKit-VirtualHIDDevice",
              "org.pqrs.Karabiner-Elements",
            ],
            delete:       "/Library/Application Support/org.pqrs"

  zap trash: [
    "~/.config/karabiner",
    "~/.local/share/karabiner",
    "~/Library/Application Scripts/org.pqrs.Karabiner-VirtualHIDDevice-Manager",
    "~/Library/Application Support/Karabiner-Elements",
    "~/Library/Caches/org.pqrs.Karabiner-Elements.Updater",
    "~/Library/Containers/org.pqrs.Karabiner-VirtualHIDDevice-Manager",
    "~/Library/HTTPStorages/org.pqrs.Karabiner-Elements.Settings",
    "~/Library/Preferences/org.pqrs.Karabiner-Elements.Updater.plist",
  ]
end
