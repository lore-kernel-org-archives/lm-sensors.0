From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: failed again; vetctor 300
Message-Id: <20030806123715.2910cd2f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030805222340.3799d819.zdavatz@ywesee.com>
In-Reply-To: <20030805222340.3799d819.zdavatz@ywesee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Ok thanks again, my Computer rebooted. 
> 
> Jean Delvare writes: 
> 
> > rm *.o
> > rm -r busses
> > rm -r chips
> 
> Does this affect my sound? 

It could, if your sound chip is using the i2c bus.

(Flash of Insight)

OMG, that's it. You just found the reason why everything dies each time
you try to install lm_sensors. Let's see if I'm right.

You have been trying to install i2c-2.8.0 and lm_sensors 2.8.0.

You have a PPC system and use an audio driver that relies on the I2C bus
(DAC3550A or TAS3001C).

You have been installing i2c from its own directory, you did *not* use
the i2c kernel patch.

You use Gnome, and Gnome tries to setup the sound at startup, because it
will sometime play sound on particular events (or simply setups the ESD
sound daemon).

Am I wrong on any point? If I'm not, I fully understand what happened. I
have been wrong pretending this wasn't our fault, because it actually is
(well, sort of).

(It does *not* explain why sensors-detect locks on the ISA bus scanning,
but it explains the trouble you have been encountering after installing
lm_sensors, or, more precisely, i2c-2.8.0).

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
