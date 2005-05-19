From: azarah@gentoo.org (Martin Schlemmer)
Date: Thu, 19 May 2005 06:23:52 +0000
Subject: [PATCH-2.5] Fix w83781d sensor to use Milli-Volt for in_* in
Message-Id: <1049775078.23992.2.camel@nosferatu.lan>
List-Id: <lm-sensors.vger.kernel.org>
References: <1049750163.4174.35.camel@nosferatu.lan>
	 <20030407215443.GA4386@kroah.com>
In-Reply-To: <20030407215443.GA4386@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: KML <linux-kernel@vger.kernel.org>, sensors@Stimpy.netroedge.com

On Mon, 2003-04-07 at 23:54, Greg KH wrote:
> On Mon, Apr 07, 2003 at 11:16:03PM +0200, Martin Schlemmer wrote:
> > --- drivers/i2c/chips/w83781d.c.orig	2003-04-07 22:53:37.000000000 +0200
> > +++ drivers/i2c/chips/w83781d.c	2003-04-07 22:53:34.000000000 +0200
> > @@ -364,7 +364,7 @@
> >  	 \
> >  	w83781d_update_client(client); \
> >  	 \
> > -	return sprintf(buf,"%ld\n", (long)IN_FROM_REG(data->reg[nr] * 10)); \
> > +	return sprintf(buf,"%ld\n", (long)IN_FROM_REG(data->reg[nr])); \
> 
> Hm, this patch looks backwards, is it?
> 
> Also, just as a side note, can you make your patches so that they can be
> applied with "patch -p1" instead of "patch -p0" which your current ones
> are?  My tools treat -p1 patches much better :)
> 

Yes, sorry, that is reverse.  I have to go to work in a bit, so if you
need me to resend tonight, just ask.


-- 

Martin Schlemmer


-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: This is a digitally signed message part
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030408/e0e78113/attachment.bin
