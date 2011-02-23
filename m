From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 23 Feb 2011 05:53:29 +0000
Subject: Re: [lm-sensors] [PATCH v4 00/10] hwmon: (w83627ehf) Add support
Message-Id: <20110223055328.GA18500@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1297712143-7431-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1297712143-7431-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Feb 23, 2011 at 12:00:57AM -0500, Phillip Susi wrote:
> On 02/22/2011 09:46 PM, Guenter Roeck wrote:
> 
> > How many fan counters (fanX_input) do you see on your system ?
> 
> The device reports 5 fan inputs and 3 pwm outputs, but the motherboard 
> only has 4 fan headers: 2 4 pin and 2 3 pin.  From that I would expect 
> pwm1 and pwm2 to be routed to the two 4 pin fan headers ( first one is 
> cpu ), and the other two fan headers input to be connected to fan inputs 
> 3 and 4, with no control.
> 
pwm2 is the CPU fan, actually.

How does the "sensors" output look like before and after you change pwm1 ?

> > I am a bit confused about the correlation of pwm to inputs and fan behavior.
> > Are you saying that pwm1 affects three of the four fans ? That would be a bit odd.
> > What are the values repoted by pwm2 and pwm3, and do you see anything change
> > if you modify those values ?
> 
> Indeed, it is odd.  If I set pwm1 to a value of zero, all but one of the 
> fans in the system stop.  Specifically the cpu fan, the front case fan, 
> and the rear case fan stop, while the top case fan continues to spin.  I 
> will need to open it back up to make sure, but my guess is that the top 
> fan is connected to the second 4 pin fan header on the motherboard, but 
> since the fan is only a 3 pin fan, it does not respond to the pwm output 
> that is likely connected to it from pwm2.  The other two fan headers are 
> only 3 pin headers, but since they seem to respond to changes to pwm1, I 
> guess that the motherboard has on board FETs that respond to PWM1 to 
> regulate the voltage on these two headers so their speed corresponds to 
> the cpu fan speed.
> 
Actually, sysfanout (pwm1) can be configured for DC output. You should see
the setting with pwm1_mode. If its value is 0, output is DC, otherwise
it is pwm. pwm2 and pwm3 only support pwm mode.

If configured for DC, the upper 6 bit of pwmX translate to output voltage.

Motherboard pinout (per its datasheet) is a bit odd. Looks like only the CPU fan
(pwm2) supports pwm mode. The other fan connectors don't have a pwm pin.
Fan connectors are labeled PWR_FAN1, CPU_FAN, CHA_FAN1 and CHA_FAN2. CHA_FAN1
has a 4-pin header, but the 4th pin is labeled as "+5V", not pwm.

> > Would it be possible to run pwmconfig and let us know what it reports ?
> 
> It appears to agree with my assessment in that fan1 responds to pwm1.

And pwm2 and pwm3 don't have an effect ?

Also - just trying to make sure - if you change pwm1, does it have an effect on 
pwm2 and/or pwm3 ? It should not, but who knows. And what are the values reported
by pwm2 and pwm3 ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
