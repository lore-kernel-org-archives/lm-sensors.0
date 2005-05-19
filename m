From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:55 +0000
Subject: [PATCH 2.6] I2C: New hardware monitor driver: adm9240 (2nd try)
Message-Id: <20050428205026.7d698a00.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <5pst6197ke5d20ouv6h0rgokd32mdbsndi@4ax.com>
In-Reply-To: <5pst6197ke5d20ouv6h0rgokd32mdbsndi@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Grant,

> Need to clear bit 3, powerup = 1, as well as set bit 0, but:
> 
> control reg (40h)
> 7..4	writing zero harmless
> 3	INT_clear, power-up default = 1 stops measurement, writing zero
> required 2,1	writing zero harmless
> 0	start measurement cycle, write '1' to start measurement cycle

Oh well, if you say so, fine with me. After all, you are supposed to
know that device better than I do.

-- 
Jean Delvare
