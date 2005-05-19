From: alex@greennet.ge (Alex Shaduri)
Date: Thu, 19 May 2005 06:23:47 +0000
Subject: Reply to ticket 1123
Message-Id: <20030209201254.5d9a5cb8.alex@greennet.ge>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This is a reply to ticket 1123.

modprobe i2c-viapro says:
-------
/lib/modules/2.4.21-pre4/kernel/drivers/i2c/busses/i2c-viapro.o: init_module: No such device
Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters.
      You may find more information in syslog or the output from dmesg
/lib/modules/2.4.21-pre4/kernel/drivers/i2c/busses/i2c-viapro.o: insmod /lib/modules/2.4.21-pre4/kernel/drivers/i2c/busses/i2c-viapro.o failed
-------
While dmesg outputs:
------
i2c-core.o: i2c core module version 2.7.0 (20021208)
i2c-viapro.o version 2.7.0 (20021208)
i2c-core.o: i2c core module version 2.7.0 (20021208)
i2c-viapro.o version 2.7.0 (20021208)
i2c-viapro.o: Found Via VT8233A/8235 device
i2c-viapro.o: Via Pro SMBus detected and initialized
