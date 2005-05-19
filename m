From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: [PATCH 2.6] Autoselect i2c algos
Message-Id: <20040119231930.20e6b6c4.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040118230033.07539111.khali@linux-fr.org>
In-Reply-To: <20040118230033.07539111.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I took out your dependancy on PCI you added to the PCILynx driver.
> That's up to the ieee1394 people to determine :)

I did not add a dependency on PCI to the *driver*. I did add a
dependancy to the *comment* that replaces the driver when I2C is
missing. These are different things, and I don't see any reason not to
do so. As explained in my previous mail, without it the user could be
confused if he doesn't have PCI enabled (see the warning, adds I2C to
solve it, no more warning but no driver either). What's wrong with my
fix?

> I applied that patch, and then had to add the following change to keep
> us from trying to build MIPS specific code.

OK, adding it to my personal collection as well.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
