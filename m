From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: Help me with VT82C586B
Message-Id: <PSsLVwCI.1111740177.5804970.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <14410443364.20050325100723@omskart.ru>
In-Reply-To: <14410443364.20050325100723@omskart.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


[Alexey]
> > HELP!
> >
> > /usr/local/bin/sensors
> > eeprom-i2c-0-51
> > Adapter: VIA i2c
> > Memory type:            SDR SDRAM DIMM
> > Memory size (MB):       128
> >
> > and that is all?

What is your problem exactly? We can't help if you don't clearly
explain what you did and what the problem is. Not all motherboards have
sensors. You don't even tell us what motherboard it is, not whether
sensors-detect found anything.


[Rudolf]
> Help is simply. Unload the i2c-viapro and it should work.
> Or upgrade kernel.

The VT82C586 is i2c-via, NOT i2c-viapro. It's an old thing.


[Alexey]
> > Under:Windows XP 5.1 Build 2600 Service Pack 2

Ah, that explains it. Our drivers are for Linux, that must be why it
doesn't work ;)

Joke left apart, would you consider a less lame signature?

Thanks,
--
Jean Delvare
