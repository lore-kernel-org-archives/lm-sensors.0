From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 28 Jan 2012 08:41:19 +0000
Subject: Re: [lm-sensors] [w83627ehf] Not all fans are shown (#3)
Message-Id: <20120128094119.14cdb544@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120127145130.GA29746@ericsson.com>
In-Reply-To: <20120127145130.GA29746@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 28 Jan 2012 00:52:17 +0100, CC wrote:
> We have that
> 
> * fan1 is linked to pwm1
> * fan2 is linked to pwm2
> * fan4 can only be monitored
> * fan5 is linked to pwm3
> 
> Only fan2 has a 4-pin connector and could thus be controlled by PWM,
> the others can only be controlled by voltage.

This assumption is wrong. 3-pin fans can be controlled by PWM too. It
is frequent that CPU fan = 4 pins controlled with PWM and case fan =
3 pins controlled with DC but other combinations are possible too.

> Let's assume all fans to be in manual mode.
> 
> * regardless of pwm1, fan1 runs at full speed when pwm1_mode returns 0
> * the fan's speed can be controlled by pwm1 when pwm1_mode returns 1
> 
> So DC mode is only (correctly) activated when pwm1_mode returns 1.
> 
> * fan2 stops when pwm2 returns 0 and pwm2_mode also returns 0
> * fan2 runs slowly when pwm2 returns 0 and pwm2_mode returns 1
> 
> I interpret this as DC mode being used when pwm2_mode returns 0.
> 
> * regardless of pwm3, fan5 runs at full speed whenever pwm3_mode returns 0
> * the fan's speed can be controlled when pwm1_mode returns 1
> 
> So DC mode is only (correctly) activated when pwm3_mode returns 1.

You are not supposed to change pwm*_mode attribute values in the first
place. Your board should come up with the right settings from the BIOS.
In most cases the output pins of the chip aren't connected directly to
the fan headers, there is some electronics involved on the path which
only works as designed if you use the right output mode, so changing
the mode simply breaks fan control.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
