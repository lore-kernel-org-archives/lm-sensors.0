From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:26 +0000
Subject: lm_sensors problem with sis96x and adm1021
Message-Id: <77JhTnSN.1102693660.3879540.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <41B9BDFD.6070102@gmx.de>
In-Reply-To: <41B9BDFD.6070102@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> actually I wanted to send this email to the lm_sensors mailing-list but
> I couldn't find it.
> Maybe you could tell me the address so I know next time :-)

The address is advertised here:
http://secure.netroedge.com/~lm78/author.html
I wonder why so many people have a hard time finding it.

The address you are writing to at the moment is an alias for the list, so
you finally found it ;)

> I already started a ticket with the number 1841.
> When running sensors -s and then sensors I get
>
> asus:/sys/bus/i2c/devices/0-004c# sensors
> max1617-i2c-0-4c
> Adapter: SiS96x SMBus adapter at 0x0c00
> Board:       +56??C  (low  =    +0??C, high =   +70??C)
> CPU:         +54??C  (low  =   +50??C, high =   +70??C)
>
> So the values for Board have been set correctly but for CPU it shows no
> effect.

These values are different from what you said on the ticket, so there
have actually been some values written at some point. In the ticket I
told you to try writing the values to the sysfs files directly and see
how it was going. Did you try? Beware that sysfs expects temperature
values in 0.001 degree C (so for example 70 degrees is 70000).

> I was told to send a dump of the chip so here it is.
> (...)

This is most certainly a Maxim MAX6657, MAX6658 or MAX6659, not MAX1617.
Do you have some documentation that would confirm that? I guess you do
not have the possibility to open the case and check ;)

The sensors-detect script should have detected the chip and suggested the
lm90 driver, not adm1021. Didn't it? Please provide the full log of
sensors-detect *after* you unload the adm1021 driver.

--
Jean Delvare
