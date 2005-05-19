From: pascal.ronecker@centrale-lille.net (Pascal Ronecker)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: [Fwd: sensors, kernel 2.4.19, bttv ...]
Message-Id: <1067205912.14878.24.camel@lenny.homelinux.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1067191364.14649.3.camel@lenny.homelinux.net>
In-Reply-To: <1067191364.14649.3.camel@lenny.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Je viens de voir le .fr de ta propre adresse, donc je me permets de
faire dans le bilingue.

Finalement je pense bien upgrader au 2.4.22 et prendre le patch unique,
ca devrait m'?viter des d?boires. Sauf que j'utilise aussi lirc, et si
j'en crois ce que j'ai lu, ca me promet aussi de ne pas ?tre triste. ...

Alors avant de m'y jeter (et au passage devoir aussi reinstaller mes
drivers video nvidia et sons alsa, a chaque fois la grande joie, plus ce
que j'oublie) ... quelle gal?re je risque avec lirc ?

---------------------------------
Now in english for the .com e-mail
I'll finally upgrade to 2.4.22 kernel, to use the provided patch.
But before doing that - as it is not that quick (recompiling nvidia
drivers, alsa drivers, and what more?) : i'm using also lirc... and it
seems that it requires also a patch. Will it be that complicated ?


thx anyway !



On Sun, 2003-10-26 at 21:58, Jean Delvare wrote:
> > I used the mkpatch.pl script to prepare a i2c patch for my kernel (the
> > "option 3" installation from the guide.
> > the kernel compiles fine, then lm_sensors compiles also.
> > A serious problem remains with bttv module that does not compile.
> > According to the insructions I read from the adress you gave me, i
> > have to patch th bttv-if.c file. But the patch doesn't apply, I tried
> > manually but I do not understand it well enough. 
> > 
> > Could you just help me with that ?
> 
> Sure. Anyway, the easiest way to get everything working would be to
> upgrade your kernel up to 2.4.22 and use my all-in-one, ready-to-apply
> patch.
> 
> > here is the patch :
> > 
> > 	diff --exclude=media -ru bttv-0.9.11-orig/bttv-if.c
> > 	bttv-0.9.11-i2c/bttv-if.c
> > 	--- bttv-0.9.11-orig/bttv-if.c	Wed Jun 25 18:26:49 2003
> > 	+++ bttv-0.9.11-i2c/bttv-if.c	Sun Aug  3 15:33:34 2003
> > (...)
> > and here my corresponding code, really tiny (original vanilla 2.4.19)
> 
> You're trying to do the wrong thing. This patch is intended for people
> using recent bttv sources from outside the kernel. If you are using the
> bttv driver from the Linux kernel, then you should use this one:
> http://www.ensicaen.ismra.fr/~delvare/devel/i2c/linux-2.4.22/linux-2.4.22-i2c-2.8.1-drivers-media-video.diff
> or, if you are using i2c 2.8.0:
> http://www.ensicaen.ismra.fr/~delvare/devel/i2c/linux-2.4.21/linux-2.4.21-i2c-2.8.0-drivers-media-video.diff
> 
> That will fix all video drivers in your kernel tree, including bttv.
