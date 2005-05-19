From: mds@mds.gotdns.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: adt7463 on asus w1n laptop
Message-Id: <42175C0E.8090601@mds.gotdns.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200502141545.03330.christophe.dr@free.fr>
In-Reply-To: <200502141545.03330.christophe.dr@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> 
> That makes sense, but I'd guess the fan only uses 0.5W of power or so.
> If you set the PWM to a 50% duty cycle you'll save 0.25W. Out of the
> 25W your laptop must be consumming, it's not much, only 1%. Still I
> agree that whatever you can save, should be. But actually I think it's
> more interesting for the noise reduction than for the power consumption
> reduction.
> 

Don't know how big the fan is, a 40mm fan is typically rated at 1.2-1.4W.
This is significant and I suspect a lot more than 2% of a laptop's power
when it is not doing anything. Fan control is an important part of
any laptop's power management.

Also, fan power is not proportional to PWM percentage or RPM;
a fan running at half speed could use 1/4 or less of its full-speed power.

> 
>>Should i use something like :
>>
>>set pwm1_zone 123
>>
>>in /etc/sensors.conf in the appropriate section (lm85 and co...), as
>>explained at the end of your linked document ?
> 
> 
> You may need to. Zones define which temperature sensors determine the
> speed of a given fan. I'd hope that your BIOS already configured the
> zones properly, but maybe not. At any rate, be very careful when chaning
> this. If you configure the zones improperly, the fans may stop speeding
> up properly on temperature increase (obviously), possibly causing
> permanent damage to your hardware!


agreed, if you break the feedback loop with the wrong correlations bad things
could happen. Ideally you should figure out what the BIOS or windows does
and make sure to set it up the same way under linux. Be very careful.
