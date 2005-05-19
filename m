From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: ticket# 1649 - i2c-viapro fails to load
Message-Id: <1082098757.407f8445dcc9c@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040415151411.2efbffc1@ekolaptis.>
In-Reply-To: <20040415151411.2efbffc1@ekolaptis.>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PLEASE REPLY TO THE LIST, NOT TO ME ONLY]

> this is what /var/log/messages has to say:
> 
> kernel: i2c-viapro.o version 2.6.5 (20020915)
> kernel: i2c-viapro.o: Can't detect vt82c596 or compatible device,
> module not inserted.
> 
> erm that seems like a very old version... am i doing something
> wrong?

Yes, this is a damn old version that didn't support the KT600 yet. This
is the cause of your problem. And I would bet that you other problem
(with the it87) is the same too. Check /var/log/messages next time you
load it, it's probably version 2.6.5 too.

So you now have to reinstall i2c and lm_sensors from the very beginning,
or (preferably) upgrade your distribution packages for lm_sensors. The
KT600 is supported since version 2.8.1.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
