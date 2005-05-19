From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: error compiling with i2c 2.8.0 patch
Message-Id: <20030717090615.140e5d1f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <m3oeztep4f.fsf@athlon.familiaroa>
In-Reply-To: <m3oeztep4f.fsf@athlon.familiaroa>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I have SuSE 8.0 with kernel 2.4.18.  I am trying to use the i2c patch,
> in order  to use my webcam  (module bttv) and lm_sensors.  I have used
> the mkpatch  script which comes  with the i2c  package. When I  try to
> compile the kernel I get the following errors for various i2c modules:
> (...)

Could you send us your .config file? I could then try to reproduce the
problem on my system.

However, why are you using such an old kernel? It's 17 month and three
version old! If you are to recompile your kernel, you should update to
2.4.21 before doing so, methinks.

> Besides I am not  sure if the file i2c-2.8.0-drivers-media-video.diff,
> which I also used for patching, is appropriate for my kernel.

If it applied cleanly (I mean not part was rejected) it should be OK.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
