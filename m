From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:59 +0000
Subject: /lib/modules/$(KERNELVER)/kernel/drivers/sensors left empty
Message-Id: <20030612101117.17c774d5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030608202401.60d0cec0.khali@linux-fr.org>
In-Reply-To: <20030608202401.60d0cec0.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > I noticed that when upgrading from an old lm_sensors to CVS, modules
> > are installed to /lib/modules/$(KERNELVER)/kernel/drivers/i2c
> > instead of/lib/modules/$(KERNELVER)/kernel/drivers/sensors. Old
> > modules are removed, but the directory itself isn't. Shouldn't we
> > delete it as well? Or could possibly be there something that doesn't
> > belong to us?
> > 
> > Also, modules are removed if and only if they are uncompressed.
> > .o.gz(do .o.bz2 exist?) modules are not. I know we don't compress
> > modules, but maybe removing any existing module could solve possible
> > issues before they arise. Comments on this would be welcome.
>
> good questions.
> I don't know if either problem is worth solving.
> The first problem is harmless but the second one could cause trouble.
> What installation procedure compresses modules - it is a Red Hat thing
> or something? How common is this?

On the other hand, both problem are easy to fix, methinks (yeah, you
always say that *before* trying, and only later understand how painful
it will be).

For the empty directory thing, I suggest one of the following solutions:
1* "rmdir --ignore-fail-on-non-empty $DIR". It's clean, but will fail
before fileutils-4.0.
2* "rmdir $DIR 2> /dev/null || true". Does the same, will work
everywhere.
3* "if [ "$(ls -A $dir)" = '' ] ; then rmdir $dir ; fi". Probably
cleaner than 2*, more flexible (we can add a warning if the directory
isn't empty) but slower.
My preference go to 2*. Simple and efficient.

Compressing modules is a common practice among distributions. Slackware
does it (that's why I noticed the problem), I was told Mandrake does it
too, but Debian and Red Hat wouldn't. I think there are only few risks
this ever cause a problem because a non-compressed (that is, our) module
will be prefered over a compressed (that is, their) module. But anyway,
removing the old modules frees some disk space, and probably quickens
subsequent depmods. And removing compressed modules is rather easy, so I
think we should do it.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
