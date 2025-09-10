# kanata-sketchybar

Reflects the current kanata layer on a Sketchybar widget.

## Running as a Daemon

To run `main.sh` automatically as a daemon:

1. Create a launchd plist file at `~/Library/LaunchAgents/com.kanata.sketchybar.plist`:
   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
   <plist version="1.0">
   <dict>
       <key>Label</key>
       <string>com.kanata.sketchybar</string>
       
       <key>ProgramArguments</key>
       <array>
           <string>/path/to/your/kanata-sketchybar/main.sh</string>
       </array>
       
       <key>RunAtLoad</key>
       <true/>
       
       <key>KeepAlive</key>
       <true/>
       
       <key>StandardOutPath</key>
       <string>~/Library/Logs/com.kanata.sketchybar.log</string>
       
       <key>StandardErrorPath</key>
       <string>~/Library/Logs/com.kanata.sketchybar.error.log</string>
       
       <key>WorkingDirectory</key>
       <string>/path/to/your/kanata-sketchybar</string>
       
       <key>EnvironmentVariables</key>
       <dict>
           <key>PATH</key>
           <string>/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin</string>
           <key>KANATA_PORT</key>
           <string>12345</string>
       </dict>
   </dict>
   </plist>
   ```

2. Make the script executable and load the daemon:
   ```bash
   chmod +x main.sh
   launchctl load ~/Library/LaunchAgents/com.kanata.sketchybar.plist
   ```

3. Manage the daemon:
   - Stop: `launchctl unload ~/Library/LaunchAgents/com.kanata.sketchybar.plist`
   - Start: `launchctl load ~/Library/LaunchAgents/com.kanata.sketchybar.plist`
   - Check status: `launchctl list | grep kanata`
