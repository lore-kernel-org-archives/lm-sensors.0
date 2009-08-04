From: Samuel Ortiz <sameo@linux.intel.com>
Date: Tue, 04 Aug 2009 11:33:15 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: WM831x PMIC hardware monitoring
Message-Id: <20090804113314.GA8601@sortiz.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1248702372-29534-12-git-send-email-broonie@opensource.wolfsonmicro.com> <1248790260-26211-1-git-send-email-broonie@opensource.wolfsonmicro.com> <20090728162658.0ac35362@hyperion.delvare> <20090728145048.GB3013@sirena.org.uk>
In-Reply-To: <20090728145048.GB3013@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Jean, Mark,

On Tue, Jul 28, 2009 at 03:50:49PM +0100, Mark Brown wrote:
> On Tue, Jul 28, 2009 at 04:26:58PM +0200, Jean Delvare wrote:
> > On Tue, 28 Jul 2009 15:11:00 +0100, Mark Brown wrote:
> 
> > > +static ssize_t show_batt_temp(struct device *dev,
> > > +			      struct device_attribute *attr, char *buf)
> > > +{
> 
> ...
> 
> > > +	/* The conversion depends on the battery, leave to userspace but
> > > +	 * report as voltage for ABI reasons. */
> > > +	return sprintf(buf, "%d\n", DIV_ROUND_CLOSEST(ret, 1000));
> > > +}
> 
> > If I am not mistaken, the above function is an exact copy of
> > show_voltage(), so you might as well use it?
> 
> It is now, yes, except for the comment explaining why we're reporting as
> a voltage.
> 
> > All the rest looks good to me now, so:
> 
> > Acked-by: Jean Delvare <khali@linux-fr.org>
> 
> > And as I said before for the wm8350-hwmon driver: I can pick this patch
> > and push it to Linux in 2.6.32 if you want, but if you want it to take
> > a different route this is equally fine with me. Just tell me if you
> > want me to pick it.
> 
> I'm more than happy for you to take both - the only reason that I asked
> you to hold off on the wm8350 patch originally was that I knew I was
> going to be releasing this driver and there would be collisions with the
> Kconfig stuff which was due to be released very soon.

I applied both patches to my for-next branch. Jean, if you prefer them to go
through your tree, please go ahead and I'll remove them from mine.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
