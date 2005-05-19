From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:58 +0000
Subject: lm_sensors
Message-Id: <7awRU5FZ.1115888962.9654630.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <OF0351D9C0.5474FFE2-ON87256C2B.005D8AC8@boulder.ibm.com>
In-Reply-To: <OF0351D9C0.5474FFE2-ON87256C2B.005D8AC8@boulder.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Dmitry,

> My kernel is win4lin enabled (patched). So is it possible to upgrade
> to 2.6.12-rc* only 'drivers/i2c' branch of the kernel or I'll have
> problems?

I just checked, you can actually copy the it87.c file itself alone from
2.6.12-rc4 to your current kernel tree, and that should work just fine.

--
Jean Delvare
