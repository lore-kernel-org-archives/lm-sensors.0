From: "Jeff Rickman" <jrickman@myamigos.us>
Date: Sun, 01 Aug 2010 05:44:15 +0000
Subject: Re: [lm-sensors] no sensors detected acer aspire 3613WLCi
Message-Id: <49796.75.142.175.155.1280641455.squirrel@webmail.myamigos.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <i2s6dk$npb$1@dough.gmane.org>
In-Reply-To: <i2s6dk$npb$1@dough.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

>
>
> Hi,
>
> I inherited an Acer Aspire 3613WLCi and installed Debian Lenny (stable)
> on it.
>
> The kernel is 2.6.26 and lm-sensors is:
>
> hugo@debian:~$ sensors -v
> sensors version 3.0.2 with libsensors version 3.0.2
>
> Sensors gives:
>
> hugo@debian:~$ sensors
> acpitz-virtual-0
> Adapter: Virtual device
> temp1:       +69.0=B0C  (crit =3D +100.0=B0C)
> temp2:       +53.0=B0C  (crit =3D +70.0=B0C)
>
> But sensors-detect gives:
>
> debian:/home/hugo# sensors-detect
> # sensors-detect revision 5249 (2008-05-11 22:56:25 +0200)
>
> This program will help you determine which kernel modules you need
> to load to use lm_sensors most effectively. It is generally safe
> and recommended to accept the default answers to all questions,
> unless you know what you're doing.
>
> We can start with probing for (PCI) I2C or SMBus adapters.
> Do you want to probe now? (YES/no):
> Probing for PCI bus adapters...
> Use driver `i2c-i801' for device 0000:00:1f.3: Intel 82801FB ICH6
>
> We will now try to load each adapter module in turn.
> Module `i2c-i801' already loaded.
> If you have undetectable or unsupported I2C/SMBus adapters, you can have
> them scanned by manually loading the modules before running this script.
>
> To continue, we need module `i2c-dev' to be loaded.
> Do you want to load `i2c-dev' now? (YES/no):
> Module loaded successfully.
>
> We are now going to do the I2C/SMBus adapter probings. Some chips may
> be double detected; we choose the one with the highest confidence
> value in that case.
> If you found that the adapter hung after probing a certain address,
> you can specify that address to remain unprobed.
>
> Next adapter: SMBus I801 adapter at 20a0 (i2c-0)
> Do you want to scan it? (YES/no/selectively):
> Client found at address 0x52
> Probing for `Analog Devices ADM1033'...                     No
> Probing for `Analog Devices ADM1034'...                     No
> Probing for `SPD EEPROM'...                                 Yes
>     (confidence 8, not a hardware monitoring chip)
> Probing for `EDID EEPROM'...                                No
>
> Some chips are also accessible through the ISA I/O ports. We have to
> write to arbitrary I/O ports to probe them. This is usually safe though.
> Yes, you do have ISA I/O ports even if you do not have any ISA slots!
> Do you want to scan the ISA I/O ports? (YES/no):
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
>
> Sorry, no sensors were detected.
> Either your sensors are not supported, or they are connected to an
> I2C or SMBus adapter that is not supported. See
> http://www.lm-sensors.org/wiki/FAQ/Chapter3 for further information.
> If you find out what chips are on your board, check
> http://www.lm-sensors.org/wiki/Devices for driver status.
>
> lspci gives:
>
> debian:/home/hugo# lspci
> 00:00.0 Host bridge: Intel Corporation Mobile 915GM/PM/GMS/910GML  Express
> Processor to DRAM Controller (rev 03)
>
> 00:02.0 VGA compatible controller: Intel Corporation Mobile
> 915GM/GMS/910GML
> Express Graphics Controller (rev 03)
>
> 00:02.1 Display controller: Intel Corporation Mobile 915GM/GMS/910GML
> Express
> Graphics Controller (rev 03)
>
> 00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
> Family)
> USB UHCI #1 (rev 03)
>
> 00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
> Family)
> USB UHCI #2 (rev 03)
>
> 00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
> Family)
> USB UHCI #3 (rev 03)
>
> 00:1d.3 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
> Family)
> USB UHCI #4 (rev 03)
>
> 00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
> Family)
> USB2 EHCI Controller (rev 03)
>
> 00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev d3)
> 00:1e.2 Multimedia audio controller: Intel Corporation
> 82801FB/FBM/FR/FW/FRW
> (ICH6 Family) AC'97 Audio Controller (rev 03)
>
> 00:1e.3 Modem: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family)
> AC'97
> Modem Controller (rev 03)
>
> 00:1f.0 ISA bridge: Intel Corporation 82801FBM (ICH6M) LPC Interface
> Bridge
> (rev 03)
>
> 00:1f.1 IDE interface: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
> Family)
> IDE Controller (rev 03)
>
> 00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family)
> SMBus
> Controller (rev 03)
>
> 06:05.0 Network controller: Broadcom Corporation BCM4318 [AirForce One
> 54g]
> 802.11g Wireless LAN Controller (rev 02)
>
> 06:07.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
> RTL-8139/8139C/8139C+ (rev 10)
>
> 06:09.0 CardBus bridge: ENE Technology Inc CB1410 Cardbus Controller  (rev
> 01)
>
> I would like to control the fan.
>
> I tried kernel 2.6.32 but it gets the same result...:-(
>
> Thanks!
>
> Hugo
>

Google says this is a laptop. Most if not all laptops have monitoring and
fan control methods that are not accessible via LM_Sensors.

I have 3 different laptops, with different manufacture dates (2005, 2007,
2009) and all are HP, where I have tried Linux and LM_Sensors either
cannot identify the laptop monitor chipset, or the laptop monitor chipset
is not supported (probably vendor-specific so it is "closed" for
development), or only what is exposed via ACPI can be seen (like what you
mention above).

I doubt that you will be able to control the fan.



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
