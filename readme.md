## Twitch Streamer Status — Xbar Plugin

This is an [Xbar](https://xbarapp.com) plugin that displays the live status of specific Twitch streamers using the Twitch API.

- Checks a predefined list of streamers and shows whether each one is currently live.
- If a streamer **is live**, it shows how long they've been streaming.
- If **not live**, it simply says so.
- Each update randomly picks one streamer from the list to display, rotating through them over time.
- Clicking the status message reveals the game currently being streamed.
- Supports streams longer than 24 hours.
- ✅ Time display issues at the end of the month have been fixed.

### Installation

1. Copy the plugin file into your Xbar plugins directory:

   ```bash
   cp streamer_is_live.7s.rb ~/Library/Application\ Support/xbar/plugins
Open Xbar (or download it here if you haven't already).
In the Xbar menu, click Refresh All to start the plugin.
Notes
Make sure you have enough free space in your macOS menu bar. If the menu bar is too full, Xbar plugins may not display correctly or at all.
This plugin requires access to the Twitch API. If needed, you can configure your client ID and secret within the script.
