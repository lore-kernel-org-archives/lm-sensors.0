From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:26 +0000
Subject: checksum in (i2c) eeprom driver
Message-Id: <lNsWdTVB.1102596784.6279250.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: LM Sensors <sensors@stimpy.netroedge.com>, Greg KH <greg@kroah.com>, Deepak Saxena <dsaxena@plexity.net>


Hi all,

Any objection to me removing the checksumming code from the (i2c) eeprom
driver? Deepak had suggested we should do so a long time ago [1], and I
fully agree with his position. The checksum is application-specific and
verifying it doesn't belong to the kernel-space. The checksumming code
we (optionally) use at the moment only covers memory module EEPROMs as
far as I know, while EEPROMs exposed on I2C/SMBus may be of a variety of
other natures.

[1] http://archives.andrew.net.au/lm-sensors/msg21194.html

Thanks,
--
Jean Delvare
