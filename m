From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 15 Jan 2009 18:03:18 +0000
Subject: Re: [lm-sensors] [PATCH 0/2] hwmon: (abituguru3) Partial DMI
Message-Id: <20090115190318.45ba2ab7@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1231865798-12187-1-git-send-email-alistair@devzero.co.uk>
In-Reply-To: <1231865798-12187-1-git-send-email-alistair@devzero.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 15 Jan 2009 16:48:57 +0000, Alistair John Strachan wrote:
> On Thursday 15 January 2009 15:22:45 Jean Delvare wrote:
> > > (One remaining question would be whether patch 1 should be CCed to
> > > -stable, since there has been a regression introduced into 2.6.27 and
> > > present in 2.6.28 for some BIOS revisions of the IP35 Pro.)
> >
> > Is there really a regression? If the DMI matching doesn't work, we fall
> > back to the old detection method, so I can't see how there would be a
> > regression. Care to explain?
> 
> Having looked at this properly I agree. It's clear that in this bug report 
> what actually happened was the DMI match failed, AND the probe routine failed.
> 
> This definitely puts the final nail in the coffin of manual probing, 
> especially on the IP35 Pro (which was where all these changes originated 
> from).
> 
> Sorry for the confusion, you are correct, and there is no way this could be 
> considered a regression. I had just extrapolated that from the original 
> poster, but it must be the case that it has never worked, or worked 
> unreliably.

Or the regression was cause by a BUIS update. In which case we are not
responsible for it.

> > Speaking of DMI matching... If DMI is disabled, we do:
> >
> > static inline int abituguru3_dmi_detect(void)
> > {
> > 	return -ENODEV;
> > }
> >
> > And this error value causes abituguru3_init() to bail out. Unless I'm
> > missing something, the abituguru3 driver is simply useless without DMI
> > support at the moment. We should either make that official and make the
> > driver depend on DMI at Kconfig level, or change
> > abituguru3_dmi_detect() to return 1, so that we fallback to the old
> > detection method. Opinions?
> 
> It should return 1. This is simply a blunder. Fortunately CONFIG_DMI is quite 
> difficult to turn off, and no distribution would. I'll follow up to this email 
> with a proper patch.

Great, thanks.

> Apologies for the mistakes..

Heh, no problem.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
