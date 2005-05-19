From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:26 +0000
Subject: Ticket 1834 Update
Message-Id: <KC69qxLV.1102495232.5379810.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <41B1D44F.4090303@vfx.to>
In-Reply-To: <41B1D44F.4090303@vfx.to>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I don't know what the chip at 2f could be; if sensors-detect doesn't
> identify it then you may be able to look at your board and search for
> likely candidates with google.

No idea either. All I can say is that it doesn't look like a recent
hardware monitoring device (no identification register). It also
doesn't have enough registers to be a full-featured hardware monitoring
chip, but too many to be a simple I2C multiplexer or I/O expander.

You might dump it again from times to times and see if any value changes.
If this is a hardware monitoring chip then some values have to slightly
change between dumps.

--
Jean Delvare
