From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: lm_sensors-2.2.8 -- a comment (+patch) and a question
Message-Id: <1074258052.4007e084af172@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0401161140590.14623@pcl321.mppmu.mpg.de>
In-Reply-To: <Pine.LNX.4.58.0401161140590.14623@pcl321.mppmu.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> 1. I recently fetched , built, and installed your i2c and lm_sensors
> packages (v2.2.8). I noticed that your Makefiles have been
> DESTDIRized, but unfortunately not completely so. The attached patch
> should add (some of the?) missing pieces.

This has to be 2.8.2, not 2.2.8.

The problem was already reported and fixed, release 2.8.3 includes this
fix. Thanks for reporting anyway.

> 2. I noticed that both packages (i2c and lm_sensors) contain header
> files kernel/include/i2c-dev.h that got installed (in my case) as
> /usr/local/include/linux/i2c-dev.h. These two files are, however,
> NOT identical. Actually there is a rather short one with 1578 bytes
> from i2c and a longer on with 12372 bytes form lm_sensors.
> 
> This is very confusiong and, if I were to install i2c a second time
> (for whatever reasons) might lead to all sort of problems.
> 
> Why these to different versions of the same header??????????

You're right, this is confusing. I think it is a problem of kernel
header vs. user-space header, which is not handled correctly, but I
cannot tell much more.

Maybe Ky?sti or Greg can bring us some light?

Oh BTW, note that even with 9 less question marks, I wouldn't have been
able to help, so you could save some.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
