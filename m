From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:29 +0000
Subject: interface to kernels 2.6.x for gkrellm?
Message-Id: <20031208225835.00e03acf.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200312081015.39276.gene.heskett@verizon.net>
In-Reply-To: <200312081015.39276.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I have NDI if gkrellm uses lm_sensors, or if its standalone coded,
> but I sure could use some pointers.  I went to the web page where I
> saw the announcement that the CVS now had support for 2.6, but when
> browsing the downloads page the CVS data denies it.  Confusing...

NDI=?

The documentation was updated today.

Gkrellm does use the lm_sensors drivers, but it doesn't seem to use the
libsensors library under Linux 2.6.0-testX. (Not tried myself, but I
think I remember users reported it.)

> When do we get a source tarball thats ready for the stuff thats 
> already in 2.6?

CVS is ready. If yon can't/don't want to get CVS, wait for the 2.8.2
release (shouldn't take too much time).

> My wife smokes, and its the nicotene 
> tar that makes the glue that really holds that stuff in like it was 
> flypaper.  Even $50 all copper coolers cannot cope with that!

Change wifes :p

> AMD K6-III@500mhz 320M
> Athlon1600XP@1400mhz  512M
> 99.22% setiathome rank, not too shabby for a WV hillbilly
> Yahoo.com attornies please note, additions to this message
> by Gene Heskett are:
> Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

Oh, BTW, your signature is pitiful. Am I the first one to tell you?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
