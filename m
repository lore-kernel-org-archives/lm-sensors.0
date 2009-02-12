From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 12 Feb 2009 13:08:42 +0000
Subject: [lm-sensors] Next version of lm-sensors 3
Message-Id: <20090212140842.42c28d88@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

It's been quite some time since lm-sensors 3.0.3 was released (end of
September 2008, that's 4.5 months ago) and I think it's about time to
push a new release out. Given the number of big changes in the upcoming
release I plan to renumber it from 3.0.4 to 3.1.0.

The major changes in this release will be:
* Completely reworked sensors-detect. Support for Linux 2.4 was
  dropped, devices probe order was reverted (integrated sensors first,
  I2C/SMBus chips last), bus driver names are retrieved from sysfs, bus
  number prediction was fixed, modules we loaded ourselves are unloaded.
  The script is significantly smaller, and smarter.
* Improvements to libsensors. Circular dependencies in the
  configuration file are detected and dealt with, and more importantly,
  support for multiple configuration files was (well, is being) added.
  This is an important step in the direction of automatic lm-sensors
  configuration. Also some performance and memory usage improvements.
  Support for instantaneous power sensors and current sensors.
* The format of /etc/sysconfig/lm_sensors was changed. The new format
  is easier to edit, which will ease integration with external tools.
* New default sensors.conf file. Much lighter, with only always-correct
  statements. Big performance boost, and hopefully less confusion for
  the user.
* And as usual, random fixes to all tools.

As some of these changes are pretty intrusive, I expect some problems.
This release will require some serious testing. The proposed version
number (3.1.0) hopefully reflects this.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
