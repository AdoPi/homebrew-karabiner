cask "karabiner-elements@15.7" do
  version "15.7.0"
  sha256 "532d24e31c64af7de3f768f11210ffe8317486191d7fc69c53b96bde14da15ae"

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
