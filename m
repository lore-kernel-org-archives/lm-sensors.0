From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:45 +0000
Subject: i2c-patch2.4.22 => pb with alsa driver
Message-Id: <1078157204.40435f944a61f@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040301155624.GA30793@cereve.enpc.fr>
In-Reply-To: <20040301155624.GA30793@cereve.enpc.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting Edouard Debry <debry@cereve.enpc.fr>:

> so I patched the original kernel 2.4.22 source with that patch, and
> recompiled with same options that went well before,
> the kernel booted correctly, I re-installed alsa driver (v0.9.6), as
> there are not in kernel 2.4.xx by default, but when running 'depmod
> -a' I had plenty of unresolved symbols which were dealing only with
> alsa drivers !!!

I don't think it is related to the i2c patch. I use alsa myself and
never had any problem since the first i2c patch.

> so I wonder if this is due to the patch, which means incompatibility
> between i2c 2.8.4 and alsa v0.9.6, or I did not choose right options
> !!

More likely, you forgot to enable soundcore in your kernel.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
