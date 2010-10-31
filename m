From: "Henrik Rydberg" <rydberg@euromail.se>
Date: Sun, 31 Oct 2010 07:50:26 +0000
Subject: [lm-sensors] [PATCH 0/8] hwmon: applesmc: Dynamic configuration
Message-Id: <1288511434-5662-1-git-send-email-rydberg@euromail.se>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>

The amount of machines supported by this driver has increased rapidly
over the past years, and the detailed driver support of the many
flavors is quickly becoming a problem.

This patchset introduces dynamic configuration by making the SMC
register set efficiently searchable, and fixes a number of outstanding
issues:

* Support for all new models since MacbookPro 6.
* Support for variable number of cpu sensors in the MacPros.
* Handles the odd temperature sensor types found on new models.
* Fixes minor read problems on many intermediate models.

The first patch is preparatory. The second patch adds the register
lookup cache. The third patch adds the dynamic temperature files, and
the fourth implements a new temperature register format. The fifth
patch makes the remaining features dynamically configured, and the
sixth patch sets up the fans dynamically. The seventh patch is purely
janitory, and the last patch updates the copyright.

As a side-effect, the file is reduced by almost five hundred lines.

Cheers,
Henrik

Henrik Rydberg (8):
  hwmon: applesmc: Relax the severity of device init failure
  hwmon: applesmc: Introduce a register lookup table
  hwmon: applesmc: Dynamic creation of temperature files
  hwmon: applesmc: Handle new temperature format
  hwmon: applesmc: Extract all features generically
  hwmon: applesmc: Dynamic creation of fan files
  hwmon: applesmc: Simplify feature sysfs handling
  hwmon: applesmc: Update copyright information

 drivers/hwmon/applesmc.c | 1542 ++++++++++++++++------------------------------
 1 files changed, 534 insertions(+), 1008 deletions(-)


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
