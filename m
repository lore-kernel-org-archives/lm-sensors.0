From: vdovikin@jscc.ru (Oleg I. Vdovikin)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: One-liner fix for i2c-velleman (and problems with i2c-tsunami)
Message-Id: <003601c354e1$258f02d0$6628d0c3@mlab.cs.msu.su>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307242129.59862.kelledin@users.sourceforge.net>
In-Reply-To: <200307242129.59862.kelledin@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

    this patch is required to use i2c-elektor in memory-mapped mode. The
differences are calls to isa_readb & isa_writeb instead of just plain readb
& writeb on the older kernels. Without this fix module will not load and
will cause kernel oops. I don't known exactly when the kernel guys have
moved to isa_*, but for now it's needs to be here. ;-)) The patch is just
"ifndef isa_*".

    I've no chance to play with 2.6 :-((, probably I will do this later. But
anyway it's better to include this patch rather than nothing...

Regards,
    Oleg.

----- Original Message ----- 
From: "Jean Delvare" <khali@linux-fr.org>
To: "Oleg I. Vdovikin" <vdovikin@jscc.ru>
Cc: <kelledin@users.sourceforge.net>; <sensors@Stimpy.netroedge.com>
Sent: Saturday, July 26, 2003 2:24 AM
Subject: Re: One-liner fix for i2c-velleman (and problems with i2c-tsunami)


>
> >     I've attached i2c-elektor.patch for proper readb/writeb support in
> > newest kernel. Please incorporate it with your Alpha fixes.
>
> Is "newest kernel" to be understood as 2.4.22 or 2.6.0-pre1? (Just to
> know if we have to commit your patch to i2c CVS or only Greg on his
> side.)
>
> -- 
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/
