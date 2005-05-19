From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:46 +0000
Subject: i2c-dev segfault/oops
Message-Id: <20040306091610.14cf76c1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <404921D0.6070407@verizon.net>
In-Reply-To: <404921D0.6070407@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> kernel 2.6.3
> tickets 1600 and 1604
> from i2cdetect and sensors-detect.
> Probably i2c-dev.
> any ideas?

One user reported similar problems on IRC, and I could reproduce it. I
posted about it and proposed a patch:
http://delvare.nerim.net/i2c/linux-2.6/linux-2.6.3-i2c-dev-dbg-oops.diff

I'll update the tickets.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
