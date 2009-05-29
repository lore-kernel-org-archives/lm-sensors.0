From: Hans de Goede <hdegoede@redhat.com>
Date: Fri, 29 May 2009 09:05:52 +0000
Subject: [lm-sensors] PATCH [0/4]: hwmon: Add f71858fg support to the
Message-Id: <4A1FA570.4010500@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Can you please review this set and queue it for 2.6.31 ?
Thanks.

This set contains the following patches, the first 2 are
preparation patches for adding the f71858fg support ,
the 3th one is a bugfix to the f8000 support which I noticed
while working on this and the last one is the actual
f71858fg support:

hwmon: f71882fg cleanup f8000 pwm handling
hwmon: f71882fg sanity check f8000 pwm settings
hwmon: f71882fg add temp#_fault sysfs attr for f8000
hwmon: f71882fg add support for the f71858fg

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
