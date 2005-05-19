From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:21 +0000
Subject: Bug #1807: sensors with kernel 2.4, but not with kernel 2.6
Message-Id: <T3nZ7Txh.1099499730.5028190.khali@gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <1099499003.11618.13.camel@antares.hausnetz>
In-Reply-To: <1099499003.11618.13.camel@antares.hausnetz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Benjamin,

> > If both drivers load properly, you should take a look 
> > at /sys/bus/i2c/devices/.
> > In this directory, you should find a subdirectory for the asb100. If you
> > don't, then either kernel driver is faulty. If you do, then the kernel
> > is fine and the user-space if faulty.
>
> The modules themselves load properly, the directory in /sys/bus/i2c/drivers
> gets created:

What I am mostly interested is the devices directory, not the drivers
directory. Do you see any subdirectory named *-002d there, those
"name" file reads asb100? What else do you see in this subdirectory?
There should be a whole bunch of in*, temp* and fan* files.

Thanks,
Jean
