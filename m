From: "Juerg Haefliger" <juergh@gmail.com>
Date: Sat, 12 Jul 2008 20:52:00 +0000
Subject: Re: [lm-sensors] cpu too hot
Message-Id: <191fb4ca0807121352v6c015422nb0a2a18a482b4747@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4878e8fc.2234440a.0460.3d0b@mx.google.com>
In-Reply-To: <4878e8fc.2234440a.0460.3d0b@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Gijs,


> l.s.
>
> my sony vaio laptop running fluxbuntu is getting way too hot and I am
> trying to get an idea of the temperature with lm-sensors.
> But I cannot make any sense of all the gibberish on this site or of the
> lengthy stories coming out of the installation script below.
> Although I am an IT professional, it seems one has to be a rocket
> scientist to simply measure the temperature of a device.

Well that would make my 5 year old daughter a rocket scientist then,
since she has no problem understanding the meaning of the sentence
"Sorry, no sensors were detected.".

You seem to miss the fact that we're just a bunch of Linux-loving
people who devote quite a bit of our personal time to the lm-sensors
project. It's not our job and we don't get paid for it, we do it
because we like it. It's hard enough already with all our other other
personal and professional commitments and the lack of support from the
chip vendors. The last thing we need is abuse from people like you. If
you don't like our SW, don't use it and stay out of our hair. Or even
better, how about some constructive contribution to the project? You
could add support for your laptop and make a couple of other Sony
users happy. Shouldn't be to hard for you given you're an IT
professional.

Don't expect any kind of support if you keep up this tone.

...juerg


> Anaybody can make any sense of this?
>
> Gijs
> ========================================> gijs@gijs:/tmp$ sudo perl "sensors-detect?format=txt"
> # sensors-detect revision $Revision$
>
> This program will help you determine which kernel modules you need
> to load to use lm_sensors most effectively. It is generally safe
> and recommended to accept the default answers to all questions,
> unless you know what you're doing.
>
> We can start with probing for (PCI) I2C or SMBus adapters.
> Do you want to probe now? (YES/no):
> Probing for PCI bus adapters...
> Use driver `i2c-ali15x3' for device 0000:00:06.0: Acer Labs 1533/1543
> Use driver `i2c-ali1535' for device 0000:00:06.0: Acer Labs 1535
>
> We will now try to load each adapter module in turn.
> Module `i2c-ali15x3' already loaded.
> Module `i2c-ali1535' already loaded.
> If you have undetectable or unsupported I2C/SMBus adapters, you can have
> them scanned by manually loading the modules before running this script.
>
> We are now going to do the I2C/SMBus adapter probings. Some chips may
> be double detected; we choose the one with the highest confidence
> value in that case.
> If you found that the adapter hung after probing a certain address,
> you can specify that address to remain unprobed.
>
> Next adapter: SMBus ALI1535 adapter at 8040 (i2c-0)
> Do you want to scan it? (YES/no/selectively):
> Client found at address 0x50
> Probing for `Analog Devices ADM1033'...                     No
> Probing for `Analog Devices ADM1034'...                     No
> Probing for `SPD EEPROM'...                                 Yes
>    (confidence 8, not a hardware monitoring chip)
> Probing for `EDID EEPROM'...                                No
> Client found at address 0x51
> Probing for `Analog Devices ADM1033'...                     No
> Probing for `Analog Devices ADM1034'...                     No
> Probing for `SPD EEPROM'...                                 YesSome
> chips are also accessible through the ISA I/O ports. We have to write
> to arbitrary I/O ports to probe them. This is usually safe though. Yes,
> you do have ISA I/O ports even if you do not have any ISA slots! Do you
> want to scan the ISA I/O ports? (YES/no): Probing for `National
> Semiconductor LM78' at 0x290...       No Probing for `National
> Semiconductor LM78-J' at 0x290...     No Probing for `National
> Semiconductor LM79' at 0x290...       No Probing for `Winbond W83781D'
> at 0x290...                   No Probing for `Winbond W83782D' at
> 0x290...                   No Probing for `IPMI BMC KCS' at
> 0xca0...                      No Probing for `IPMI BMC SMIC' at
> 0xca8...                     No
>
> Some Super I/O chips may also contain sensors. We have to write to
> standard I/O ports to probe them. This is usually safe.
> Do you want to scan for Super I/O sensors? (YES/no):
> Probing for Super-I/O at 0x2e/0x2f
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     No
> Trying family `VIA/Winbond/Fintek'...                       No
> Trying family `ITE'...                                      No
> Probing for Super-I/O at 0x4e/0x4f
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     No
> Trying family `VIA/Winbond/Fintek'...                       No
> Trying family `ITE'...                                      No
>
> Some south bridges, CPUs or memory controllers may also contain
> embedded sensors. Do you want to scan for them? (YES/no):
> Silicon Integrated Systems SIS5595...                       No
> VIA VT82C686 Integrated Sensors...                          No
> VIA VT8231 Integrated Sensors...                            No
> AMD K8 thermal sensors...                                   No
> AMD K10 thermal sensors...                                  No
> Intel Core family thermal sensor...                         No
> Intel AMB FB-DIMM thermal sensor...                         No
> VIA C7 thermal and voltage sensors...                       No
>
> Sorry, no sensors were detected.
> Either your sensors are not supported, or they are connected to an
> I2C or SMBus adapter that is not supported. See doc/FAQ,
> doc/lm_sensors-FAQ.html or http://www.lm-sensors.org/wiki/FAQ
> (FAQ #4.24.3) for further information.
> If you find out what chips are on your board, check
> http://www.lm-sensors.org/wiki/Devices for driver status.
>
>    (confidence 8, not a hardware monitoring chip)
> Probing for `EDID EEPROM'...                                No
>
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
