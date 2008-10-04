From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 04 Oct 2008 19:38:59 +0000
Subject: Re: [lm-sensors] kernel 2.6.27-rc8-git6 system lockup possibly
Message-Id: <20081004213859.4e576df5@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <f4527be0810041027r490a27e5u44575bcf6af92a7e@mail.gmail.com>
In-Reply-To: <f4527be0810041027r490a27e5u44575bcf6af92a7e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Andrew,

On Sat, 4 Oct 2008 18:27:04 +0100, Andrew Lyon wrote:
> Hi,
> 
> I am running kernel 2.6.27-rc8-git6 on a supermicro x7dwa-n system, I
> have w83793, coretemp, and i5k_amb sensor modules loaded, occasionally
> the system locks up hard requiring reset button to reboot it, this
> usually happens after a few days of uptime and has never happened less
> than 24 hours after bootup,  I have sensord running and noticed today
> that the log output changes just before it locks up, which makes me
> wonder if reading the sensors is the cause...
> 
> The board has 8 fan connections of which 5 are currently used, the
> w83793 sensors show 10 fan outputs, I plan to add 2 more fans next
> week as the hot swap drive bay has slots for 4 but only comes with 2,
> I have not disabled any of the fan sensors in the config file so every
> minute sensord logs alarms for the unused fans:

For what it's worth, this would be easily avoided by adding
"set fanX_min 0" statements to your configuration file for unused fans.

