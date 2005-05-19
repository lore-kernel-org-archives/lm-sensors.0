From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: lm_sensors2/kernel/busses i2c-piix4.c
Message-Id: <20031028224947.67b5b524.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031027215348.6a9f89de.khali@linux-fr.org>
In-Reply-To: <20031027215348.6a9f89de.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > (mds) add support for CSB6 based on confirmation in ticket #1424
> 
> We have such a chip on my job's server. I may try lm_sensors on it
> someday (I guess forcing an old (2.7.0) i2c-piix4 driver should work).

Mmm, no, did not work. After reading the source code, it turns out that
the force parameter doesn't really force anything in the general case. I
guess it's meant to be safe that way... So I won't be able to test the
driver on that server, sorry.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
