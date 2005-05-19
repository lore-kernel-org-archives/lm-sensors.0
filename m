From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:15 +0000
Subject: Sensors whackyness under 2.6.x
Message-Id: <20030829182958.3f82dbef.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030815110924.GC501@zip.com.au>
In-Reply-To: <20030815110924.GC501@zip.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> It gets whackier. I get the same results from both 2.4 and 2.6 now and
> they're different to before! Joy.

This simply proves that the problem is much more complex that you may
have first thought. I'm completely lost myself.

> rmmoding the modules under either version did not help. The sensors
> data was whacky too. here's one snapshot:
> 
> thmc10-i2c-0-4d
> Adapter: SMBus PIIX4 adapter at 2180
> Algorithm: Non-I2C SMBus adapter
> Board:      -101?C  (min =  +20?C, max = -101?C)
> CPU:        -101?C  (min =  +20?C, max = -101?C)ALARM (LOW,HIGH)

You were supposed to use adm1021, and now it seems that you are using
thmc10. Could you explain that to us?

> > What if you load i2c-piix4 first, and then adm1021? If the slowdowns
> > appear before loading adm1021, then the i2c-piix4 driver is at
> > fault, else either adm1021 or i2c-piix4 is at fault.
> 
> I did it in the order above. Slowdowns did not happen till I loaded
> the system.

What if you don't load any chip driver (thmc10 nor adm1021) and load the
system?

> > I would like you to try with i2c-CVS and lm_sensors-CVS. We made a
> > change to the i2c-piix4 driver recently that could influence your
> > problem. Download instructions are to be found here:
> > http://secure.netroedge.com/~lm78/download.html#cvs
> 
> Do you still want me to do this?

Sure I want.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
