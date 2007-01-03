From: Info@nsr.ru (Nameserver.ru)
Date: Wed, 03 Jan 2007 19:36:24 +0000
Subject: [lm-sensors] w83627ehf module floods log file
Message-Id: <200701032236.24178@goldspace.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have noticed the w83627ehf module (with patch to support DHG) floods
/var/log/messages this way:

...
Jan  3 21:54:40 anli w83627ehf 9191-0290: Increasing fan 4 clock divider from 4 to 8
Jan  3 21:54:43 anli w83627ehf 9191-0290: Increasing fan 4 clock divider from 4 to 8
Jan  3 21:54:46 anli w83627ehf 9191-0290: Increasing fan 4 clock divider from 4 to 8
Jan  3 21:54:49 anli w83627ehf 9191-0290: Increasing fan 4 clock divider from 4 to 8
Jan  3 21:59:28 anli w83627ehf 9191-0290: Increasing fan 4 clock divider from 4 to 8
Jan  3 21:59:31 anli w83627ehf 9191-0290: Increasing fan 4 clock divider from 4 to 8
Jan  3 21:59:34 anli w83627ehf 9191-0290: Increasing fan 4 clock divider from 4 to 8
Jan  3 21:59:37 anli w83627ehf 9191-0290: Increasing fan 4 clock divider from 4 to 8
Jan  3 21:59:40 anli w83627ehf 9191-0290: Increasing fan 4 clock divider from 4 to 8
...

You see, every 3 seconds the module generates new message. Is it possible to
suppress this logging?

