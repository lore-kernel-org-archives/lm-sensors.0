From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 12 Dec 2005 18:16:28 +0000
Subject: [lm-sensors] lm_sensors and nvidia graphic card	temperature
Message-Id: <20051212191628.14d6ea0c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Volker,

> [nvidia graphics card temp monitoring]
> 
> > You can try:
> > 1) load i2c-rivatv (or whatever driver for the i2c nvidia bus)
> 
> i2c-nvidia2 is loaded automatically, but sensors-detect only finds 2
> dimm eeproms and the mobo's it8712. However, it finds two adapters, but
> no success on the first: 
> 
> Next adapter: SMBus nForce2 adapter at 1c40
> Do you want to scan it? (YES/no/selectively): 
> Client found at address 0x08
> Client found at address 0x4e
> [all failed]
> 
> Next adapter: SMBus nForce2 adapter at 1c00
> Do you want to scan it? (YES/no/selectively): 
> Client found at address 0x08
> Client found at address 0x50
> [2 eeproms found]

i2c-nvidia2 doesn't exist as far as I know. You must refer to
i2c-nforce2, I presume? If so, this is totally unrelated with the
busses found on graphics adapters. i2c-nforce2 is meant for motherboard
SMBus.

> What kernel module should I load exactly? Google doesn't know anything
> about i2c-rivatv.

Search for rivatv instead - see my other post.

> > Run sensors detect it  should find he w83785
> 
> modprobe w83l785ts is fine. No change with sensors-detect though.

Rudolf's w83785 driver is meant for the Winbond W83L785R chips, which
is a full-featured hardware monitoring chip. My w83l785ts driver, OTOH,
is meant for the Winbond W83L785TS-S, which is a very simple
single-temperature sensor. I think I remember both devices are
compatible, in that you should get proper temperature readings if
forcing the w83l785ts driver on a W83L785R chip. Both drivers could be
merged to make things easier, but nobody had an interest in working on
it so far, it seems.

> Being able to get the temp of the geforce 6600 chip would be cool, as I
> have a temp problem with it. What else could I try?

rivafb, nvidiafb.

-- 
Jean Delvare

