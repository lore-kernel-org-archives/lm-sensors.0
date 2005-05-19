From: ebenard@free.fr (Eric BENARD / Free)
Date: Thu, 19 May 2005 06:23:55 +0000
Subject: Ticket 1227 confirmation
Message-Id: <200304281248.32834.ebenard@free.fr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi, 

I just wanted to confirm the ticket 1227 problem.

My platform :
00:11.0 ISA bridge: VIA Technologies, Inc. VT8233A ISA Bridge

RedHat 8.0, kernel 2.4.20 from kernel.org
latest (today) cvs i2c for 2.4 kernel 
latest (today) lm_sensors from cvs

root@localhost root]# modprobe i2c-viapro
/lib/modules/2.4.20/kernel/drivers/i2c/busses/i2c-viapro.o: init_module: No 
such device
Hint: insmod errors can be caused by incorrect module parameters, including 
invalid IO or IRQ parameters.
      You may find more information in syslog or the output from dmesg
/lib/modules/2.4.20/kernel/drivers/i2c/busses/i2c-viapro.o: insmod 
/lib/modules/2.4.20/kernel/drivers/i2c/busses/i2c-viapro.o failed
/lib/modules/2.4.20/kernel/drivers/i2c/busses/i2c-viapro.o: insmod i2c-viapro 
failed

I don't know where to dig to try to know more about this problem.

regards
Eric
