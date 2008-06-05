From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 05 Jun 2008 16:12:14 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] lm87: Convert into a new-style driver
Message-Id: <20080605181214.12fbc857@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080604184401.GG11300@solarflare.com>
In-Reply-To: <20080604184401.GG11300@solarflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 05 Jun 2008 17:57:22 +0300, Riku Voipio wrote:
> Jean Delvare wrote:
> > The question is: why do you want to provide the "settings" (I think you
> > mean the high and low limits of each sensor?) and allow polling of the
> > values inside the kernel, when we have a standard user-space interface
> > and library that takes care of this, with a dozen applications that can
> > be used on top of it? It makes sense to pass _some_ settings as
> > platform data (e.g. fan polarity) but passing all the limits doesn't
> > make any sense to me.
> >   
> I don't see why this is a problem to you - on PC's sensible defaults
> are set at BIOS. If there is no BIOS to set it up, someone needs to
> set it up. If the settings are platform-specific, the most natural
> place is the platform_data.

This is a problem to me because it is duplicating a mechanism which
already exists in user-space and which mush exist in user-space (so
that the users can change the limits if they want.) So I am not pleased
to see the same mechanism duplicated in the kernel. There was a time
where most hardware monitoring drivers were initializing limits to
"sane default". We dropped all this code like 5 years ago and I don't
want to see it added back now.

> The limits depend on what is being
> monitored (CPU? mainboard? ambient temperature? Network card?),
> and it's not easy to figure what's being monitored by the userland.

If the vendor provides a libsensors configuration file, it's in fact
pretty easy.

> Actually, at a second look, the current lm87_init_client already sets
> limits to hardcoded values... :) So if Ben's patch only makes it more
> flexible.

Not really. lm87_init_client() resets the min and max limit if the chip
is not already running, because these registers have no default value
for the LM87 chip (bad design if you ask me) and we don't want to
frighten the user with irrelevant alarms. The user still needs to set
the proper limits from user-space. If the chip is already running then
we assume that the BIOS or firmware has also done the limit
initialization and we leave them alone.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
