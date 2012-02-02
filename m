From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 02 Feb 2012 19:33:56 +0000
Subject: Re: [lm-sensors] [PATCH v5 2/5] x86/platform: (TS-5500) add GPIO support
Message-Id: <1328211236.2261.152.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1328130344-18836-1-git-send-email-vivien.didelot@savoirfairelinux.com>
	 <1328130344-18836-3-git-send-email-vivien.didelot@savoirfairelinux.com>
	 <20120201213025.53d820d2@pyramind.ukuu.org.uk>
In-Reply-To: <20120201213025.53d820d2@pyramind.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Vivien Didelot <vivien.didelot@savoirfairelinux.com>, "x86@kernel.org" <x86@kernel.org>, Jerome Oufella <jerome.oufella@savoirfairelinux.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, Jean Delvare <khali@linux-fr.org>

On Wed, 2012-02-01 at 16:30 -0500, Alan Cox wrote:
> > +obj-$(CONFIG_TS5500_GPIO)		+= ts5500_gpio.o
> 
> Wants to be gpi-ts5500 and in the drivers/gpio directory.
> 

I would agree, though there seem to be some disagreements about where
such platform specific drivers should be located. From an earlier
exchange I had with Vivien about this matter:

> > > would be the appropriate location for a driver like this. As
> > > mentioned before, my strong preference is drivers/hwmon, but I
> > > would like to hear from others.
> > 
> > We should either split every driver into corresponding
> > subdirectories, or put everything in a common platform directory.
> > My first RFC patches set has every driver separated. As they are
> > really specific to the platform, people seem to agree with grouping
> > them, mainly because they won't be shared. I changed that in the
> > following patches sets, and X86 maintainers seemed to be ok with
> > that.
> > 
> > I'm ok with both solutions, but we should all agree on one.
> > Maybe we should have other maintainers view on this?
> > 
> That is what I had asked for. I thought the whole point of per-module 
> directories was to have all drivers there. If that is no longer true,
> fine with me; who am I to argue about something like that.
> I'd just like to know.
> 

It looks like things are going back and forth a bit. If I were Vivien, I
would be a bit frustrated by now and be close to giving up (Vivien, I
really commend you for your patience).

Is there a written guideline or policy people can look and point to
if/when something like this comes up ? Otherwise we may have the
LED/GPIO/xxx maintainers point one way, the X86 maintainers point the
other way, and thus may have reached a complete deadlock.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
