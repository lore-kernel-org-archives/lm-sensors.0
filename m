From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: [PATCH] Fix for i2c-piix4 with on some boards
Message-Id: <20030815105807.7ce910ec.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030811181001.GE807@ip68-0-152-218.tc.ph.cox.net>
In-Reply-To: <20030811181001.GE807@ip68-0-152-218.tc.ph.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> OK, patch commited. I took the liberty to change "temp = temp & 0xfd"
> into "temp &= 0xfd".
> 
> I'll test it on my piix4 chipsets tomorrow (no time left tonight).

OK, tested on three different machines, which were not needing the patch
(so no wonder they worked and still do).

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
