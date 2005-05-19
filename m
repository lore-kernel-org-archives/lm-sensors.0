From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:51 +0000
Subject: Cannot have lm-sensors work with my NV7m ABIT motherboard
Message-Id: <20030323115636.258a2375.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1048326224.4015.63.camel@Ordiyann>
In-Reply-To: <1048326224.4015.63.camel@Ordiyann>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


*** PLEASE ANSWER TO THE LIST, NOT TO ME ONLY ***

> > It looks like you had some drivers already loaded when you ran
> > sensors-detect, and it confused the script. So, please first unload
> > all sensors-related modules (using rmmod, and check with lsmod),
> > issue a"depmod -a" just to make sure, and run sensors-detect again.
> > Do *NOT* answer yes when asked about non-detectable adapters. Your
> > adapter is on the PCI bus, it is known and you probably don't have
> > anything else(nothing useful anyway).
> > 
> > Let us know what happens then.
> 
> Thank you for your very quick answer.
> (...)
> First, here are the modules that are loaded before the experience:
> 
> [root@ordiyann yann]# lsmod
> Module                  Size  Used by    Not tainted
> radeon                107428   0
> lp                      8096   0
> parport_pc             25096   1
> parport                34176   1  [lp parport_pc]
> es1371                 29000   2
> ac97_codec             12488   0  [es1371]
> gameport                3316   0  [es1371]
> nfsd                   74256   0  (autoclean)
> af_packet              14952   0  (autoclean)
> sr_mod                 16920   0  (autoclean)
> floppy                 55132   0
> 8139too                17160   1  (autoclean)
> mii                     3832   0  (autoclean) [8139too]
> supermount             15296   2  (autoclean)
> ide-cd                 33856   0
> cdrom                  31648   0  [sr_mod ide-cd]
> tuner                  11744   1  (autoclean)
> tvaudio                15068   0  (autoclean) (unused)
> bttv                   78496   0
> i2c-algo-bit            9064   1  [bttv]
> i2c-core               21192   0  [tuner tvaudio bttv i2c-algo-bit]
> soundcore               6276   0  [es1371 bttv]
> ide-scsi               11280   0
> scsi_mod              103284   2  [sr_mod ide-scsi]
> scanner                10904   0
> dsbr100                 5176   1
> videodev                7872   4  [bttv dsbr100]
> usb-ohci               20584   0  (unused)
> usbcore                72992   1  [scanner dsbr100 usb-ohci]
> rtc                     8060   0  (autoclean)
> ext3                   59916   8
> jbd                    38972   8  [ext3]

There are sooooo many! Impressive. Never seen so much before, even using
ALSA.

