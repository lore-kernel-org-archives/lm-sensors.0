From: keenanpepper@gmail.com (Keenan Pepper)
Date: Sun, 29 May 2005 21:34:51 +0000
Subject: [lm-sensors] SMSC LPC47M192 - "Device is disabled, will not use"
Message-Id: <429A1930.6040409@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@lm-sensors.org
Cc: linux-kernel@vger.kernel.org

I have a chip on my motherboard which says "SMsC LPC47M192-NC", but the kernel 
module for it (kernel 2.6.12-rc5-mm1) doesn't work:

keenan@localhost:~$ sudo modprobe smsc47m1
FATAL: Error inserting smsc47m1 
(/lib/modules/2.6.12-rc5-mm1/kernel/drivers/i2c/chips/smsc47m1.ko): No such device

In the dmesg output it says:

smsc47m1: Found SMSC LPC47M15x/LPC47M192
smsc47m1: Device is disabled, will not use

What does this mean? How do I get this chip to tell me fan speed and CPU 
temperature (if that's even what it does?)?
