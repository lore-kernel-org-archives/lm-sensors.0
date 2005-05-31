From: BGardner@Wabtec.com (BGardner@Wabtec.com)
Date: Tue, 31 May 2005 21:02:17 +0000
Subject: [lm-sensors] [PATCH 2.6.12-rc4] max6875: new driver
Message-Id: <F06EB2894F3F0D45AD9BEA7246DE9C906F5389@WCSEXCMBS1.ad.wabtec.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


The MAX6875 is an EEPROM programmable, quad power supply
sequences/supervisior.
It is connected via the i2c bus.
The driver also supports the MAX6874, as the interface is identical.
 
It's probably not found on any standard motherboard, but it's pretty
handy for custom embedded stuff.

We use it for power supply sequencing at power up, as a watchdog timer,
and for serial & model number storage.

The driver exposes the 2 banks of EEPROM (configuration and
user-defined) and the bank of configuration registers.

Signed-off-by: Ben Gardner <bgardner@wabtec.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: max6875.patch
Type: application/octet-stream
Size: 15851 bytes
Desc: max6875.patch
Url : http://lists.atrpms.net/pipermail/lm-sensors/attachments/20050531/9849f6d0/max6875-0001.obj
