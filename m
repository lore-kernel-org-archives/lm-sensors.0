From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: Linux 2.6 and CONFIG_ISA
Message-Id: <20040118130226.426e4142.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1074005072.400404506dd11@imp.gcu.info>
In-Reply-To: <1074005072.400404506dd11@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Applied with a bit of editing to get around my previous change.

BTW, wouldn't it make sense to apply the same idea to i2c algorithms?
I.e. adapters would not depend on them, but select them instead.  I
don't expect people to know which algorithms them need.  The way is is
now, I think that users may miss half a dozen adapters just because they
did not enable i2c-algo-bit.  Not very friendly, is it?

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
