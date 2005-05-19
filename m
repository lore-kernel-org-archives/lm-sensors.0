From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:42 +0000
Subject: We will port w83792d.c to linux-2.6
Message-Id: <h329PNm3.1110446319.7708670.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi all,

> I would suggest you simply delete the i2c-ali1535 module from system
> it is stored in /lib/modules/kernelversion(2.6.10 for
> you)/kernel/drivers/i2c/busses

A less destructive option is to add "i2c-ali1535" in
/etc/hotplug/blacklist.

--
Jean Delvare
