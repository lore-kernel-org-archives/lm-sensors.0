From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 21 Sep 2006 09:14:49 +0000
Subject: [lm-sensors] TODO: unchecked return codes from
Message-Id: <20060921111449.a093d410.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060830030828.GB5104@jupiter.solarsys.private>
In-Reply-To: <20060830030828.GB5104@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

> Restarting the list from scratch for clarity:
> 
> Done by Mark M. Hoffman:
>  o adm1021
>  o adm1025
>  o adm1026
>  o adm1031
>  o adm9240
>  o asb100
>  o lm75
>  o lm77
>  o lm78
>  o lm80
>  o lm85
>  o lm87
>  o lm92
>  o smsc47b397
>  o w83627hf
> 
> Done by Jim Cromie:
>  o pc87360
> 
> Done by David Hubbard:
>  o w83627ehf
> 
> Done by Jean Delvare:
>  o f71805f
>  o fscher
>  o fscpos
>  o gl518sm
>  o gl520sm
>  o it87
>  o lm63
>  o lm83
>  o lm90
> 
> This leaves the following list:
>  o abituguru
>  o atxp1
>  o ds1621
>  o max1619
>  o sis5595
>  o smsc47m1
>  o smsc47m192
>  o via686a
>  o vt8231
>  o w83781d
>  o w83791d
>  o w83792d
>  o w83l785ts
> 
> I'd like to remind everyone that this is an easy task, just look at the
> patches submitted by either Mark of me, and do the same. So if you are
> using one of the remaining drivers, please consider converting it and
> sending the patch back to us.

I'd appreciate if at least the drivers which have a dedicated
maintainer were fixed by said maintainers. This means:
 * Hand de Goede for the abituguru driver
 * Roger Lucas for the vt8231 driver
 * Charles Spirakis for the w83791d driver
I'd like to submit all these fixes in time for 2.6.19, which means the
patches must be ready by the end of the week. Can you guys take a look
at how we fixed the other drivers:
 http://lists.lm-sensors.org/pipermail/lm-sensors/2006-August/017503.html
 (for example)
and submit patches for your respective drivers? Thanks.

-- 
Jean Delvare

