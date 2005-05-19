From: rlasirona@snapserver.com (Lasirona, Robert)
Date: Thu, 19 May 2005 06:23:29 +0000
Subject: ServerWorks and Analog Device adm1024
Message-Id: <0084727E3D0ED611AA1400104B3FFD5A2ADC8D@cdserv.meridian-data.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greetings,

First of all I wanted to thank you guys for creating this package. I've used
it for the last year and it's been great. Up until now, I've been able to
use it without issues on other hardware.

I'm currently using lm_sensors2 v2.6.1 with kernel version 2.4.16. The
hardware I'm using is a ServerWorks 30LE OSB4 bus with an Analog Devices
adm1024 System Monitor.

We're only monitoring the system temperature, so the other values are extra.
What I'm currently experiencing is the value returned form temp1 is ~34 for
the first couple of hours . Then the temperature returned will change to
-127. The only way I've been able to recover the reading is to power down
the system. A soft reboot of the system doesn't recover the temperture
value.

From /proc/sys/dev/sensors/adm1024-i2c-0-2c I get returned: 60.0 50.0
-127.0.

I'm hoping that is has already been resolved and all I need a patch (It's
nice to hope).


Thanks!

Robert Lasirona
Linux Software Engineer
Quantum Inc.
2001 Logic Drive
San Jose, Ca 95124-3452
(408)879-8772
