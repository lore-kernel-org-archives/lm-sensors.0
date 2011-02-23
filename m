From: Phillip Susi <psusi@cfl.rr.com>
Date: Wed, 23 Feb 2011 15:38:05 +0000
Subject: Re: [lm-sensors] [PATCH v4 00/10] hwmon: (w83627ehf) Add support
Message-Id: <4D6529DD.2050409@cfl.rr.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1297712143-7431-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1297712143-7431-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 2/23/2011 12:53 AM, Guenter Roeck wrote:
> Actually, sysfanout (pwm1) can be configured for DC output. You should see
> the setting with pwm1_mode. If its value is 0, output is DC, otherwise
> it is pwm. pwm2 and pwm3 only support pwm mode.
> 
> If configured for DC, the upper 6 bit of pwmX translate to output voltage.
> 
> Motherboard pinout (per its datasheet) is a bit odd. Looks like only the CPU fan
> (pwm2) supports pwm mode. The other fan connectors don't have a pwm pin.
> Fan connectors are labeled PWR_FAN1, CPU_FAN, CHA_FAN1 and CHA_FAN2. CHA_FAN1
> has a 4-pin header, but the 4th pin is labeled as "+5V", not pwm.

That is odd.  The 4th pin should either be pwm or no connect, not +5V.

>>> Would it be possible to run pwmconfig and let us know what it reports ?
>>
>> It appears to agree with my assessment in that fan1 responds to pwm1.
> 
> And pwm2 and pwm3 don't have an effect ?
> 
> Also - just trying to make sure - if you change pwm1, does it have an effect on 
> pwm2 and/or pwm3 ? It should not, but who knows. And what are the values reported
> by pwm2 and pwm3 ?

I was just playing directly with the knobs in /sys rather than running
sensors or pwmconfig.  Setting pwm2 and 3 to zero had no effect.
Setting pwm1 to zero caused fan1 and I think it was fan4 to drop to 0.
fan2 and fan3 were still reading as spinning, though I am pretty sure
that only one fan was actually still spinning.  I'll open the case
tonight and figure out which fan was connected to which header.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
