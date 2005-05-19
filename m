From: hfvogt@gmx.net (Hans-Frieder Vogt)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: [PATCH] i2c-nforce2: add support for support nForce4
Message-Id: <200502170010.10368.hfvogt@gmx.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

please find attached a little patch (against CVS of today) that adds support 
for the two SMBusses of the nForce4 in the i2c-nforce2 i2c bus driver. The 
patch is reported to work on the standard nForce4 (i.e. non-Ultra, non-SLI), 
but I expect that it works as well for the other nForce4 chipsets, that seem 
to have the same PCI-id for the SMBus-device.

Thank you, Chuck, for the information, testing and your patch.

Cheers,
Hans-Frieder

-- 
--
Hans-Frieder Vogt                 e-mail: hfvogt <at> arcor .dot. de
                                          hfvogt <at> gmx .dot. net
-------------- next part --------------
A non-text attachment was scrubbed...
Name: i2c-nforce2-nforce4-support.diff
Type: text/x-diff
Size: 1200 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050217/c03be63c/i2c-nforce2-nforce4-support.bin
