From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:02 +0000
Subject: Problem status (ABIT NV7m)
Message-Id: <20030625105312.0e66515c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030616210337.1874dc27.khali@linux-fr.org>
In-Reply-To: <20030616210337.1874dc27.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Don't recall seeing the original mail, guess I was busy.

I think so, too.

> In the original mail referenced below, the nforce driver is totally
> whacked. It's giving a response to every address. Either the driver or
> the bus itself is hosed. Power-cycle and try again.

We already tried this (in both Yann's case and the other one) without
success.

> Since you say you have a 83627hf, your best bet is to use the new
> ISA-only w83627hf driver in CVS. Then you can bypass whatever problem
> you're having with nforce or its i2c bus.

That would be an interesting thing to try, thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
