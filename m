From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:29 +0000
Subject: lm93 support
Message-Id: <20050106195001.31011731.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <41DBED37.7020109@earthlink.net>
In-Reply-To: <41DBED37.7020109@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

>     I've looked into this a bit more and generated a simple patch to 
> sensors-detect.   I've also included a simple patch to lm93.c to 
> increase the wait between retries if there is a timeout.

I applied the sensors-detect patch. I leave the lm93.c patch to Mark
Hoffman as he wrote this driver.

Thanks,
-- 
Jean Delvare
http://khali.linux-fr.org/
