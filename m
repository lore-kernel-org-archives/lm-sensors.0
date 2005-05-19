From: ralf.roesch@rw-gmbh.de (=?US-ASCII?Q?Ralf_Rosch?=)
Date: Thu, 19 May 2005 06:24:50 +0000
Subject: AW: Fix in eeprom.c
Message-Id: <NHBBLBCCGMJFJIKAMKLHCEOECBAA.ralf.roesch@rw-gmbh.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040329193435.7d9a587d.khali@linux-fr.org>
In-Reply-To: <20040329193435.7d9a587d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean,
I have applied your eeprom.c patch and tested.
Your fix is quite similar to mine and works fine for me.

Thanks
--
Ralf



> -----Ursprungliche Nachricht-----
> Von: ralf@arbeitsgruppe [mailto:ralf@arbeitsgruppe]Im Auftrag von Jean
> Delvare
> Gesendet: Donnerstag, 1. April 2004 23:17
> An: LM Sensors
> Cc: Ralf Roesch; Greg KH
> Betreff: Re: Fix in eeprom.c
> 
> 
> > > Greg, I would be interested in your opinion. Should we update all
> > > our chip drivers to have two memory allocations instead of a single
> > > one for this?
> > 
> > Yeah, we probably should :(
> 
> OK... Here we go. I've converted all drivers in our CVS repository to a
> new model where we do the two kmallocs separately. I didn't commit it
> yet because it's a very important change (47 chip drivers affected). So
> I'd appreciate code reviews and tests before I apply it.
> 
> The patch is here:
> http://jdelvare.net1.nerim.net/sensors/lm_sensors-CVS-separate-mal
locs.diff
It applies on latest CVS.

I tested only the eeprom and lm90 drivers so far. Seems to work, but the
changes are error-prone so what it "seems" is hardly enough to be sure
it's correct.

Ralf, can you confirm that the patche solves your memory alignment
problem with the eeprom driver on MIPS?

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

