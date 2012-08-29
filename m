From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 29 Aug 2012 17:03:14 +0000
Subject: Re: [lm-sensors] Patching help
Message-Id: <20120829170314.GB28158@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAPevXitqR63A+B0KH3ZfRfC-E=dHQVF7ak7MupQf-WUzcDnhbQ@mail.gmail.com>
In-Reply-To: <CAPevXitqR63A+B0KH3ZfRfC-E=dHQVF7ak7MupQf-WUzcDnhbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Wed, Aug 29, 2012 at 06:47:38PM +0200, Jean Delvare wrote:
> Hi Simon,
> 
[ ... ]
> 
> Presumably you refer to:
> http://marc.info/?l=linux-i2c&m3033220527043&w=2
> (At least I think this is the latest version of the patch... Not sure.)
> 
[ ... ]

> I hope to find some time to finally review the patch in question so
> that it can get upstream and things just work for users out of the box.
> But I am just back from vacation with a lot of stuff in my mailbox so
> it will take some time before I get there.
> 
Unfortunately, the patch no longer applies. The driver was since modified to add
support for a second "aux" SMBus port, and that conflicts with the four ports
supported on the sb800.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
