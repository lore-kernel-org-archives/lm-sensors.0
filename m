From: juergh@gmail.com (Juerg Haefliger)
Date: Thu, 22 Mar 2007 16:46:11 +0000
Subject: [lm-sensors] [PATCH 1/2 RESEND] hwmon: new driver for SMSC DME1737
Message-Id: <191fb4ca0703220946p1f1e750i4b285111bfc23318@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Applied changes based on Hans de Goede's review.

---
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
Size: 44850 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070322/98d3e130/attachment-0001.obj 
