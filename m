From: jrickman@myamigos.us
Date: Sun, 22 Nov 2009 06:58:36 +0000
Subject: [lm-sensors] "modprobe coretemp" fails in Fedora Core 12
Message-Id: <1414.66.169.133.216.1258873116.squirrel@webmail.myamigos.us>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

When running "modprobe coretemp" in Fedora Core 12, the module fails to load.

Output from /var/log/messages:
Nov 22 00:30:15 acer-nas-01 kernel: i2c /dev entries driver
Nov 22 00:30:20 acer-nas-01 kernel: coretemp: Unknown CPU model 1c
Nov 22 00:30:20 acer-nas-01 kernel: coretemp: Unknown CPU model 1c
Nov 22 00:33:15 acer-nas-01 kernel: coretemp: Unknown CPU model 1c
Nov 22 00:33:15 acer-nas-01 kernel: coretemp: Unknown CPU model 1c

Server is Acer H340 NAS with Intel Atom 230 CPU. Also tested on SuperMicro
MBD-X7SLA-H-O motherboard with Atom 330 CPU.

Both systems have the following files loaded:
lm_sensors.x86_64              3.1.1-4.fc12
lm_sensors-libs.x86_64         3.1.1-4.fc12

Is there a solution to this problem?

Is more info needed to diagnose this problem?



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
