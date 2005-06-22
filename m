From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Wed, 22 Jun 2005 10:34:08 +0000
Subject: [lm-sensors] RE: w83792d driver for the 2.6 kernel
Message-Id: <42B92270.30403@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE5E7741@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE5E7741@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all

Please can you modprobe the bus driver

modprobe i2c-i801
modprobe i2c-dev
i2cdetect 0

And send us output of i2cdetect command?

Somewhere in region 0x20 - 0x2f should be one number. Use it in next command

i2cdump 0 0x2f

0x2f is an example. Most likely it will be 0x2f or 0x2d or 0x2e

Are you sure you ran  /usr/local/sbin/sensors-detect

and not /usr/sbin/sensors-detect

Thanks,
regards

Rudolf.
