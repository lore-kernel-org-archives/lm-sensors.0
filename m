From: James Webb <jrwebb56@gmail.com>
Date: Thu, 04 Apr 2013 02:24:07 +0000
Subject: [lm-sensors] IT8772E Test
Message-Id: <1365042247.19144.9.camel@janus>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Running a Dell XPS-8300
sensors-detect reports:
Found `ITE IT8772E Super IO Sensors'                        Success!
    (address 0xa30, driver `to-be-written')
Compiled standalone driver but either modprobe it87 or modprobe it87
force_id=0x8721 results in:
FATAL: Error inserting it87
(/lib/modules/3.8.5-gentoo/kernel/drivers/hwmon/it87.ko): Device or
resource busy

Any suggestions?

Willing to keep testing if given some clues.

Jim W.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
