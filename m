From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: i2c, lm_sensors, and 2.4.22
Message-Id: <20030920103004.3cc16acc.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030905235839.5e4fe2a9.khali@linux-fr.org>
In-Reply-To: <20030905235839.5e4fe2a9.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Thanks for the reply.  I'd like to know where to locate your script. 
> I assume that this script is similar to the mkpatch.pl provided by i2c
> in that it will generate the appropriate patch for any kernel.  Is
> this script on
> 
> http://www.ensicaen.ismra.fr/~delvare/devel/i2c
> 
> or is it somewhere else?

There is no script (TM). Patches had to be written one by one, "by
hand". I modify them individually each time a new 2.4 kernel is released
(which happened only once so far, for the 2.4.22 kernel). If you need to
patch a kernel that is not supported (that is, neither 2.4.21 nor
2.4.22), here is how to proceed.

1* Use i2c's mkpatch.pl to generate the core patch for your kernel, and
apply it.

2* Apply each additional patch individually. You'll find them here:
  http://www.ensicaen.ismra.fr/~delvare/devel/i2c/#list
You'll want to apply all the patches but "core i2c subsystem", since
you'll already have done this part. Wether you'll use the patches
intended for linux 2.4.21 or 2.4.22 depends on which kernel you are
targetting. The nearest, the more likely the patches are likely to apply
cleanly. If they don't, you'll have to dig into the code ;)

I'd like to underline that all this is already mentioned on my webpage.
If you think that some details should be added or some changes made to
make things clearer, let me know.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
