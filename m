From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:36 +0000
Subject: Ticket 1546 Resolved
Message-Id: <20040125164921.01539f63.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4013E297.4080103@chartermi.net>
In-Reply-To: <4013E297.4080103@chartermi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I opened ticket 1546 waiting in unsorted.   About 15 minutes later I 
> found the solution.
> 
> I needed to load in this order i2c-isa, lm78, i2c-piix4, lm75.
> After doing that I can no monitor both my lm78 and lm75.

In fact the order doesn't matter. What was missing was i2c-isa.

> I wanted to close the ticket myself, but it will not allow that.

I've closed it.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
