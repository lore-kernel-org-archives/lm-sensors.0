From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Mon, 20 Oct 2008 07:08:18 +0000
Subject: Re: [lm-sensors] f71882fg-* How do you set temp limits for max_hyst
Message-Id: <48FC2E62.3070101@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <48FBFF2A.608@suddenlinkmail.com>
In-Reply-To: <48FBFF2A.608@suddenlinkmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

David C. Rankin wrote:
> sensor Devs,
> 
> 	I have an MSI K9N2 SLI Platinum board that has the f71882fg- chip. I am unable
> to set the tempX_max_hyst and tempX_crit_hyst temperature limits with
> sensors-3.0.2-4.1. Attempting to set the values results in the normal error
> messages on sensors -s:
> 
> Error: Line 70: Unknown feature name
> Error: Line 71: Unknown feature name
> 

<snip>

>     set temp1_max_hyst 50
>     set temp1_max 55
>     set temp1_crit_hyst 56
>     set temp1_crit 60
>     set temp2_max_hyst 50
>     set temp2_max 55
>     set temp2_crit_hyst 56
>     set temp2_crit 60
> 
> 	However, all of the _hyst settings result in the errors explained above. So,
> how do you set the hyst limits with this chipset?
> 

Erm, that should work. What does ls /sys/class/hwmon/hwmon*/device show ?

If there are temp#_max_hyst files there try:
echo -n 56000 > /sys/class/hwmon/hwmon#/device/temp#_max_hyst

Note that the hysteresis is shared between max and crit, so only the 
temp#_max_hyst attributes are writable the temp#_crit_hyst attributes are readonly.

If the echo works and your sensors.conf still gives errors after removing the 
set statements for temp#_crit_hyst, we probably have a bug in libsensors or 
sensors somewhere.

> 	If you need additional information, please just ask and I'll be glad to
> provide it. Also, I tried enabling temp3 and that resulted in a wild value of
> 127 deg.C which is way off-scale high. Any ideas what this sensor does?

127 looks like not connected to me, I would expect the output of "sensors" to 
give a FAULT as reading for that sensors, what does:
cat /sys/class/hwmon/hwmon#/device/temp3_fault
Give as output?

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
