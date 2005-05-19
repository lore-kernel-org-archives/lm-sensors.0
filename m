From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:23:56 +0000
Subject: adm1021
Message-Id: <3EC3C61F.5030301@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1053016162.621.76.camel@zrr>
In-Reply-To: <1053016162.621.76.camel@zrr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

What motherboard do you have?  Some Tyan motherboards require a special 
utility to make the CPU I2C devices visible.  A BIOS update might remove the 
need for the utility.

Have you tried loading the adm1021 driver.  It will detect and initialize any 
adm1021 compatible devices if they are found.  Intel used several different 
adm1021 compatible devices on 400MHz FSB Xeon CPUs'.  ADM1023 and MAX1617 were 
both popular...

If you have a 533MHz FSB Xeon, then you don't have "on-cpu" thermal monitoring 
chips and you should find the CPU temperatures via thermal diode monitoring on 
a Winbond or other monitoring chip.

:v)

Zeno R.R. Davatz wrote:

> Hi 
> 
> I would like to force load the adm1021. I got a Dual Intel Xeon -based
> Motherboard.
> 
> but the prog/detect/i2cdetect.c is not prog/detect/i2cdetect
> 
> Where can I find the i2cdetect without the .c?
> 
> I am willing to test on my new server.
> 
> Thanks for your time and help.
> 
> Zeno
> 
> 

