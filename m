From: Paul Crawford <psc@sat.dundee.ac.uk>
Date: Sat, 01 Jun 2013 10:27:25 +0000
Subject: [lm-sensors] Module load order dependency
Message-Id: <51A9CC8D.2010105@sat.dundee.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I encountered a problem using the lm-sensors package along with the 
fancontrol package where the various drivers for the temperature sensing 
chips would be loaded in differing orders at boot time.

This leads to the abstracted paths of, for example, 
'/sys/class/hwmon/hwmon0' and '/sys/class/hwmon/hwmon1' changing places 
and the fancontrol package doing nothing as it believes the hardware is 
different or misconfigured.

This is also a risk for the Linux watchdog daemon that could be using 
such a path for temperature sensing (I added the capability recently to 
use lm-sensors outputs), leading to a far more irksome problem than 
simply full-speed fans!

Is this enumeration something that lm-sensors performs, or is it a 
kernel issue? As this appears to be quite important for actually using 
the capabilities, what can be done to fix it?

I added my crude solution (to make sure all of the modules are in 
/etc/modules, and not some auto-loaded and others explicitly added) to 
the bug report here:

https://bugs.launchpad.net/ubuntu/+source/lm-sensors-3/+bug/576602

Regards, Paul
-- 
  Dr. Paul S. Crawford
  c/o Satellite Station
  University of Dundee
  Small's Wynd, Dundee, DD1 4HN
  Email: psc@sat.dundee.ac.uk
  Tel: +44 (0)1382 38 4687
  The University of Dundee is a Scottish Registered Charity, No. SC015096

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
