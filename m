From: Alistair John Strachan <alistair@devzero.co.uk>
Date: Tue, 05 Aug 2008 00:59:28 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] abituguru3: Prefer DMI probing to
Message-Id: <200808050159.28596.alistair@devzero.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1217614619-29688-3-git-send-email-alistair@devzero.co.uk>
In-Reply-To: <1217614619-29688-3-git-send-email-alistair@devzero.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tuesday 05 August 2008 01:18:48 Andrew Morton wrote:
> On Fri,  1 Aug 2008 19:16:59 +0100 Alistair John Strachan 
<alistair@devzero.co.uk> wrote:
> > Previously the driver was only using DMI to prevent smbus probing on
> > non-Abit motherboards. However, since the manual probing method is
> > brittle and prone to failure on some Abit motherboards (esp. the
> > Abit IP35 Pro) it is better to use DMI to also read the board name
> > and then decide whether or not to probe the bus.
> >
> > At the moment, we do not have a list of valid DMI name strings to use
> > for existing and supported motherboards. This patch only implements
> > DMI probing for the IP35 Pro. For motherboards that can not yet use
> > DMI probing, a warning will be printed to the kernel log asking those
> > users to email me their dmidecode output.
> >
> > The existing manual probing mechanism will be used if CONFIG_DMI is
> > not enabled, if DMI probing fails (for DMI-unsupported motherboards),
> > or if DMI probing fails and the "force" option is set (for
> > DMI-supported motherboards). Ideally in the longer term this manual
> > probing method would be removed.
> >
> > This patch should be safe to apply as it does not change the probing
> > behaviour for most of the supported motherboards, just the IP35 Pro,
> > which already has regressions filed against it in 2.6.26.
>
> This conflicts with your earlier
> hwmon-fix-loading-of-abituguru3-on-abit-ip35-pro-with-bios-17.patch.  I
> reworked
> hwmon-fix-loading-of-abituguru3-on-abit-ip35-pro-with-bios-17.patch so
> that it applies on top of these two later patches.
>
> Please confirm that
> hwmon-fix-loading-of-abituguru3-on-abit-ip35-pro-with-bios-17.patch is
> still needed.

The first patch should be dropped, as it was specifically a workaround for the 
IP35 Pro, which can now rely on DMI.

Sorry for not making this clear.

-- 
Cheers,
Alistair.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
