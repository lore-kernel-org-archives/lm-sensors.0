From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 10 Feb 2011 19:18:42 +0000
Subject: Re: [lm-sensors] [PATCH v2 5/5] hwmon: (w83627ehf) Add support for
Message-Id: <20110210201842.611373eb@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1297352949-25602-6-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1297352949-25602-6-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 10 Feb 2011 10:59:30 -0800, Guenter Roeck wrote:
> On Thu, 2011-02-10 at 13:37 -0500, Ian Dobson wrote:
> [ ... ]
> 
> > Hi Guenter,
> > 
> > Are you sure the smartfan readout of pwm_* parameters actually works
> > correctly on nct6776f chips?
> > 
> Not really.
> 
> > root@alpha2:/sys/devices/platform/w83627ehf.656# cat pwm1_enable
> > 5
> > root@alpha2:/sys/devices/platform/w83627ehf.656# cat pwm1
> > 193
> > root@alpha2:/sys/devices/platform/w83627ehf.656# cat pwm1_mode
> > 1
> > root@alpha2:/sys/devices/platform/w83627ehf.656# cat pwm1_target
> > 0
> > root@alpha2:/sys/devices/platform/w83627ehf.656# cat pwm1_tolerance
> > 0
> > root@alpha2:/sys/devices/platform/w83627ehf.656# cat pwm1_start_output
> > 1
> > root@alpha2:/sys/devices/platform/w83627ehf.656# cat pwm1_step_output
> > 255
> > root@alpha2:/sys/devices/platform/w83627ehf.656# cat  pwm1_stop_output
> > 1
> > 
> > It looks as if pwm1 is in smartfan mode but the remaining parameters look
> > totally wrong. Maybe there's parameters are only valid in thermal cruise
> > mode. I'll study the code at the weekend and maybe playing with my test box.
> > 
> Keep in mind that SmartFan IV isn't fully supported, ie it is not
> possible to set any SmartFan IV specific registers. So question is what
> we would want to do if the system is configured for SmartFan IV mode.
> Right now the code just reports that SmartFan IV is configured; the
> other registers don't really mean anything in that mode. An option might
> be to make the other attributes read-only if SmartFan IV is configured.

Not a good idea. It's good to be able to set the parameters of the other
modes _before_ switching to them. If you make them read-only, the user
will have to change mode first, and only then configure it, leaving a
period of time where the fans may misbehave.

> And maybe I should add some text to the documentation explaining this in
> more detail.

This is always welcome.

> We could of course add full SmartFan IV support, but that goes a bit
> beyond the time I have available, and I would not want to hold nct677X
> chip support hostage for it.
> 
> Input is welcome ...

I'd say leave things as they are, with proper documentation. If anyone
really wants to fine-tune SmartFan IV beyond what their BIOS offers,
well, we accept patches, don't we?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
