From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:43 +0000
Subject: i2c-yosemite
Message-Id: <20040222104106.714de992.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Manish Lachwani <lachwani@pmc-sierra.com>
Cc: LM Sensors <sensors@stimpy.netroedge.com>, LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>

Hi Manish,

I saw that there is a new driver named i2c-yosemite in Linux 2.6.3-mm2.
Quoting your words in the header:

"Currently, this Linux driver wont be integrated into the generic Linux
I2C framework."

Why that?

If everyone reimplements what already exists, the kernel is likely to go
bigger with no benefit. Also, you won't be able to use all user-space
tools that already exist, and will also have to write specific chip
drivers for the chips present on the yosemite bus, although these
drivers (Atmel 24C32 EEPROM and MAX 1619) already exist.

Please explain to us why you cannot/don't want to use the existing i2c
subsystem.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
