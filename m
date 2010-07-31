From: Hugo Vanwoerkom <hvw59601@yahoo.com>
Date: Sat, 31 Jul 2010 18:53:04 +0000
Subject: [lm-sensors] no sensors detected acer aspire 3613WLCi
Message-Id: <618442.81438.qm@web53706.mail.re2.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <i2s6dk$npb$1@dough.gmane.org>
In-Reply-To: <i2s6dk$npb$1@dough.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org



Hi,=20

I inherited an Acer Aspire 3613WLCi and installed Debian Lenny (stable)  on=
 it.=20

The kernel is 2.6.26 and lm-sensors is:=20

hugo@debian:~$ sensors -v=20
sensors version 3.0.2 with libsensors version 3.0.2=20

Sensors gives:=20

hugo@debian:~$ sensors=20
acpitz-virtual-0=20
Adapter: Virtual device=20
temp1:       +69.0=B0C  (crit =3D +100.0=B0C)=20
temp2:       +53.0=B0C  (crit =3D +70.0=B0C)=20

But sensors-detect gives:=20

debian:/home/hugo# sensors-detect=20
# sensors-detect revision 5249 (2008-05-11 22:56:25 +0200)=20

This program will help you determine which kernel modules you need=20
to load to use lm_sensors most effectively. It is generally safe=20
and recommended to accept the default answers to all questions,=20
unless you know what you're doing.=20

We can start with probing for (PCI) I2C or SMBus adapters.=20
Do you want to probe now? (YES/no):=20
Probing for PCI bus adapters...=20
Use driver `i2c-i801' for device 0000:00:1f.3: Intel 82801FB ICH6=20

We will now try to load each adapter module in turn.=20
Module `i2c-i801' already loaded.=20
If you have undetectable or unsupported I2C/SMBus adapters, you can have=20
them scanned by manually loading the modules before running this script.=20

To continue, we need module `i2c-dev' to be loaded.=20
Do you want to load `i2c-dev' now? (YES/no):=20
Module loaded successfully.=20

We are now going to do the I2C/SMBus adapter probings. Some chips may=20
be double detected; we choose the one with the highest confidence=20
value in that case.=20
If you found that the adapter hung after probing a certain address,=20
you can specify that address to remain unprobed.=20

Next adapter: SMBus I801 adapter at 20a0 (i2c-0)=20
Do you want to scan it? (YES/no/selectively):=20
Client found at address 0x52=20
Probing for `Analog Devices ADM1033'...                     No=20
Probing for `Analog Devices ADM1034'...                     No=20
Probing for `SPD EEPROM'...                                 Yes=20
    (confidence 8, not a hardware monitoring chip)=20
Probing for `EDID EEPROM'...                                No=20

Some chips are also accessible through the ISA I/O ports. We have to=20
write to arbitrary I/O ports to probe them. This is usually safe though.=20
Yes, you do have ISA I/O ports even if you do not have any ISA slots!=20
Do you want to scan the ISA I/O ports? (YES/no):=20
Probing for `National Semiconductor LM78' at 0x290...       No=20
Probing for `National Semiconductor LM78-J' at 0x290...     No=20
Probing for `National Semiconductor LM79' at 0x290...       No=20
Probing for `Winbond W83781D' at 0x290...                   No=20
Probing for `Winbond W83782D' at 0x290...                   No=20
Probing for `IPMI BMC KCS' at 0xca0...                      No=20
Probing for `IPMI BMC SMIC' at 0xca8...                     No=20

Some Super I/O chips may also contain sensors. We have to write to=20
standard I/O ports to probe them. This is usually safe.=20
Do you want to scan for Super I/O sensors? (YES/no):=20
Probing for Super-I/O at 0x2e/0x2f=20
Trying family `National Semiconductor'...                   No=20
Trying family `SMSC'...                                     No=20
Trying family `VIA/Winbond/Fintek'...                       No=20
Trying family `ITE'...                                      No=20
Probing for Super-I/O at 0x4e/0x4f=20
Trying family `National Semiconductor'...                   No=20
Trying family `SMSC'...                                     No=20
Trying family `VIA/Winbond/Fintek'...                       No=20
Trying family `ITE'...                                      No=20

Some south bridges, CPUs or memory controllers may also contain=20
embedded sensors. Do you want to scan for them? (YES/no):=20
Silicon Integrated Systems SIS5595...                       No=20
VIA VT82C686 Integrated Sensors...                          No=20
VIA VT8231 Integrated Sensors...                            No=20
AMD K8 thermal sensors...                                   No=20
AMD K10 thermal sensors...                                  No=20
Intel Core family thermal sensor...                         No=20
Intel AMB FB-DIMM thermal sensor...                         No=20

Sorry, no sensors were detected.=20
Either your sensors are not supported, or they are connected to an=20
I2C or SMBus adapter that is not supported. See=20
http://www.lm-sensors.org/wiki/FAQ/Chapter3 for further information.=20
If you find out what chips are on your board, check=20
http://www.lm-sensors.org/wiki/Devices for driver status.=20

lspci gives:=20

debian:/home/hugo# lspci=20
00:00.0 Host bridge: Intel Corporation Mobile 915GM/PM/GMS/910GML  Express =

Processor to DRAM Controller (rev 03)=20

00:02.0 VGA compatible controller: Intel Corporation Mobile  915GM/GMS/910G=
ML=20
Express Graphics Controller (rev 03)=20

00:02.1 Display controller: Intel Corporation Mobile 915GM/GMS/910GML  Expr=
ess=20
Graphics Controller (rev 03)=20

00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6  Fami=
ly)=20
USB UHCI #1 (rev 03)=20

00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6  Fami=
ly)=20
USB UHCI #2 (rev 03)=20

00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6  Fami=
ly)=20
USB UHCI #3 (rev 03)=20

00:1d.3 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6  Fami=
ly)=20
USB UHCI #4 (rev 03)=20

00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6  Fami=
ly)=20
USB2 EHCI Controller (rev 03)=20

00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev d3)=20
00:1e.2 Multimedia audio controller: Intel Corporation  82801FB/FBM/FR/FW/F=
RW=20
(ICH6 Family) AC'97 Audio Controller (rev 03)=20

00:1e.3 Modem: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family)  AC'97=
=20
Modem Controller (rev 03)=20

00:1f.0 ISA bridge: Intel Corporation 82801FBM (ICH6M) LPC Interface  Bridg=
e=20
(rev 03)=20

00:1f.1 IDE interface: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6  Famil=
y)=20
IDE Controller (rev 03)=20

00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family)  SMBus=
=20
Controller (rev 03)=20

06:05.0 Network controller: Broadcom Corporation BCM4318 [AirForce One  54g=
]=20
802.11g Wireless LAN Controller (rev 02)=20

06:07.0 Ethernet controller: Realtek Semiconductor Co., Ltd. =20
RTL-8139/8139C/8139C+ (rev 10)=20

06:09.0 CardBus bridge: ENE Technology Inc CB1410 Cardbus Controller  (rev =
01)=20

I would like to control the fan.=20

I tried kernel 2.6.32 but it gets the same result...:-(

Thanks!=20

Hugo=20



     =20

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
