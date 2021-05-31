local utils = require "mp.utils"


function notify_current_media()
    os.execute("/usr/local/bin/mpv-notify")
end

mp.register_event("file-loaded", notify_current_media)
