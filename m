From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: [BK PATCH] i2c driver fixes for 2.6.2-rc2
Message-Id: <1075365845.4018c7d5353d7@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040127233242.GA28891@kroah.com> <20040129004402.GC5830@werewolf.able.es>
In-Reply-To: <20040129004402.GC5830@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com

Quoting "J.A. Magallon" <jamagallon@able.es>:

> After upgrading to sensors 2.8.3 (first I compiled it, then installed
> the Makdrake package when appeared), my temperatures are still
> mutiplied by 10. I use 2.6.2-rc2-mm1.
> 
> Any ideas ?

As stated on our kernel 2.6 dedicated page [1]: You need lm_sensors CVS
for kernels 2.6.2-rc1 and later.

We plan to release lm_sensors 2.8.4 as soon as Linux 2.6.2 final is
there.

[1] http://secure.netroedge.com/~lm78/kernel26.html

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
