From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 19 May 2005 06:24:43 +0000
Subject: i2c-yosemite
Message-Id: <20040222103036.A29210@infradead.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040222104106.714de992.khali@linux-fr.org>
In-Reply-To: <20040222104106.714de992.khali@linux-fr.org>; from khali@linux-fr.org on Sun, Feb 22, 2004 at 10:41:06AM +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LM Sensors <sensors@stimpy.netroedge.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Manish Lachwani <lachwani@pmc-sierra.com>, Greg KH <greg@kroah.com>

On Sun, Feb 22, 2004 at 10:41:06AM +0100, Jean Delvare wrote:
> If everyone reimplements what already exists, the kernel is likely to go
> bigger with no benefit. Also, you won't be able to use all user-space
> tools that already exist, and will also have to write specific chip
> drivers for the chips present on the yosemite bus, although these
> drivers (Atmel 24C32 EEPROM and MAX 1619) already exist.
> 
> Please explain to us why you cannot/don't want to use the existing i2c
> subsystem.

Yupp.  While we're at it what should we do with the i2c reimplementations
in alsa and dvb?
