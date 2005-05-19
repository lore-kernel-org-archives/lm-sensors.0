From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: adt7463 on asus w1n laptop
Message-Id: <20050219203106.18ed6197.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200502141545.03330.christophe.dr@free.fr>
In-Reply-To: <200502141545.03330.christophe.dr@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> OK so i need to put something like :
> 
> options lm85 force_adt7463=xxx
> 
> in the /etc/modprobe.conf... But what is the xxx i need to put ?
> "modinfo lm85" says i has to be "List of adapter,address pairs". I
> can't guess  what it means... Should i put 0x2e or 060+ or anything
> else ??? What is this  list of adapters ? I have read the lm_sensors
> faq but did not find anything  about it... Perhaps i missed the right
> paragraph...

Adapter is 0, address is 0x2e.

modprobe lm85 force_adt7463=0,0x2e

In other words it's exactly the same parameters you used for i2cdump.
Easy :)

-- 
Jean Delvare
