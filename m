From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:42 +0000
Subject: We will port w83792d.c to linux-2.6
Message-Id: <Pine.LNX.4.58.0503100933320.25688@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

Patrick please can you help with this?

> This module ali1535 was detected by "sensors-detect", and is loaded
> automatically
> each time when I reboot my Linux.

Yes it seems that you have M1563 southbridge but also you have PMU PCI
device that there was former SMBUS device for M1535.
(and thats the reason for IO to be 0000)

I would suggest you simply delete the i2c-ali1535 module from system
it is stored in /lib/modules/kernelversion(2.6.10 for
you)/kernel/drivers/i2c/busses

(i2c-ali1535 is the driver for portable system and this looks like a
server :)

So correct driver should be i2c-ali1563, which got loaded. But simply do
not work because there is some timeout on the bus.

Please try to find in logs
lines similar to these. So we have more information. (Or replace
dev_dbg with dev_warn in i2c-ali156 when you fail to find correct log
file and recompile this module)

        dev_dbg(&a->dev, "Transaction (post): STS=%02x, CNTL1=%02x, "
                "CNTL2=%02x, CMD=%02x, ADD=%02x, DAT0=%02x, DAT1=%02x\n",

You can also delete(move to some other place so it wont get loaded) the
eeprom module from system, but I dont know if it helps because we still
dont know what type of transaction is failing.

Please can you provide also a dump of this bus i2cdetect 0
(when you have loaded i2c-ali1563) Maybe there will be more messages in
the log.

You can also try increase the ALI1563_MAX_TIMEOUT constant.

Thanks

regards

Rudolf