> And here is the output of the newly executed sensors-detect:
> 
> [root@ordiyann yann]# sensors-detect
>  This program will help you to determine which I2C/SMBus modules you
> need to
>  load to use lm_sensors most effectively.
>  You need to have done a `make install', issued a `depmod -a' and made
> sure
>  `/etc/conf.modules' (or `/etc/modules.conf') contains the appropriate
>  module path before you can use some functions of this utility. Read
>  doc/modules for more information.
>  Also, you need to be `root', or at least have access to the
> /dev/i2c[-/]* files
>  for some things. You can use prog/mkdev/mkdev.sh to create these /dev
> files
>  if you do not have them already.
>  If you have patched your kernel and have some drivers built-in you
>  can safely answer NO if asked to load some modules. In this case,
>  things
> may
>  seem a bit confusing, but they will still work.
> 
>  BIOS vendor (ACPI): Nvidia
>  We can start with probing for (PCI) I2C or SMBus adapters.
>  You do not need any special privileges for this.
>  Do you want to probe now? (YES/no):
> Probing for PCI bus adapters...
> Use driver `i2c-amd756' for device 00:01.1: nVidia nForce SMBus
> Probe succesfully concluded.
> 
>  We will now try to load each adapter module in turn.
> Load `i2c-amd756' (say NO if built into your kernel)? (YES/no):
> Module loaded succesfully.
>  Do you now want to be prompted for non-detectable adapters? (yes/NO):
>  To continue, we need module `i2c-dev' to be loaded.
>  If it is built-in into your kernel, you can safely skip this.
>  i2c-dev is not loaded. Do you want to load it now? (YES/no):
>  Module loaded succesfully.
> 
>  We are now going to do the adapter probings. Some adapters may hang
> halfway
>  through; we can't really help that. Also, some chips will be double
> detected;
>  we choose the one with the highest confidence value in that case.
>  If you found that the adapter hung after probing a certain address,
>  you
> can
>  specify that address to remain unprobed. That often
>  includes address 0x69 (clock chip).
> 
> Next adapter: bt848 #0 (Bit-shift algorithm)
> Do you want to scan it? (YES/no/selectively): no
> 
> Next adapter: SMBus nVidia nForce adapter at ec00 (Non-I2C SMBus
> adapter)
> Do you want to scan it? (YES/no/selectively):
> Client found at address 0x00
> Client found at address 0x01
> Client found at address 0x02
> Client found at address 0x03
> Client found at address 0x04
> Client found at address 0x05
> Client found at address 0x06
> Client found at address 0x07
> Client found at address 0x08
> Client found at address 0x09
> Client found at address 0x0a
> Client found at address 0x0b
> Probing for `Smart Battery'... Failed!
> Client found at address 0x0c
> Client found at address 0x0d
> Client found at address 0x0e
> Client found at address 0x0f
> Client found at address 0x10
> Client found at address 0x11
> Client found at address 0x12
> Client found at address 0x13
> Client found at address 0x14
> Client found at address 0x15
> Client found at address 0x16
> Client found at address 0x17
> Client found at address 0x18
> Probing for `Analog Devices ADM1021'... Failed!
> Probing for `Maxim MAX1617'... Success!
>     (confidence 3, driver `adm1021')
> Probing for `Maxim MAX1617A'... Failed!
> Probing for `TI THMC10'... Failed!
> Probing for `National Semiconductor LM84'... Success!
>     (confidence 6, driver `adm1021')
> Probing for `Genesys Logic GL523SM'... Failed!
> Probing for `Onsemi MC1066'... Failed!
> Client found at address 0x19
> Probing for `Analog Devices ADM1021'... Failed!
> Probing for `Maxim MAX1617'... Success!
>     (confidence 3, driver `adm1021')
> Probing for `Maxim MAX1617A'... Failed!
> Probing for `TI THMC10'... Failed!
> Probing for `National Semiconductor LM84'... Success!
>     (confidence 6, driver `adm1021')
> Probing for `Genesys Logic GL523SM'... Failed!
> Probing for `Onsemi MC1066'... Failed!
> Client found at address 0x1a
> Probing for `Analog Devices ADM1021'... Failed!
> Probing for `Maxim MAX1617'... Success!
>     (confidence 3, driver `adm1021')
> Probing for `Maxim MAX1617A'... Failed!
> Probing for `TI THMC10'... Failed!
> Probing for `National Semiconductor LM84'... Success!
>     (confidence 6, driver `adm1021')
> Probing for `Genesys Logic GL523SM'... Failed!
> Probing for `Onsemi MC1066'... Failed!
> (...)

It's all f*cked up. Your I2C bus has gone crazy or something... It
pretends to have a client on each address, which of course makes no
sense.

Maybe someone else on the list has an idea on what's going on (yes,
Mark, you're the one I'm talking about ;)).

For me, I would simply try some simple things to see what happends. For
example, I'll try not to load the bttv module and associated modules.
They use I2C too, maybe there's a conflict between us and them.

You could also try another version of I2C/LM Sensors. I don't know which
version you are using, 2.7.0 I guess. You could try CVS, though I admit
there's no particular reason it would change something.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
