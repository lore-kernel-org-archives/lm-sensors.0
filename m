From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:23:53 +0000
Subject: success on Asus P4S8X-X
Message-Id: <20030413180913.GB17239@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030413142338.GA1452@creatis.insa-lyon.fr>
In-Reply-To: <20030413142338.GA1452@creatis.insa-lyon.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Fabrice Bellet <fabrice@bellet.info> [2003-04-13 16:23:38 +0200]:

> So I added support for the SiS963 bridge in i2c-sis645.c. The patch is
> attached for version 2.7.0 (merging code from the CVS too).

Thank you.  You are the second person to submit such a patch.  I'm
not sure what to do with it, because CVS tag lk2-4 is broken and
has been abandoned for many weeks now.

At this point, if nobody is interested in finishing what Kyosti
started, I think we should either a) re-branch from 2.7.0 to support
kernel 2.4 or b) announce in bold type on the sensors homepage that
2.7.0 is *it* for 2.4.

> When inserting the i2c-sis645 module, I trigger this warning in my logs,
> but this message seems harmless, as it doesn't prevent the sensors from
> working in presumably the right way :
> 
> Apr 13 14:29:03 lxorgfr kernel: PCI: No IRQ known for interrupt pin B of device 00:02.1. Please try using pci=biosirq.

You're right this is harmless, because the 645 module does not use
interrupts (it may in the future).

> Values look coherent, and do not differ very much from the 
> ones that I can read in the BIOS.
> 
> The only required patch to w83781d.c has been to adapt the in0 and in1
> range of variation, that initially was too low, to the hardcoded 160 value, 
> instead of the folmula (vid=3500?280:vid/10). According to my motherboard 
> documentation, the VCore voltage range for the P4 processor is:
>   . between 1.750V to 1.850V with step of 0.025V for Willamette
>   . between 1.500V to 1.700V with step of 0.025V for Northwood (that's my 
>     case).
> The BIOS is configured by default to choose automatically the VCore voltage.

You are aware that most such tweaking happens in /etc/sensors.conf?
Look in the documentation for the vid setting.  Be sure to do "sensors
-s" after you change the config file.

> I also noticed a single crash during my tests, with these messages :
> 
> Apr 13 14:17:11 lxorgfr kernel: spurious 8259A interrupt: IRQ7.
> [...]
> Apr 13 14:22:00 lxorgfr kernel: i2c-sis645.o: SMBus Timeout! (0x00)
> Apr 13 14:22:35 lxorgfr kernel: i2c-sis645.o: SMBus Timeout! (0x00)
> Apr 13 14:23:05 lxorgfr kernel: i2c-sis645.o: SMBus Timeout! (0x00)
> [...]
> I don't know if this is related to the PCI IRQ message seens when
> inserting i2c-sis645.o ? This happened while I was repeateadly calling
> the sensors programs to tweak my mrtg configuration.

Now this is troubling... the PCI IRQ message is harmless because it
doesn't need interrupts, but if the I2C driver generates one on bus
timeout that's bad (i.e. I don't handle it).

Or, the spurious interrupt and bus timeout could be an unhappy
coincidence.  Did the bus timeout clear itself up later?

> Before using version 2.7.0, I also tried the CVS (lk2-4 tag for
> i2c and HEAD for lm_sensors), and insmod w83781d crashed :

Known problem - see above.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
