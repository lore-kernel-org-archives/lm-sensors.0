From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: Question on how to update i2c with kernel 2.4.21 or greater
Message-Id: <20030815092649.601c5c47.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1060904999.1154.23.camel@lcomp18.tanccrusher.com>
In-Reply-To: <1060904999.1154.23.camel@lcomp18.tanccrusher.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Hi, I am confused on how to get lm_sensors updated with kernel 2.4.21
> or greater. I have seen
> http://www.ensicaen.ismra.fr/~delvare/devel/i2c/
> page, but I am misunderstanding what happens.
> 
> This is what I have done so far. I have kernel 2.4.21 and have applied
> patch-2.4.22-rc2 to it. Needed to go to this point to get USB 2.0 mass
> storage devices to work. So from here what command do I issue to
> update i2c to patch into the kernel?
> 
> I have tried this.
> patch -p1 -E < linux-2.4.21-i2c-2.8.0.patch
> 
> and got these results.
> (snip)
> patching file drivers/i2c/i2c-algo-bit.c
> Hunk #28 FAILED at 557.
> 1 out of 29 hunks FAILED -- saving rejects to file
> drivers/i2c/i2c-algo-bit.c.rej
> (snip)
> As you can see I have a few errors above. Is this the correct way to
> get this to work? If not what is the correct procedure?

The patch is meant to be used with kernel 2.4.21. Since some
modifications were made to files the patch tries to modify, they
conflict and the patch fails to apply at these points. We'll release a
new patch as soon as kernel 2.4.22 is out.

If you don't have any additional driver using I2C, then you don't need
to patch your kernel. Simply compile i2c 2.8.0 and lm_sensors 2.8.0 in
their respective directories, and install them. Note that installing i2c
*must* happen before compiling lm_sensors.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
