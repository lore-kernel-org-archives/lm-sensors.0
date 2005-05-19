From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:27 +0000
Subject: Configure.help entries for the I2C subsystem.
Message-Id: <3C1FE2ED.420D2E03@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200112130444.fBD4iW501669@snark.thyrsus.com>
In-Reply-To: <200112130444.fBD4iW501669@snark.thyrsus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Eric, 
those came from the MIPS people,
here's the lines from the top of drivers/i2c/i2c-algo-ite.c:

  
-------------------------------------------------------------------------
   i2c-adap-ite.c i2c-hw access for the IIC peripheral on the ITE MIPS
system
  
-------------------------------------------------------------------------
   Hai-Pao Fan, MontaVista Software, Inc.
   hpfan@mvista.com or source@mvista.com

   Copyright 2001 MontaVista Software Inc.

mds


"Eric S. Raymond" wrote:
> 
> Matthew David Reuther <mreuther@engin.umich.edu> suggested that your
> group might be able to suppy Configure.help entries for the following
> symbols:
> 
> CONFIG_ITE_I2C_ADAP: drivers/i2c/Config.in drivers/i2c/Makefile
> CONFIG_ITE_I2C_ALGO: drivers/i2c/Config.in drivers/i2c/Makefile
> 
> Please help if you can.  I'm vdery close to getting the Configure.help
> file completely caught up to the starte of the kernel; this would
> reduce the number of missing entries to 27
> --
>                 <a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>
> 
> The people of the various provinces are strictly forbidden to have in their
> possession any swords, short swords, bows, spears, firearms, or other types
> of arms. The possession of unnecessary implements makes difficult the
> collection of taxes and dues and tends to foment uprisings.
>         -- Toyotomi Hideyoshi, dictator of Japan, August 1588
