From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:23 +0000
Subject: Donation.
Message-Id: <20031030215747.0ea3525c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <F7CB408531C5264680C9E37DE4FE71A4088FDF@limkexm2.ad.analog.com>
In-Reply-To: <F7CB408531C5264680C9E37DE4FE71A4088FDF@limkexm2.ad.analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > > You might need to use an old DIMM to tap into the SMBus & power,
> > > or you might be lucky enough to have some jumpers on the mobo
> > > which make it easy to tap into these things.
> 
> In particular many Asus mainboards have SMBus pins.  I've never seen
> anything advertised by them to connect to it... but I did hook up a
> scope to one of mine to confirm that it works.

I got two Asus boards here (TX97-E and A7V133-C). If the pins are
unadvertised, how will I know where to find them? Anyway I chose the
software path for now... although it doesn't work.

> If you can get hold of one of those Asus boards... there wouldn't be
> any *difficult* soldering.  ;)

Still I don't have the more simple electronics tools to do that, poor
me.

> > Either one of our modules can be easily adapted to handle the
> > evaluation board, or I'll write one, providing Sean can explain to
> > me how to do that. I guess it's a simple problem of writing the
> > right things at the right time on the parallel port. Sean, are the
> > SCL and SDA lines handled by the software and transmitted to the
> > eval board through the parallel port, or are these signals generated
> > on the board itself and simply controlled by the parallel port?
> 
> They sent an eval board without a schematic?  Tsk, tsk.  ;)

There is a beautiful schematic on the CD. You can't blame AD, their kit
is excellent. Had I read it before posting, I wouldn't have to ask Sean
about it (although my knowledge isn't sufficent to refuse
confirmations).

> I think that i2c-pcf-epp is for a Phillips I2C controller chip wired
> to a parallel port.  If the eval board connects SCL/SDA directly to
> the parallel port, then you want i2c-pport.  This may also need some
> work depending on how SCL/SDA are wired to the parallel cable.

You're right, i2c-pport is obviously what I need. I tweaked the values
there to match what I read on the schematic. I think I have everything
OK, but I can't get it to work for some reason. See my reply to Sean for
details.


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
