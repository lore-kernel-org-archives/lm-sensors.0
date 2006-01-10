From: mrenzmann@otaku42.de (Michael Renzmann)
Date: Tue, 10 Jan 2006 05:02:13 +0000
Subject: [lm-sensors] [Fwd: [PATCH 01/11] hwmon: Fix negative temperature
Message-Id: <1136869333.4447.3.camel@gimli>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all.

This is a revised version of my previous patch to fix negative
temperature readings of the LM77 in kernel 2.6.x.

Bye, Mike
-------------- next part --------------
An embedded message was scrubbed...
From: Jean Delvare <khali at linux-fr.org>
Subject: [PATCH 01/11] hwmon: Fix negative temperature readings in lm77 driver
Date: Mon, 9 Jan 2006 22:43:08 +0100
Size: 2245
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060110/83fc0faf/attachment.mht
