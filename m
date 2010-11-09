From: "Henrik Rydberg" <rydberg@euromail.se>
Date: Tue, 09 Nov 2010 15:15:00 +0000
Subject: [lm-sensors] [PATCH 00/11] hwmon: applesmc: Dynamic configuration
Message-Id: <1289315711-3011-1-git-send-email-rydberg@euromail.se>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>, Jean Delvare <khali@linux-fr.org>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>

This is revision two of the applesmc makeover. All comments from
Guenter have been addressed. In this set, I have put the candidates
for stable first, therefore the patch from Joe is also included (with
one hunk removed).  There is also one additional janitory patch at the
end, saluting the silent kernel.

Regarding the changes, there should be no big surprises. The comment
about reading six and using five was particularly useful; it turns out
the missing byte is a useful attribute field. Thanks!

The patches are available in the applesmc-dkms package, and are
already in use by a measurable portion of the mactel users.

Cheers,
Henrik

Edgar Hucek (1):
  hwmon: applesmc: Add MacBookAir3,1(3,2) support

Henrik Rydberg (9):
  hwmon: applesmc: Relax the severity of device init failure (rev2)
  hwmon: applesmc: Introduce a register lookup table (rev2)
  hwmon: applesmc: Dynamic creation of temperature files (rev2)
  hwmon: applesmc: Handle new temperature format (rev2)
  hwmon: applesmc: Extract all features generically (rev2)
  hwmon: applesmc: Dynamic creation of fan files (rev2)
  hwmon: applesmc: Simplify feature sysfs handling (rev2)
  hwmon: applesmc: Silence driver
  hwmon: applesmc: Update copyright information

Joe Perches (1):
  drivers/hwmon/applesmc.c: Use pr_fmt and pr_<level>

 drivers/hwmon/applesmc.c | 1591 ++++++++++++++++------------------------------
 1 files changed, 549 insertions(+), 1042 deletions(-)


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
