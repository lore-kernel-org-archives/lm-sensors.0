From: juergh@gmail.com (Juerg Haefliger)
Date: Thu, 22 Feb 2007 22:44:23 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: new driver for SMSC DME1737
Message-Id: <191fb4ca0702221444r89a3b86hcd3d306bf8cacf83@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch adds support for the hardware monitoring and fan control
capabilities of the SMSC DME1737 and ASUS A8000 Super-I/O chips.

The hardware monitoring logic of this chip is similar to the LM85 but
has some additional features that this driver supports. Even though
it's a Super-I/O chip, the hardware monitoring logic can only be
accessed via SMBus.

Signed-off-by: Juerg Haefliger <juergh at gmail.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: hwmon-dme1737-new-driver.patch
Type: application/octet-stream
Size: 44292 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070222/10599ea9/attachment-0001.obj 
