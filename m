From: R.Marek@sh.cvut.cz (R.Marek@sh.cvut.cz)
Date: Thu, 26 May 2005 14:44:26 +0000
Subject: [lm-sensors] [PATCH 3/3] I2C documentation update
Message-Id: <20050526124229.32251.qmail@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

This patch adds information about available userspace utillities
for system health monitoring drivers.

Signed-Off-By: Rudolf Marek <r.marek@sh.cvut.cz>

Please apply. It should apply against 2.6.12-rc5 or -mm-.

Thanks,
Regards

Rudolf

diff -Naur e/Documentation/i2c/userspace-tools f/Documentation/i2c/userspace-tools
--- e/Documentation/i2c/userspace-tools	1970-01-01 01:00:00.000000000 +0100
+++ f/Documentation/i2c/userspace-tools	2005-05-24 22:21:45.000000000 +0200
@@ -0,0 +1,39 @@
+Introduction
+------------
+
+Most mainboards have sensor chips to monitor system health (like temperatures,
+voltages, fans speed). They are often connected through an I2C bus, but some
+are also connected directly through the ISA bus.
+
+The kernel drivers make the data from the sensor chips available in the /sys
+virtual filesystem. Userspace tools are then used to display or set or the 
+data in a more friendly manner.
+
+Lm-sensors
+----------
+
+Core set of utilites that will allow you to obtain health information,
+setup monitoring limits etc. You can get them on their homepage 
+http://www.lm-sensors.nu/ or as a package from your Linux distribution.
+
+If from website:
+Get lmsensors from project web site. Please note, you need only userspace 
+part, so compile with "make user_install" target.
+
+General hints to get things working:
+
+0) get lm-sensors userspace utils
+1) compile all drivers in I2C section as modules in your kernel
+2) run sensors-detect script, it will tell you what modules you need to load.
+3) load them and run "sensors" command, you should see some results.
+4) fix sensors.conf, labels, limits, fan divisors
+5) if any more problems consult FAQ, or documentation
+
+Other utilites
+--------------
+
+If you want some graphical indicators of system health look for applications 
+like: gkrellm, ksensors, xsensors, wmtemp, wmsensors, wmgtemp, ksysguardd,
+hardware-monitor
+
+If you are server administrator you can try snmpd or mrtgutils.
