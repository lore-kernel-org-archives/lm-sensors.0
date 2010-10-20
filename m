From: Joe Perches <joe@perches.com>
Date: Wed, 20 Oct 2010 06:51:24 +0000
Subject: [lm-sensors] [PATCH 00/32] drivers/hwmon: Use pr_fmt and pr_<level>
Message-Id: <cover.1287556800.git.joe@perches.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101020035346.GA20178@ericsson.com>
In-Reply-To: <20101020035346.GA20178@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>, Guenter Roeck <guenter.roeck@ericsson.com>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

Just some message logging cleanups, now separated by file

Joe Perches (32):
  drivers/hwmon/abituguru.c: Use pr_fmt and pr_<level>
  drivers/hwmon/abituguru3.c: Use pr_fmt and pr_<level>
  drivers/hwmon/adt7470.c: Use pr_fmt and pr_<level>
  drivers/hwmon/applesmc.c: Use pr_fmt and pr_<level>
  drivers/hwmon/asb100.c: Use pr_fmt and pr_<level>
  drivers/hwmon/asus_atk0110.c: Use pr_fmt and pr_<level>
  drivers/hwmon/coretemp.c: Use pr_fmt and pr_<level>
  drivers/hwmon/dme1737.c: Use pr_fmt and pr_<level>
  drivers/hwmon/f71805f.c: Use pr_fmt and pr_<level>
  drivers/hwmon/f71882fg.c: Use pr_fmt and pr_<level>
  drivers/hwmon/hp_accel.c: Use pr_fmt and pr_<level>
  drivers/hwmon/hwmon-vid.c: Use pr_fmt and pr_<level>
  drivers/hwmon/hwmon.c: Use pr_fmt and pr_<level>
  drivers/hwmon/ibmaem.c: Use pr_fmt and pr_<level>
  drivers/hwmon/it87.c: Use pr_fmt and pr_<level>
  drivers/hwmon/lis3lv02d.c: Use pr_fmt and pr_<level>
  drivers/hwmon/lm70.c: Use pr_fmt and pr_<level>
  drivers/hwmon/lm78.c: Use pr_fmt and pr_<level>
  drivers/hwmon/pc87360.c: Use pr_fmt and pr_<level>
  drivers/hwmon/pc87427.c: Use pr_fmt and pr_<level>
  drivers/hwmon/pcf8591.c: Use pr_fmt and pr_<level>
  drivers/hwmon/pkgtemp.c: Use pr_fmt and pr_<level>
  drivers/hwmon/sis5595.c: Use pr_fmt and pr_<level>
  drivers/hwmon/smsc47b397.c: Use pr_fmt and pr_<level>
  drivers/hwmon/smsc47m1.c: Use pr_fmt and pr_<level>
  drivers/hwmon/via-cputemp.c: Use pr_fmt and pr_<level>
  drivers/hwmon/via686a.c: Use pr_fmt and pr_<level>
  drivers/hwmon/vt1211.c: Use pr_fmt and pr_<level>
  drivers/hwmon/vt8231.c: Use pr_fmt and pr_<level>
  drivers/hwmon/w83627ehf.c: Use pr_fmt and pr_<level>
  drivers/hwmon/w83627hf.c: Use pr_fmt and pr_<level>
  drivers/hwmon/w83781d.c: Use pr_fmt and pr_<level>

 drivers/hwmon/abituguru.c    |   36 ++++++++++++-------------
 drivers/hwmon/abituguru3.c   |   45 +++++++++++++------------------
 drivers/hwmon/adt7470.c      |    4 ++-
 drivers/hwmon/applesmc.c     |   60 +++++++++++++++++++-----------------------
 drivers/hwmon/asb100.c       |    9 +++---
 drivers/hwmon/asus_atk0110.c |    7 +++--
 drivers/hwmon/coretemp.c     |   11 ++++---
 drivers/hwmon/dme1737.c      |   12 ++++----
 drivers/hwmon/f71805f.c      |   29 +++++++++-----------
 drivers/hwmon/f71882fg.c     |   23 ++++++++-------
 drivers/hwmon/hp_accel.c     |   13 +++++----
 drivers/hwmon/hwmon-vid.c    |   11 ++++---
 drivers/hwmon/hwmon.c        |    4 ++-
 drivers/hwmon/ibmaem.c       |    4 ++-
 drivers/hwmon/it87.c         |   30 ++++++++++-----------
 drivers/hwmon/lis3lv02d.c    |   23 +++++++--------
 drivers/hwmon/lm70.c         |    5 ++-
 drivers/hwmon/lm78.c         |   14 +++++-----
 drivers/hwmon/pc87360.c      |   32 +++++++++-------------
 drivers/hwmon/pc87427.c      |   26 +++++++++---------
 drivers/hwmon/pcf8591.c      |    5 ++-
 drivers/hwmon/pkgtemp.c      |    7 +++--
 drivers/hwmon/sis5595.c      |   10 +++---
 drivers/hwmon/smsc47b397.c   |   13 ++++-----
 drivers/hwmon/smsc47m1.c     |   31 ++++++++++-----------
 drivers/hwmon/via-cputemp.c  |   10 +++---
 drivers/hwmon/via686a.c      |   10 +++---
 drivers/hwmon/vt1211.c       |   30 +++++++++------------
 drivers/hwmon/vt8231.c       |   10 +++---
 drivers/hwmon/w83627ehf.c    |   23 +++++++---------
 drivers/hwmon/w83627hf.c     |   17 +++++------
 drivers/hwmon/w83781d.c      |   29 ++++++++++----------
 32 files changed, 285 insertions(+), 308 deletions(-)

-- 
1.7.3.1.g432b3.dirty


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
