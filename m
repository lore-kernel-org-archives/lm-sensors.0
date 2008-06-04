From: Pavel Machek <pavel@suse.cz>
Date: Wed, 04 Jun 2008 23:03:26 +0000
Subject: Re: [lm-sensors] [PATCH 2.6.25.4] hwmon: HP Mobile Data Protection
Message-Id: <20080604230326.GA30475@elf.ucw.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <1212235533.3815.5.camel@localhost> <4846EBF5.2030406@tremplin-utc.net>
In-Reply-To: <4846EBF5.2030406@tremplin-utc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: =?iso-8859-1?Q?=C9ric?= Piel <Eric.Piel@tremplin-utc.net>
Cc: Andrew Morton <akpm@osdl.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Arjan van de Ven <arjan@infradead.org>, "Mark M. Hoffman" <mhoffman@lightlink.com>, Yan Burman <burman.yan@gmail.com>, LKML <linux-kernel@vger.kernel.org>, HWMON <lm-sensors@lm-sensors.org>

Hi!

> We haven't received any review for this driver since last week's post by
> Yan :-( That's why I'm adding explicitly as receivers of this email all
> the people who have reviewed the first two previous takes. Apologies for
> the possible multiple receptions.
> 
> It would be _really really kind_ if some of you could take some time and
> comment (or simply ACK ;-) ) this code. It adds support for hardware
> which can be found in mostly every HP Compaq laptop less than three
> years old. It's quite worthy.

It looked pretty much okay on _very_ quick look.

> > 3) Makes it possible to power the device off.

But this part is what I don't understand. powering off does not seem
to belong there. Why can't you just use acpi to power down?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
