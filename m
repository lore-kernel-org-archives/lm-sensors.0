From: Martin Herrman <martin.herrman@gmail.com>
Date: Mon, 20 Jan 2014 11:04:14 +0000
Subject: [lm-sensors] Notification system
Message-Id: <CADR1r6gsbZbZmYWswMVR6M2tMwe3MbojEEWEdvtjXgzPJCk0CA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

All,

now that I have my temperatures monitored, I'm looking for a system to
do something with this information.

Some thoughts:
- trigger action when temperatures/fan-speeds are at warning-level
- trigger action when temperatures/fan-speeds are at error-level
- trigger action can be: log warning to syslog, send mail, show
message on display (HTPC), kill process(es) that uses most CPU, start
custom shell script, decrease cpu speed, shutdown system, ..
- store measurements in database (also add e.g. cpu usage) and create
nice graphs for trend analysis

A cron job with some custom shell scripting (that only fulfills my
personal requirements) might do, but first I want to search for
something I can re-use.

What I found:
- psensors, can show notification on screen (only when using Unity?)
http://wpitchoune.net/blog/psensor/
- opsview (nagios fork?)
http://www.opsview.com/whats-new/blog/monitoring-server-temperature

Both are not really what I want.. psensors is quite limited and I
could easily miss a pop-up when xbmc or steam is running, while
opsview/nagios is designed for large companies and not for personal
use.

Do you know any other solution that might fit my purpose?

Second question: if something has to be made, a cron job starting
sensors might not be optimal (although the load will be acceptable on
a desktop machine). Should it be written against the libsensors
library, or should it really be a notification initiated by sensors
daemon itself?

Regards,

Martin

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