> 
> Oct  4 16:34:06 supermicro sensord: Sensor alarm: Chip
> w83793-i2c-0-2f: fan9: 0 RPM (min = 712 RPM) [ALARM]
> Oct  4 16:34:06 supermicro sensord: Sensor alarm: Chip
> w83793-i2c-0-2f: fan10: 0 RPM (min = 712 RPM) [ALARM]
> Oct  4 16:35:07 supermicro sensord: Sensor alarm: Chip
> w83793-i2c-0-2f: fan1: 0 RPM (min = 712 RPM) [ALARM]
> Oct  4 16:35:07 supermicro sensord: Sensor alarm: Chip
> w83793-i2c-0-2f: fan4: 0 RPM (min = 712 RPM) [ALARM]
> Oct  4 16:35:07 supermicro sensord: Sensor alarm: Chip
> w83793-i2c-0-2f: fan5: 0 RPM (min = 712 RPM) [ALARM]
> Oct  4 16:35:07 supermicro sensord: Sensor alarm: Chip
> w83793-i2c-0-2f: fan9: 0 RPM (min = 712 RPM) [ALARM]
> Oct  4 16:35:07 supermicro sensord: Sensor alarm: Chip
> w83793-i2c-0-2f: fan10: 0 RPM (min = 712 RPM) [ALARM]
> Oct  4 16:36:07 supermicro sensord: Sensor alarm: Chip
> w83793-i2c-0-2f: fan1: 0 RPM (min = 712 RPM) [ALARM]
> Oct  4 16:36:07 supermicro sensord: Sensor alarm: Chip
> w83793-i2c-0-2f: fan4: 0 RPM (min = 712 RPM) [ALARM]
> Oct  4 16:36:07 supermicro sensord: Sensor alarm: Chip
> w83793-i2c-0-2f: fan5: 0 RPM (min = 712 RPM) [ALARM]
> Oct  4 16:36:07 supermicro sensord: Sensor alarm: Chip
> w83793-i2c-0-2f: fan9: 0 RPM (min = 712 RPM) [ALARM]
> Oct  4 16:36:07 supermicro sensord: Sensor alarm: Chip
> w83793-i2c-0-2f: fan10: 0 RPM (min = 712 RPM) [ALARM]
> Oct  4 16:37:07 supermicro sensord: Sensor alarm: Chip
> w83793-i2c-0-2f: fan1: 0 RPM (min = 712 RPM) [ALARM]
> Oct  4 16:37:07 supermicro sensord: Sensor alarm: Chip
> w83793-i2c-0-2f: fan4: 0 RPM (min = 712 RPM) [ALARM]
> Oct  4 16:37:07 supermicro sensord: Sensor alarm: Chip
> w83793-i2c-0-2f: fan5: 0 RPM (min = 712 RPM) [ALARM]
> Oct  4 16:37:07 supermicro sensord: Sensor alarm: Chip
> w83793-i2c-0-2f: fan9: 0 RPM (min = 712 RPM) [ALARM]
> Oct  4 16:37:07 supermicro sensord: Sensor alarm: Chip
> w83793-i2c-0-2f: fan10: 0 RPM (min = 712 RPM) [ALARM]
> Oct  4 16:38:08 supermicro sensord: Sensor alarm: Chip
> w83793-i2c-0-2f: fan1: 0 RPM (min = 712 RPM) [ALARM]
> Oct  4 16:38:08 supermicro sensord: Sensor alarm: Chip
> w83793-i2c-0-2f: fan4: 0 RPM (min = 712 RPM) [ALARM]
> Oct  4 16:38:08 supermicro sensord: Sensor alarm: Chip
> w83793-i2c-0-2f: fan5: 0 RPM (min = 712 RPM) [ALARM]
> Oct  4 16:38:08 supermicro sensord: Sensor alarm: Chip
> w83793-i2c-0-2f: fan9: 0 RPM (min = 712 RPM) [ALARM]
> Oct  4 16:38:08 supermicro sensord: Sensor alarm: Chip
> w83793-i2c-0-2f: fan10: 0 RPM (min = 712 RPM) [ALARM]
> Oct  4 16:39:10 supermicro sensord: Sensor alarm: Chip
> w83793-i2c-0-2f: fan1: 0 RPM (min = 712 RPM) [ALARM]
> Oct  4 16:39:10 supermicro sensord: Sensor alarm: Chip
> w83793-i2c-0-2f: fan4: 0 RPM (min = 712 RPM) [ALARM]
> Oct  4 16:39:10 supermicro sensord: Sensor alarm: Chip
> w83793-i2c-0-2f: fan5: 0 RPM (min = 712 RPM) [ALARM]
> Oct  4 16:39:10 supermicro sensord: Sensor alarm: Chip
> w83793-i2c-0-2f: fan9: 0 RPM (min = 712 RPM) [ALARM]
> Oct  4 16:39:10 supermicro sensord: Sensor alarm: Chip
> w83793-i2c-0-2f: fan10: 0 RPM (min = 712 RPM) [ALARM]
> Oct  4 16:40:10 supermicro sensord: Sensor alarm: Chip
> w83793-i2c-0-2f: fan1: 0 RPM (min = 712 RPM) [ALARM]
> Oct  4 16:40:10 supermicro sensord: Sensor alarm: Chip
> w83793-i2c-0-2f: fan4: 0 RPM (min = 712 RPM) [ALARM]
> Oct  4 16:40:10 supermicro sensord: Sensor alarm: Chip
> w83793-i2c-0-2f: fan5: 0 RPM (min = 712 RPM) [ALARM]
> Oct  4 16:40:10 supermicro sensord: Sensor alarm: Chip
> w83793-i2c-0-2f: fan9: 0 RPM (min = 712 RPM) [ALARM]
> Oct  4 16:40:10 supermicro sensord: Sensor alarm: Chip
> w83793-i2c-0-2f: fan10: 0 RPM (min = 712 RPM) [ALARM]
> Oct  4 16:41:11 supermicro sensord: Sensor alarm: Chip
> w83793-i2c-0-2f: fan1: 0 RPM (min = 712 RPM) [ALARM]
> Oct  4 16:41:11 supermicro sensord: Sensor alarm: Chip
> w83793-i2c-0-2f: fan4: 0 RPM (min = 712 RPM) [ALARM]
> 
> right in the middle of a batch of alarm events the log output changes,
> and these were the last events logged to the serial console before the
> system locked up:
> 
> 
> Oct  4 16:41:11 supermicro sensord: Sensor alarm: Chip w83793-i2c-0-2f: fan5: 0
> Oct  4 16:41:11 supermicro sensord: Sensor alarm: Chip w83793-i2c-0-2f: fan9: 0
> Oct  4 16:41:11 supermicro sensord: Sensor alarm: Chip w83793-i2c-0-2f: fan10: 0
> Oct  4 16:42:11 supermicro sensord: Sensor alarm: Chip w83793-i2c-0-2f: fan1: 0
> Oct  4 16:42:11 supermicro sensord: Sensor alarm: Chip w83793-i2c-0-2f: fan4: 0
> Oct  4 16:42:11 supermicro sensord: Sensor alarm: Chip w83793-i2c-0-2f: fan5: 0
> Oct  4 16:42:11 supermicro sensord: Sensor alarm: Chip w83793-i2c-0-2f: fan9: 0
> Oct  4 16:42:11 supermicro sensord: Sensor alarm: Chip w83793-i2c-0-2f: fan10: 0
> Oct  4 16:43:11 supermicro sensord: Sensor alarm: Chip w83793-i2c-0-2f: fan1: 0
> Oct  4 16:43:11 supermicro sensord: Sensor alarm: Chip w83793-i2c-0-2f: fan4: 0
> Oct  4 16:43:11 supermicro sensord: Sensor alarm: Chip w83793-i2c-0-2f: fan5: 0
> Oct  4 16:43:11 supermicro sensord: Sensor alarm: Chip w83793-i2c-0-2f: fan9: 0
> Oct  4 16:43:11 supermicro sensord: Sensor alarm: Chip w83793-i2c-0-2f: fan10: 0
> Oct  4 16:44:13 supermicro sensord: Sensor alarm: Chip w83793-i2c-0-2f: fan1: 0
> Oct  4 16:44:13 supermicro sensord: Sensor alarm: Chip w83793-i2c-0-2f: fan4: 0
> Oct  4 16:44:13 supermicro sensord: Sensor alarm: Chip w83793-i2c-0-2f: fan5: 0
> Oct  4 16:44:13 supermicro sensord: Sensor alarm: Chip w83793-i2c-0-2f: fan9: 0
> Oct  4 16:44:13 supermicro sensord: Sensor alarm: Chip w83793-i2c-0-2f: fan10: 0
> Oct  4 16:45:14 supermicro sensord: Sensor alarm: Chip w83793-i2c-0-2f: fan1: 0
> Oct  4 16:45:14 supermicro sensord: Sensor alarm: Chip w83793-i2c-0-2f: fan4: 0
> Oct  4 16:45:14 supermicro sensord: Sensor alarm: Chip w83793-i2c-0-2f: fan5: 0
> Oct  4 16:45:14 supermicro sensord: Sensor alarm: Chip w83793-i2c-0-2f: fan9: 0
> Oct  4 16:45:14 supermicro sensord: Sensor alarm: Chip w83793-i2c-0-2f: fan10: 0
>
> as you can see part of the usual event is missing, the "RPM (min = 712
> RPM) [ALARM]" that was visible on previous events has gone, very
> strange.

I can't help noticing that these lines are exactly 80 column wide, and
there are 23 of them. That is, essentially the size of a standard
terminal. So I can only suspect that this is an artifact caused by the
terminal displaying the data. As a matter of fact, sensord can't output
such truncated lines.

> i will try running the system with these modules unloaded but I
> wondered if this was a known issue that has already been fixed?

It would help if you could figure out where it hangs. Does the SysRq
trick work when the system hangs?

Anyway, at this point I have no reason to believe that the lockup is
caused by lm-sensors.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
