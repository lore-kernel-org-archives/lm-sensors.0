From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:15 +0000
Subject: Support for DDR2 DRAM??
Message-Id: <Pine.LNX.4.58.0409101132320.31786@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <28703505.1094766606690.JavaMail.root@louie.psp.pas.earthlink.net>
In-Reply-To: <28703505.1094766606690.JavaMail.root@louie.psp.pas.earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Please provide a dump of the EEPROM (using "i2cdump 0 0x53"). It it actually
> is an DDR2 DRAM EEPROM we'll see how we can get it supported. With some luck
> it might use the same standards as DDR and we may just have to add the new
> type value to get it supported.

Here is DDR2 EEPROM layout, (and all EDO, SDRAM, DDR layouts included
also)

http://download.micron.com/pdf/technotes/TN_04_42.pdf

Ruik
