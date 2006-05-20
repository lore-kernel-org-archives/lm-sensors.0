From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Sat, 20 May 2006 12:15:25 +0000
Subject: [lm-sensors] Question about the new sysfs alarm interface
Message-Id: <446F085D.6040907@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <446D7AD5.2080405@hhs.nl>
In-Reply-To: <446D7AD5.2080405@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

When I was talking about my second mail on this subject in my last mail
(which was actually the second one which you received) I meant this
mail, which I accidentally send to myself instead of to the list <sigh>.

A bit outdated now I guess.

Hans de Goede wrote:
> Hi all,
> 
> I've finally made the time to convert the abituguru driver to the new
> alarm sysfs interface however the uguru has 2 alarms for each voltage
> input, a volt low and a volt low alarm, currently I create the following
> for these:
> in0_alarm_low
> in0_alarm_high
> 
> I was thinking that for compatibility with apps which just expect an
> alarm file as documented in the new standard to add:
> in0_alarm
> 
> Which will contain an alarm if either of the 2 above alarms happens. I
> personally find this a good idea of mine, but i just wanted to check to
> make sure.
> 
> 
> Also the uguru has the ability do disable alarms on a certain input.
> This way you can silence a certain input and make it not report any
> alarms which might upset monitoring scripts etc.
> 
> I currently have added the following enntries for these:
> in0_alarm_low_enable
> in0_alarm_high_enable
> temp1_alarm_enable
> fan1_alarm_enable
> 
> And I could, but I'm not so sure about that one, seems overkill add a:
> in0_alarm_enable
> which then can be used to disable/enable both alarms at once and will
> show alarms enabled if one of or both the alarms are enabled.
> 
> I personally think this is ugly, but it would be somewhat consistent,
> then again a monitor app may expect in0_alarm, so I really think I
> should add that. But I think that generic apps shouldn't touch the
> _enable files and leave that to the sysadmin.
> 
> Regards,
> 
> Hans
> 
> 

Replying to my own question my question was based on the
Documentation/hwmon/sysfs-interface patch by Rudolf Marek posted on 15
May 2006. However in my archives I also found a (somewhat more complete)
patch by Jean Delvare on this subject:
http://khali.linux-fr.org/devel/i2c/linux-2.6/hwmon-sysfs-interface-individual-alarm-files.patch

This patch describes how todo per treshold alarms and that one should
either implement per treshold alarms or a per channel alarm, not both as
 I was suggesting. I'm going todo thing as described in Jean's patch for
now even though Rudolf's patch is newer as Jean's is more complete and
where they do overlap they don't seem to contradict eachother.

This only leaves the question howto export the disable (per treshold)
alarm functionality for now I'm going for <alarm file>_enable, so that
would be:
in0_min_alarm_enable
in0_max_alarm_enable
temp1_alarm_enable
fan1_alarm_enable

Regards,

Hans


