From: Pavel Machek <pavel@suse.cz>
Date: Wed, 04 Jun 2008 23:05:10 +0000
Subject: Re: [lm-sensors] [PATCH 2.6.25.4] hwmon: HP Mobile Data Protection
Message-Id: <20080604230510.GB30475@elf.ucw.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <1212235533.3815.5.camel@localhost> <4846EBF5.2030406@tremplin-utc.net> <20080604225830.1dff64fc@hyperion.delvare>
In-Reply-To: <20080604225830.1dff64fc@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: =?iso-8859-1?Q?=C9ric?= Piel <Eric.Piel@tremplin-utc.net>, Andrew Morton <akpm@osdl.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Arjan van de Ven <arjan@infradead.org>, "Mark M. Hoffman" <mhoffman@lightlink.com>, Yan Burman <burman.yan@gmail.com>, LKML <linux-kernel@vger.kernel.org>, HWMON <lm-sensors@lm-sensors.org>

Hi!

> So my advice is that you don't wait for a review from the hwmon people,
> because apparently we don't have much interest in this type of device,
> so you'll be waiting forever. You're much better adding the mdps driver
> to drivers/misc through Andrew Morton, at least until someone takes
> care of creating a subsystem for this type of devices and move all
> existing drivers there.

Just create drivers/accel ... accelerometers are quite common these
days. Going to drivers/misc is okay, too, I guess -- moves are easy
with git ;-).
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
