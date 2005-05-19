From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:38 +0000
Subject: Ticket 1552
Message-Id: <20040201215112.2227131d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi James,

I have a patch for you:
http://delvare.nerim.net/i2c/linux-2.6/linux-2.6.2-rc3-i2c-w83l785ts-temp-sysfs.diff

It applies against a recent 2.6 kernel and should solve the problem you
reported in ticket 1552.

If you confirm it works for you, I'll send it to Greg KH for inclusion
into the Linux kernel tree.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
