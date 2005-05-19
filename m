From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:04 +0000
Subject: SAA1064 sensors chip driver
Message-Id: <20030714134640.5671240c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307131153.24333.sascha@akv-soft.de>
In-Reply-To: <200307131153.24333.sascha@akv-soft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I've started to write an i2c sensors chip driver for the Philips
> SAA1064 LED driver (on
> http://www.magoa.net/linux/index.php?view=kathrein you can see two of
> those working). Work is progressing, first tests already work with
> 2.4.20, as that thing is really easy to handle (I used to drive it
> with from userspace before). I'd hereby like to request a driver ID 
> (I2C_DRIVERID_SAA1064) and yes, you may put my name onto the new
> drivers page if you like :-).

Here you are:
#define I2C_DRIVERID_SAA1064 1041

You should take a look at our matorb driver, which handles Matrix
Orbital LCD displays. There may be similar mechanisms with the hardware
you are writing a driver for. Probably not enough to make a similar
driver (not even the same I2C address) but worth the look anyway.

Once you have your driver ready, send it to us so that we can have a
look and tell you what we think about it. If you follow the guidelines
as found in our docs, it should be OK. Howevern, due to a recent change
in our structures, if you have written your driver for the 2.4.21 Linux
kernel, it won't integrate directly into lm_sensors CVS. Don't worry,
we'll take care of this point.

We also have to find a detection mechanism for the SAA1064. It doesn't
seem to have any register dedicated to identification, so it will be
tricky. However, it looks like there are only three wires for register
selection, so maybe the data will "cycle" over 8-byte boundaries (the
same way the LM75 cycles over 4-byte boundaries. That, plus the fact
that the SAA1064 uses an unusual address range (0x38-0x3b), should make
the detection possible. Could you send us the output of i2cdump for
confirmation? Also, bit 7 of the control register seems to be unused, as
seem to be the registers 0x05 to 0x07. That may help for the detection
too.

> Also, I'd like to be added as a recipient for the lm_sensors mailing
> list. Please enter lists@magoa.net, as that's the account I am using
> to manage my mailing lists.

Phil will do so when he's back, I hope.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
