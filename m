From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:26 +0000
Subject: checksum in (i2c) eeprom driver
Message-Id: <41B85D43.8070409@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <lNsWdTVB.1102596784.6279250.khali@localhost>
In-Reply-To: <lNsWdTVB.1102596784.6279250.khali@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I think the checksum code is useful because checksum=1 prevents the module from claiming ddc monitor eeproms
and other devices in its address space 50-57.
Since detection for eeproms is otherwise poor, it's the only way we have for robust detection.

Jean Delvare wrote:
> Hi all,
> 
> Any objection to me removing the checksumming code from the (i2c) eeprom
> driver? Deepak had suggested we should do so a long time ago [1], and I
> fully agree with his position. The checksum is application-specific and
> verifying it doesn't belong to the kernel-space. The checksumming code
> we (optionally) use at the moment only covers memory module EEPROMs as
> far as I know, while EEPROMs exposed on I2C/SMBus may be of a variety of
> other natures.
> 
> [1] http://archives.andrew.net.au/lm-sensors/msg21194.html
> 
> Thanks,
> --
> Jean Delvare
> 
> 
