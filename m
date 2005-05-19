From: anton@korzh.ru (Anton A. Korzh)
Date: Thu, 19 May 2005 06:24:27 +0000
Subject: i2c for 2.6.0-test11
Message-Id: <1070262587.12645.6.camel@phoebus>
List-Id: <lm-sensors.vger.kernel.org>
References: <1070258710.3218.9.camel@phoebus>
In-Reply-To: <1070258710.3218.9.camel@phoebus>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

? ???, 01.12.2003, ? 09:20, Jean Delvare ?????:
> > sensors-detect gives following positive results:
> > 
> > Driver `lm80' (should be inserted):
> >   Detects correctly:
> >   * Bus `SMBus Via Pro adapter at 5000' (Algorithm unavailable)
> >     Busdriver `i2c-viapro', I2C address 0x2d
> >     Chip `National Semiconductor LM80' (confidence: 3)
> >  
> > Driver `via686a' (should be inserted):
> >   Detects correctly:
> >   * ISA bus, undetermined address (Busdriver `i2c-isa')
> >     Chip `VIA Technologies VT82C686 Integrated Sensors' (confidence:
> >     9)
> > 
> > sensors gives: 
> > [root@pueblo lm_sensors2]# sensors
> > eeprom-i2c-1-52
> > Adapter: SMBus Via Pro adapter at 5000
> > Algorithm: Unavailable from sysfs
> > Memory type: Unavailable
> >  
> > eeprom-i2c-1-51
> > Adapter: SMBus Via Pro adapter at 5000
> > Algorithm: Unavailable from sysfs
> > Memory type: Unavailable
> > 
> > 
> > What can you recommend me to do?
> > I have compiled i2c-dev,i2c-isa,i2c-viapro, all i2c chips(But there
> > are no lm80). Sysfs is mounted to /sys
> 
> Well, the lm80 driver hasn't been ported to Linux 2.6 yet, so you'll
> have to wait. If you are brave, you can port it yourself. I wrote a
> guide on how to do this, which should be part of Linux 2.6
> Documentation/i2c directory someday (but isn't yet either). I can send
> it to you if you want.

thanks i ll consider about doing it

> As for the via686a, it has been reported that it has to be loaded before
> other i2c drivers, or it fails detecting devices. I've experienced this
> myself. I've not yet investigated why it behaves that way (mainly
> because the via686a chipset I have isn't wired for proper input
> measurements). Again, feel free to help if you can, or you'll have to
> wait until we find a solution.

Do i understand correctly that i need to compile all that i2c stuff in
modules and load via686a module first - that will help?

And is that true that i need either lm80 working either via686a? I need
either ISA either SMbus sensors, or there will be some difference.



Merci de votre assistance,

Anton.
