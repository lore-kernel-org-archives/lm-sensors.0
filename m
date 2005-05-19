From: mr-smoke@spinning-plates.eu.org (Romain Riviere)
Date: Thu, 19 May 2005 06:24:15 +0000
Subject: Ticket 1382 : Update
Message-Id: <1062432703.5086.7.camel@marla.spinning-plates.eu.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1061487346.2223.4.camel@marla.spinning-plates.eu.org>
In-Reply-To: <1061487346.2223.4.camel@marla.spinning-plates.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi again,

> > 2 more questions :
> > - has anyone found a reliable way to read the via686a's output ? it's
> > offset by approx. 5?C here...
> 
> Which values are you comparing with? The "idle" temperature may vary
> from OS to OS (and from OS to BIOS setup screen), so the temperature
> offset may be normal.

Well, there is a significant difference between the readings I get from
the BIOS and those form sensors. I don't think that the CPU has enough
time to cool down by over 5?C between the moment I shutdown Linux and I
access the BIOS for example... 
> If you want to correct it, you still can edit your /etc/sensors.conf
> file. "Compute tempX @+5, @-5" should do it (or the contrary, depending
> on the offset sign).
Well I'll try that ... although I'm not sure is as simple as that, I'll
prolly have to do a little benchmark.

> If you believe this is a bug in our driver and can prove it, we'll of
> course fix it.
I think it's more related to what seems to be a common problem with VIA
chipsets, ie the temp readings are not accurate. :(

> See our installation guide here:
> http://www.ensicaen.ismra.fr/~delvare/devel/i2c/
> It describes your problem and a solution.
Thanx, I hadn't noticed the patch down there, working now :)
Although the only sensors listed on the card are eeprom, and not really
working. I thought there was a temp reading but maybe the card is too
old to have that (3D prophet, Geforce256 based card...)

> Note that the solution doesn't work with Linux 2.4.22 for now, but I'm
> currently working on an update (Hopefully available within the end of
> the day).
Well that's ok, I'm sticking to 2.4.21 for now, until grsec is patched
too.

If you don't mind my bothering you some more ...
- sensors-detect says:
Detects correctly:
  * Bus `SMBus Via Pro adapter at 0400' (Non-I2C SMBus adapter)
    Busdriver `i2c-viapro', I2C address 0x2d
    Chip `National Semiconductor LM80' (confidence: 3)
However, I don't think I've got that chip anywhere on my PC. I wonder
what chip could be misdetected like that, where to look ?

Thanks,
Romain

PS: if you like we can continue in French, unless there are other
readers of course, I happen to be French as well :P
