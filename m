From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 06 Oct 2006 11:09:58 +0000
Subject: [lm-sensors] Supermicro X6DH8-G2+ / sensors not working
Message-Id: <20061006130958.793524a1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <451FF905.60001@hal.saar.de>
In-Reply-To: <451FF905.60001@hal.saar.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Michael,

> I can test your driver for the PC87427 if you like to. My only
> constraint is that I have to put the server into production very soon
> (in about one or two weeks).

Here you go. I attached the driver itself, and a Makefile to compile it
off-tree. Just type "make modules" to build the driver and "make
modules_install" to install it. Then "modprobe pc87427" should work.
Let me know if not.

Once the driver is loaded you should have fan interface files
under /sys/class/hwmon/hwmon0/device. The driver reports the current
fan speed, the low limit speed, and two alarm flags per fan: fan too
slow (fanX_alarm) and fan stalled/missing (fanX_fault).

Please report how it works for you! Thanks.

-- 
Jean Delvare
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: Makefile
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061006/44ed7712/attachment.pl 
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: pc87427.c
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061006/44ed7712/attachment.c 
