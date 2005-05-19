From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: [Fwd: [PATCH] video/saa5249.c, video/tuner-3036.c get rid of
Message-Id: <20030913231959.7e9b0a80.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F5E5D6D.3000406@edgedesign.us>
In-Reply-To: <3F5E5D6D.3000406@edgedesign.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Get rid of MOD_INC/DEC since ref count comes from owner field on I2C
> for these drivers.
> 
> Not sure who is maintaining these, maybe no one because they haven't
> been purged of MOD stuff  yet.
> 
> diff -Nru a/drivers/media/video/saa5249.c
> (...)
> diff -Nru a/drivers/media/video/tuner-3036.c

Thanks for the information. My current patch does not get rid of these,
mostly because things do "work" (compile, run) with them still there.

I guess I'll have to incorporate them before we submit a patch to the
LKML. And this also means that I should make sure I did not miss other
similar ones (likely I did).

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
