From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date: Thu, 05 Jun 2008 01:06:47 +0000
Subject: Re: [lm-sensors] [PATCH 2.6.25.4] hwmon: HP Mobile Data Protection
Message-Id: <20080605010647.GC16599@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1212235533.3815.5.camel@localhost> <4846EBF5.2030406@tremplin-utc.net> <20080604230326.GA30475@elf.ucw.cz>
In-Reply-To: <20080604230326.GA30475@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pavel Machek <pavel@suse.cz>
Cc: =?iso-8859-1?Q?=C9ric?= Piel <Eric.Piel@tremplin-utc.net>, Andrew Morton <akpm@osdl.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Arjan van de Ven <arjan@infradead.org>, "Mark M. Hoffman" <mhoffman@lightlink.com>, Yan Burman <burman.yan@gmail.com>, LKML <linux-kernel@vger.kernel.org>, HWMON <lm-sensors@lm-sensors.org>

On Thu, 05 Jun 2008, Pavel Machek wrote:
> > > 3) Makes it possible to power the device off.
> 
> But this part is what I don't understand. powering off does not seem
> to belong there. Why can't you just use acpi to power down?

I think he means power down the g-sensors and related filters and A/D
circuitry.  The out-of-tree version of the HDAPS driver can do it as
well.

For what is it worth, I think drivers/accel is a good idea, and I think
the other accel drivers should be moved there.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
