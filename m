From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:31 +0000
Subject: Patch for i2c-tsunami.c
Message-Id: <20031228155042.6ad19767.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3FEB9352.3080401@oden.homeip.net>
In-Reply-To: <3FEB9352.3080401@oden.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I've spent some time playing with the i2c-tsunami kernel driver on my 
> DS10 Alphaserver. I'm working on a Debian stable system using kernel 
> 2.4.18 and I installed i2c and lm-sensors 2.8.1 from backports.org.
> The supplied i2c-tsunami.c will not compile correctly and even when I
> fixed the compile issue the module would oops upon any read/write
> attempts. The simple patch below solved both the compile issues and
> the kernel oops, though I didn't complete when appears to be an
> attempt to convert this module to a newer interface (the static struct
> pci_driver stuff). The module now works fine on this test system,
> though there is nothing but eeproms on the i2c bus connected to the
> tsunami chipset on this machine :-)

Thanks, I've applied your patch (well, somehow modified, but that's it
really). I think none of us core developers have an Alpha machine to
test the i2c-tsunami driver on, which must be why we didn't notice the
problem before.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
