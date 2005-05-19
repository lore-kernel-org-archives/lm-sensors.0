From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:17 +0000
Subject: Data block transactions fail on i2c-i801 controller?
Message-Id: <20040922221611.GD4256@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <13938324.1095712833883.JavaMail.root@scooter.psp.pas.earthlink.net>
In-Reply-To: <13938324.1095712833883.JavaMail.root@scooter.psp.pas.earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello David:

* David Knierim <david_knierim@earthlink.net> [2004-09-21 07:58:37 -0700]:
> The logs were pretty large, so we placed them on the web:
> 
> http://lee.k12.nc.us/~joden/misc/sensors/

Thanks for doing that, and for saving some list B/W too.

> dmesg_noblock - block data disabled
> dmesg_withblock - block data enabled

The i2c-i801 driver has *major* brain damage w.r.t. block xfers.  What
I *expected* to see in your logs was a timeout of some sort, indicating
that the bus was not resetting properly after a xfer.

Not even close: the bus driver is actually performing a whole block xfer
once for each byte!!!  Seeing this, I wouldn't be suprised to find out
that you are the very first user of that function, ever.  I am honestly
amazed that it works at all.

So I understand what needs to be done, but actually fixing it is not
high on my list just now - especially since you have a workaround
(disable_block=1).

One reason this will take some time is that this driver supports several
different chipsets.  Apparently some of them have a block xfer buffer
and some don't; I would have to read through ~5 chipset datasheets to
sort it out.  This is one reason I was hoping the original authors would
get involved.

Hopefully, I'll have some time to work on this after I finish some other
stuff.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
