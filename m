From: admin@tolien.co.uk ('Mr Admin')
Date: Thu, 19 May 2005 06:25:11 +0000
Subject: Ticket 1751
Message-Id: <200408121858.i7CIw0KW013198@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Problem in detail:
On installing lm-sensors with apt-get, CPU temp flies up to 85?C, both in
the
output of sensors and in /sys/bus/i2c/devices/...
Removing lm-sensors, and running with just the modules required for i2c, the
correct values are shown.
Reply from support:
You don?t provide much information about your system and exact problem you
see.
I  guess that your monitoring chip is a Winbond W83627THF, and you must be
using
the w83627hf driver that comes with your (vanilla?) 2.6.7 kernel.

We would need to know what exactly you did to alter the readins. Installing
lm-sensors doesn?t do anything per se, and running "sensors" without
additional
argument doesn?t do much either. On the other hand, running "sensors -s" may
change values, although normally only limit values, not readings. A call to
"sensors -s" may be part of your system init steps, so it may have been
called
even if you didn?t call it manually.

Please contact the mailing-list (sensors at stimpy.netroedge.com) and detail
your problem:
 * What are the values when everything is fine.
 * Which exact action breaks the values.
 * What are the values when not OK.
Reference your ticket number.

Thanks.

Khali 2004-08-12


When everything is fine, CPU and MB temps move up and down with load as
expected (and as confirmed by the BIOS).
The only required action to break the values appears to be installing
lm-sensors by apt-get install (which I'd guess runs sensors-detect) -
removing lm-sensors, and running only the w83627hf kernel module (ie without
lm_sensors) provides the "correct" (in the sense of more valid anyway)
values. When broken, the CPU temp locks itself at 85.0?C, and doesn't shift
whatsoever.
Sensors -s doesn't help anything.


