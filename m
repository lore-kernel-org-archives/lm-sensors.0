From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Fri, 19 May 2006 07:59:17 +0000
Subject: [lm-sensors] Question about the new sysfs alarm interface
Message-Id: <446D7AD5.2080405@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I've finally made the time to convert the abituguru driver to the new
alarm sysfs interface however the uguru has 2 alarms for each voltage
input, a volt low and a volt low alarm, currently I create the following
for these:
in0_alarm_low
in0_alarm_high

I was thinking that for compatibility with apps which just expect an
alarm file as documented in the new standard to add:
in0_alarm

Which will contain an alarm if either of the 2 above alarms happens. I
personally find this a good idea of mine, but i just wanted to check to
make sure.


Also the uguru has the ability do disable alarms on a certain input.
This way you can silence a certain input and make it not report any
alarms which might upset monitoring scripts etc.

I currently have added the following enntries for these:
in0_alarm_low_enable
in0_alarm_high_enable
temp1_alarm_enable
fan1_alarm_enable

And I could, but I'm not so sure about that one, seems overkill add a:
in0_alarm_enable
which then can be used to disable/enable both alarms at once and will
show alarms enabled if one of or both the alarms are enabled.

I personally think this is ugly, but it would be somewhat consistent,
then again a monitor app may expect in0_alarm, so I really think I
should add that. But I think that generic apps shouldn't touch the
_enable files and leave that to the sysadmin.

Regards,

Hans


