From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:42 +0000
Subject: sysfs names
Message-Id: <1077200454.4034c646b11fc@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040126230447.09700886.khali@linux-fr.org>
In-Reply-To: <20040126230447.09700886.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

According to "Mark M. Hoffman":

> One little bit of refactoring I see is this... bah, it only saves
> ~19  lines and 150 bytes.

This is already done in your asb100 driver, right?

How much does it save from the binary?

> Is it worth it to do this to all the drivers?

I do like the change much. Yes, I think it is worth it. (Yes, I hate
code duplication.)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
