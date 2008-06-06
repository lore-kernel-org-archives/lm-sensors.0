From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Fri, 06 Jun 2008 08:51:53 +0000
Subject: Re: [lm-sensors] [PATCH 2.6.25.4] hwmon: HP Mobile Data Protection
Message-Id: <4848FAA9.6020808@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1212235533.3815.5.camel@localhost>	<4846EBF5.2030406@tremplin-utc.net>	<20080604225830.1dff64fc@hyperion.delvare>	<20080604230510.GB30475@elf.ucw.cz>	<484728B2.1000209@tremplin-utc.net> <20080605082950.6957f1a2@hyperion.delvare> <4847B415.2080708@cam.ac.uk> <48484DD6.3050706@tremplin-utc.net>
In-Reply-To: <48484DD6.3050706@tremplin-utc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: =?ISO-8859-1?Q?=C9ric_Piel?= <Eric.Piel@tremplin-utc.net>
Cc: Jean Delvare <khali@linux-fr.org>, Andrew Morton <akpm@osdl.org>, Torokhov <dmitry.torokhov@gmail.com>, Burman <burman.yan@gmail.com>, LKML <linux-kernel@vger.kernel.org>, HWMON <lm-sensors@lm-sensors.org>, "Mark M. Hoffman" <mhoffman@lightlink.com>, Pavel Machek <pavel@suse.cz>, Yan@ATrpms.net, Dmitry@ATrpms.net, Arjan van de Ven <arjan@infradead.org>


>> Still, it may take some time to iron out the various kinks in this system
>> and get it fully tested, so may be worth putting stuff elsewhere for now
>> with the intention to move it as and when the more unified stuff has been
>> written.
> Yes, so I'll keep my plan of first submitting the driver with the
> current interface, and latter updating the interface to the new
> subsystem when you have stabilised its interface.
Probably best plan!
> BTW, just by curiosity, is your tree available publicly somewhere?
Not just yet. (doesn't all work as of yet and I need to get at least a couple
of devices working with it be sure I haven't written something too device
specific)

I'll post to the relevant mailing lists when it reaches a more reasonable 
state and the 'arguments' can begin ;)

Jonathan


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
