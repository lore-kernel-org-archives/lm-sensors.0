From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 28 Jan 2012 01:26:30 +0000
Subject: Re: [lm-sensors] [w83627ehf] Not all fans are shown (#3)
Message-Id: <20120128012630.GA629@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120127145130.GA29746@ericsson.com>
In-Reply-To: <20120127145130.GA29746@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Jan 27, 2012 at 06:52:17PM -0500, CC wrote:
> On Fri, Jan 27, 2012 at 11:41 PM, Guenter Roeck
> <guenter.roeck@ericsson.com> wrote:
> > Hi,
> >
> > On Fri, Jan 27, 2012 at 12:49:48PM -0500, CC wrote:
> > [ ... ]
> >> >
> >> > I tested all three fan outputs. Another thing is weird: pwm1_mode has
> >> > its meaning reversed (it's a 3-pin connector and the value 1 is DC
> >> > mode, in contrast to pwm2 and the documentation).
> >> >
> > You lost me there. pwm1 supports both DC and PWM. pwm1_mode should return 0 for DC mode,
> > 1 for pwm mode. The other pwm channels only support pwm mode on the NCT6776F, thus
> > pwm2_mode and pwm3_mode should both return 1.
> >
> > Are you saying that reading pwm1_mode returns 1, and pwm2_mode and pwm3_mode
> > both return 0 ?
> >
> > Thanks,
> > Guenter
> 
> Maybe my reasoning is wrong...
> 
> We have that
> 
> * fan1 is linked to pwm1
> * fan2 is linked to pwm2
> * fan4 can only be monitored
> * fan5 is linked to pwm3
> 
> Only fan2 has a 4-pin connector and could thus be controlled by PWM,
> the others can only be controlled by voltage. Let's assume all fans to
> be in manual mode.
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
> 
On pwm2 and pwm3, the chip doesn't even support DC mode (per datasheet).
So setting those to 0 is, at best, undefined, and should not yield any results.
I guess the "bug" here is that pwm2_mode and pwm3_mode are writable for the NCT6776F.
We should really reject setting DC mode for those attributes.

Regarding pwm1_mode, maybe the board plays with the pwm output and converts
it to a voltage - really hard to say. Question really is - what are the powerup
settings ? Presumably those should be correct.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
