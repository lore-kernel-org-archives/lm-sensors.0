From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: Memory leak in I2C (ticket #1898)
Message-Id: <20050219185239.7e43b3dc.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <jG6nFvCq.1108465575.6408970.khali@localhost>
In-Reply-To: <jG6nFvCq.1108465575.6408970.khali@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

> were there any hints in dmesg?
> hitting table size limits in i2c-core can also return ENOMEM, but
> should also generate a message about increasing I2C_xxx_MAX.
> I'd say this is more likely than running your whole box out of memory.

I don't agree. James' script unloads and reloads a limited number of
modules (less than I2C_xxx_MAX), and repeats the process forever. If
there is a memory leak somewhere, it comes to no surprise that this
script hits it.

-- 
Jean Delvare
