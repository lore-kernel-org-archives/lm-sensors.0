From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:17 +0000
Subject: interface changes in linux 2.6, lm_sensors 2.8.8
Message-Id: <20040923035510.GE4256@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040916123814.M40115@linux-fr.org>
In-Reply-To: <20040916123814.M40115@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali@linux-fr.org> [2004-09-21 21:39:49 +0200]:
> > > The FSC Hermes doesn't have PWM capabilities as far as I know. I
> > > wonder what made you think it could have.
> > 
> > Are you sure?  Try 'grep pwm kernel/chips/fscher.c' in 2.4/CVS and
> > same in 2.6.9.  Actually, the 2.4/CVS and 2.6.9 drivers don't look
> > similar at all.
> 
> I admit it is strange. It seems to mix the concepts of min and pwm. The
> SUMMARY and fscher doc files don't mention PWM at all.
> 
> Attached is the datasheet for the FSC Hermes if you want to take a look.
> I'm really too busy these days to go through it, sorry.

I'm inclined to ignore the fscher not-quite-pwm control for now - as
you'll see it's not included in the patch I made.  But hey, I don't
see how the current libsensors can access those controls with the
kernel 2.6 driver anyway; so it's no loss there.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
