From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 15 Dec 2008 12:51:13 +0000
Subject: [lm-sensors] Problem with:
Message-Id: <494652C1.8060506@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

I just realised there is an issue with the 
hwmon-f71882fg-11-separate-max-crit-alarm-and-beep.patch
patch.

It removes the temp#_alarm attributes (replacing them by temp#_max_alarm), 
which is fine for lm_sensors v3, but will cause a problem with lm_sensors v2, 
the "sensors" command from lm_sensors v2 will now give failed to read data for 
temp# for all 3 temps :(

So it looks like we are sorta stuck with our past mistake of not doing separate 
alarms.

We could do separate alarms like this:
temp#_alarm
temp#_crit_alarm

This will work with both libsensors and with "sensors" from both v2 and v3.

Regards,

Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
