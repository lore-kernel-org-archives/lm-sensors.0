From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:05 +0000
Subject: adm9240 chip on a intel se440bx-2
Message-Id: <20040707164141.72202b1e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <000001c4620c$f27351f0$3635430a@glauke>
In-Reply-To: <000001c4620c$f27351f0$3635430a@glauke>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I got the adm9240 to work with a 2.6.7 kernel (custom build debian),
> but there are still errors and I thought that maybe you could use some
> feedback on this.

Where is the feedback supposed to be?

> Kconfig, Makefile and adm9240.c are from /usr/src/linux/drivers/i2c/chips/

There's no adm9240.c there yet, since it has not officially been ported.
Michiel Rook had been working on it some times ago, I don't know if the
driver is ready for incorporation, or not.

Michiel, are we ready ?

-- 
Jean Delvare
http://khali.linux-fr.org/
