From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: Follow up for Ticket 1538
Message-Id: <1075293489.4017ad31341d7@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <LAECJBKLNEJMMONPNMGPGEFPCBAA.pierre.lamon@epfl.ch>
In-Reply-To: <LAECJBKLNEJMMONPNMGPGEFPCBAA.pierre.lamon@epfl.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> it would be nice if you can find what's going on. Here is a detailed
> description of the problem (kernel 2.4.24):
> 
> While modprobing the module the following error occurs (modprobe
> i2c-pcf-epp):
> 
> On the console:
> /lib/modules/2.4.20/kernel/drivers/i2c/i2c-pcf-epp.o: init_module: No
> such device or address
> Hint: insmod errors can be caused by incorrect module parameters,
> including invalid IO or IRQ parameters
> /lib/modules/2.4.20/kernel/drivers/i2c/i2c-pcf-epp.o: insmod
> /lib/modules/2.4.20/kernel/drivers/i2c/i2c-pcf-epp.o failed
> /lib/modules/2.4.20/kernel/drivers/i2c/i2c-pcf-epp.o: insmod
> i2c-pcf-epp failed

So this has do be 2.4.20, not 2.4.24. Nevermind.

> Here is the content of dmesg:
> i2c-core.o: i2c core module version 2.8.2 (20031211)
> i2c-pcf-epp.o: i2c pcf8584-epp adapter module version 2.8.2
> (20031211)
> i2c_pcf_add_bus caused an error: -6

This basically means that your PCF8584 wasn't detected as such. We
would
need more details to track the problem. Please unload the i2c-algo-pcf
module and reload it with with "i2c_debug=3". That way, the log will be
much more verbose. And try again ;)

> After (there is a segfault)
> Unable to handle kernel paging request at virtual address cf86666b
> *pde = 0ed3e067
> *pte = 00000000
> (...)
>  Segmentation fault

This is very bad. Whatever happens, *this* shouldn't happen. I think
you
need to pass this through a program called ksymoops if we want to see
where exactly the problem happened.

> The available bios options are as follow (related to the parallel
> port):
> 
> Onboard parallel port : [3BC/IRQ7] or [378/IRQ7] or [278/IRQ5]
> (choosen
> [378/IRQ7])
> Onboard parallel mode : [EPP] or [ECP] or [ECP/EPP] (choosen [EPP])
> EPP type: [EPP1.7] or [EPP1.9] (choosen [EPP1.9])
> 
> IRQ-7 assigned to [Legacy ISA] or [PCI/ISA PnP] (choosen [PCI/ISA
> PnP])
> 
> Which configuration should I use ?

That I can't tell. Choosing EPP is obviously correct, but I cannot tell
you which version is "best" (if that matters). As for Legacy vs. Pnp,
it depends on wether you enabled PNP support in your kernel. If you do,
choose PnP. If you didn't, better choose ISA and let the BIOS assign
the IRQ for you.

> > Great. Couldn't you do the same with more simple parallel-ports
> > adapters, such as i2c-philips-par, i2c-elv or i2c-velleman? These
> > have been ported to Linux 2.6 already, and are supported by my
> > unified driver too, while i2c-pport hasn't been ported and isn't
> > part of the unified driver.
> 
> Since we have developped our own PC104 motherboard we wanted to
> integrate the i2c circuit on it. I couldn't find the elv and velleman
> schematics.
> Furthermore, I was concerning about the performances: hoping that the
> use of the PCF8584 will provide better performance. (less cpu load,
> interrupt driven for byte reading, etc.)

I'll try to draw a sample schematics. It's more simple than the one for
i2c-pport IMHO. Basically, i2c-pport uses the bidirectionality of some
pins in order to use 2 pins of the parallel port only instead of 3 or
4, and allows the concurent use of another parallel port device. Other
drivers don't allow this - but I don't think you need it, do you?

> i2c-pport was very convenient for testing. It took less than an hour
> for wiring the cables, loading the module and detecting the slave
> with i2cdetect. I might not be the only one who needs it.

The real question is wether you could have done the same with the same
ease with the new i2c-parport module, providing a sample schematics
similar to the one for i2c-pport was given.

I guess that at least the author of i2c-pport is using it ;) but I
still
believe that in 99% of the cases, the extra complexity is not needed.
This is the reason why I still hesitate to integrate i2c-pport into the
new 2.6 driver.

Great that our work can be of some use to you :)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
