From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 26 Aug 2007 18:50:41 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Update the sysfs interface
Message-Id: <20070826185041.GI3679@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070820164444.48e68a63@hyperion.delvare>
In-Reply-To: <20070820164444.48e68a63@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Hans de Goede <j.w.r.degoede@hhs.nl> [2007-08-20 22:51:07 +0200]:
> Jean Delvare wrote:
> >* Document the name attribute.
> >* Document the *_label attributes.
> >* Drop "typical usage" lists, they no longer match the reality.
> >* Drop non hardware-monitoring related entries.
> >
> >Signed-off-by: Jean Delvare <khali@linux-fr.org>
> 
> Looks good to me"
> Acked-by: Hans de Goede <j.w.r.degoede@hhs.nl>

Applied to hwmon-2.6.git/testing, with one small change...

> >+		These drivers will output the actual voltage. Rule of
> >+		thumb: drivers should report the voltage values at their
> >+		pins.

Drivers don't have pins, chips do.  Also, quote pins so as to include pads,
balls, etc... whatever the actual external connection might be.

+               These drivers will output the actual voltage. Rule of
+               thumb: drivers should report the voltage values at the
+               "pins" of the chip.

Thanks,

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
