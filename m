From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:09 +0000
Subject: i2c-algo-8xx
Message-Id: <20030802133344.71d15fac.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Greg,

Just a quick note about something I noticed this morning.

In linux-2.6.0-test2, there is the i2c-rpx driver. It needs the
i2c-algo-8xx module and header file, which are *not* in
linux-2.6.0-test2, so it won't work, unless I missed something. So I
guess i2c-algo-8xx should be ported to Linux 2.6 too, or i2c-rpx will
have to be removed.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
