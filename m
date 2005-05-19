From: hfvogt@gmx.net (Hans-Frieder Vogt)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: [PATCH] i2c-nforce2: add support for nForce4 (patch against
Message-Id: <200502180031.22235.hfvogt@gmx.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200502180019.20440.hfvogt@gmx.net>
In-Reply-To: <200502180019.20440.hfvogt@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greg, (this time with "signed off line")

can you please apply the attached patch (against 2.6.11-rc4, but works as
 well for 2.6.11-rc3-mm2),  that adds support for the two SMBusses of the
 nForce4 to the i2c-nforce2 i2c bus driver.
The patch is reported to work on the standard nForce4 (i.e. non-Ultra,
non-SLI), but I expect that it works as well for the other nForce4 chipsets,
that seem to have the same PCI-id for the SMBus-device.

This patch was proposed by Chuck <chunkeey@web.de>, thanks to him for the
information, testing and his patch.

Signed-off-by: Hans-Frieder Vogt <hfvogt@arcor.de>

Cheers,
Hans-Frieder

--
--
Hans-Frieder Vogt                 e-mail: hfvogt <at> arcor .dot. de
                                          hfvogt <at> gmx .dot. net
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 2.6.11-rc4-i2c-nforce2-nforce4-support.diff
Type: text/x-diff
Size: 1477 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050218/70a2caa1/2.6.11-rc4-i2c-nforce2-nforce4-support.bin
