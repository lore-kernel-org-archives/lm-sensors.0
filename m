From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 28 Jul 2009 07:34:56 +0000
Subject: Re: [lm-sensors] Same problem, different form factor.
Message-Id: <20090728093456.711bcf26@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <537754.36624.qm@web111504.mail.gq1.yahoo.com>
In-Reply-To: <537754.36624.qm@web111504.mail.gq1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Nuzhna,

On Mon, 27 Jul 2009 21:54:19 -0700 (PDT), Nuzhna Pomoshch wrote:
> I added the line manually and lspci -vnn now does produce
> the SMBus:
> 
> 00:1f.3 SMBus [0c05]: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) SMBus Controller [8086:24c3] (rev 01)
>         Subsystem: Compaq Computer Corporation Device [0e11:00ba]
>         Flags: medium devsel, IRQ 5
>         I/O ports at fc00 [size2]
>         Kernel driver in use: i801_smbus
> 

OK, so it worked fine.

> > If you get lm-sensors to work, please include the output
> > of "sensors".
> 
> No luck there (which is not a surprise if I need more patches).

No, if you see the SMBus now then you have all the patches you need.

> # sensors-detect
> # sensors-detect revision 5291 (2008-06-23 23:40:46 -0700)
> 
> This program will help you determine which kernel modules you need
> to load to use lm_sensors most effectively. It is generally safe
> and recommended to accept the default answers to all questions,
> unless you know what you're doing.
> 
> We can start with probing for (PCI) I2C or SMBus adapters.
> Do you want to probe now? (YES/no): y
> Probing for PCI bus adapters...
> Use driver `i2c-i801' for device 0000:00:1f.3: Intel 82801DB ICH4
> 
> We will now try to load each adapter module in turn.
> Load `i2c-i801' (say NO if built into your kernel)? (YES/no): n
> If you have undetectable or unsupported I2C/SMBus adapters, you can have
> them scanned by manually loading the modules before running this script.
> 
> We are now going to do the I2C/SMBus adapter probings. Some chips may
> be double detected; we choose the one with the highest confidence
> value in that case.
> If you found that the adapter hung after probing a certain address,
> you can specify that address to remain unprobed.
> 
> Next adapter: intelfb CRTDDC_A (i2c-0)
> Do you want to scan it? (YES/no/selectively): y
> Client found at address 0x50
> Probing for `Analog Devices ADM1033'...                     No
> Probing for `Analog Devices ADM1034'...                     No
> Probing for `SPD EEPROM'...                                 No
> Probing for `EDID EEPROM'...                                Yes
>     (confidence 8, not a hardware monitoring chip)
> 
> Next adapter: intelfb DVODDC_D (i2c-1)
> Do you want to scan it? (YES/no/selectively): y
> 
> Next adapter: intelfb DVOI2C_E (i2c-2)
> Do you want to scan it? (YES/no/selectively): y
> 
> Next adapter: SMBus I801 adapter at fc00 (i2c-3)
> Do you want to scan it? (YES/no/selectively): y
> Client found at address 0x50
> Probing for `Analog Devices ADM1033'...                     No
> Probing for `Analog Devices ADM1034'...                     No
> Probing for `SPD EEPROM'...                                 Yes
>     (confidence 8, not a hardware monitoring chip)
> Probing for `EDID EEPROM'...                                No
> Client found at address 0x51
> Probing for `Analog Devices ADM1033'...                     No
> Probing for `Analog Devices ADM1034'...                     No
> Probing for `SPD EEPROM'...                                 Yes
>     (confidence 8, not a hardware monitoring chip)
> Probing for `EDID EEPROM'...                                No

This is where the other D510 have a hardware monitoring chip. Instead,
all you have are the SPD EEPROMs. You can play a bit with the
decode-dimms script, but that's probably not what you want.

> Some chips are also accessible through the ISA I/O ports. We have to
> write to arbitrary I/O ports to probe them. This is usually safe though.
> Yes, you do have ISA I/O ports even if you do not have any ISA slots!
> Do you want to scan the ISA I/O ports? (YES/no): y
> Probing for `National Semiconductor LM78' at 0x290...       No
> Probing for `National Semiconductor LM78-J' at 0x290...     No
> Probing for `National Semiconductor LM79' at 0x290...       No
> Probing for `Winbond W83781D' at 0x290...                   No
> Probing for `Winbond W83782D' at 0x290...                   No
> Probing for `IPMI BMC KCS' at 0xca0...                      No
> Probing for `IPMI BMC SMIC' at 0xca8...                     No
> 
> Some Super I/O chips may also contain sensors. We have to write to
> standard I/O ports to probe them. This is usually safe.
> Do you want to scan for Super I/O sensors? (YES/no): y
> Probing for Super-I/O at 0x2e/0x2f
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     Yes
> Found `SMSC LPC47B367-NC Super IO'
>     (no hardware monitoring capabilities)
> Probing for Super-I/O at 0x4e/0x4f
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     No
> Trying family `VIA/Winbond/Fintek'...                       No
> Trying family `ITE'...                                      No
> 
> Some south bridges, CPUs or memory controllers may also contain
> embedded sensors. Do you want to scan for them? (YES/no): y
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
> I expected (though it is obviously not guaranteed) to find the
> sensors covered by the lm85 chip (as in the other Evo D510s).

But apparently this isn't the case. What form factor is the USDT? If it
is a small thing, then maybe they had to cut on extra features to make
it fit.

Sorry but this looks like a dead end. I can push the patch upstream for
SPD EEPROM access, but that's about it.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
