From: fabrice@bellet.info (Fabrice Bellet)
Date: Thu, 19 May 2005 06:23:53 +0000
Subject: success on Asus P4S8X-X
Message-Id: <20030413211407.GA7682@creatis.insa-lyon.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030413142338.GA1452@creatis.insa-lyon.fr>
In-Reply-To: <20030413142338.GA1452@creatis.insa-lyon.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Apr 13, 2003 at 02:09:13PM -0400, Mark M. Hoffman wrote:
> > The only required patch to w83781d.c has been to adapt the in0 and in1
> > range of variation, that initially was too low, to the hardcoded 160 value, 
> > instead of the folmula (vid=3500?280:vid/10). According to my motherboard 
> > documentation, the VCore voltage range for the P4 processor is:
> >   . between 1.750V to 1.850V with step of 0.025V for Willamette
> >   . between 1.500V to 1.700V with step of 0.025V for Northwood (that's my 
> >     case).
> > The BIOS is configured by default to choose automatically the VCore voltage.
> 
> You are aware that most such tweaking happens in /etc/sensors.conf?
> Look in the documentation for the vid setting.  Be sure to do "sensors
> -s" after you change the config file.

yep.

"set vrm 9.0" worked. thanks.
now I have a better vid value :

VCore 1:   +1.58 V  (min =  +1.44 V, max =  +1.60 V)              
[...]
vid:      +1.525 V

I just can now ear a very short alarm signal trigered by the motherboard,
after the module is loaded, and before "sensors -s" is launched. I can 
live with that. I usually don't reboot very often :-)

> > I also noticed a single crash during my tests, with these messages :
> > 
> > Apr 13 14:17:11 lxorgfr kernel: spurious 8259A interrupt: IRQ7.
> > [...]
> > Apr 13 14:22:00 lxorgfr kernel: i2c-sis645.o: SMBus Timeout! (0x00)
> > Apr 13 14:22:35 lxorgfr kernel: i2c-sis645.o: SMBus Timeout! (0x00)
> > Apr 13 14:23:05 lxorgfr kernel: i2c-sis645.o: SMBus Timeout! (0x00)
> > [...]
> > I don't know if this is related to the PCI IRQ message seens when
> > inserting i2c-sis645.o ? This happened while I was repeateadly calling
> > the sensors programs to tweak my mrtg configuration.
> 
> Now this is troubling... the PCI IRQ message is harmless because it
> doesn't need interrupts, but if the I2C driver generates one on bus
> timeout that's bad (i.e. I don't handle it).
> 
> Or, the spurious interrupt and bus timeout could be an unhappy
> coincidence.  Did the bus timeout clear itself up later?

No. I had to power the motherboard off before restarting.  The 
'sensors' command was blocked, and could not be killed.

Best wishes,
-- 
fabrice
