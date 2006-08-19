From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sat, 19 Aug 2006 09:48:31 +0000
Subject: [lm-sensors] compaq evo w6000
Message-Id: <44E6DE6F.4010305@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <4464301C.9030003@tu-bs.de>
In-Reply-To: <4464301C.9030003@tu-bs.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

mlo wrote:
> Hi,
>=20
> I stumbled upon an exchange of messages on this list concerning sensors
> on a Compaq evo W6000 (dating back 15-May-2006) where Rudolf Marek gave
> a procedure to activate a possibly existing but hidden SMBUS where
> sensors could be attached. I have an evo W6000 and could run the
> proposed procedure and here are the results.

Good.

>> Quick howto:
>> 1) lspci -n will tell you the IDs, you will need: pci Id of 0000:00:1f.0
>>
>> first part is 8086: which is intel, second part is the requested ID
>>
>> 2) quick hack the quirks.c
>>
>> change this:
>> static int __initdata asus_hides_smbus =3D 0;
>> to
>> static int __initdata asus_hides_smbus =3D 1;
>>
>> Then recompile and run. you should now see the smbus. If not then take t=
he pci=20
>> ID from step 1 and change following line:
>> DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_8280=
1BA_0,=20
>> asus_hides_smbus_lpc );
>>
>> into
>> DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,   0xNNNN,  asus_hides_smbu=
s_lpc );
>>
>> where NNNN is you ID number.
>=20
>=20
> For the evo, NNNN is 0x2440 and is already in the quirk.c as PCI_DEVICE_I=
D_INTEL_82801BA_0
> Therefore, the only thing to change in quirk.c was to set asus_hides_smbu=
s=3D1 ...
> and it worked, lspci now reports the SMBUS:
>=20
> 00:1f.3 SMBus: Intel Corporation 82801BA/BAM SMBus (rev 04)
>         Subsystem: Compaq Computer Corporation Evo W6000
>         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B-
>         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort=
- <TAbort- <MAbort- >SERR- <PERR-
>         Interrupt: pin B routed to IRQ 5
>         Region 4: I/O ports at fc00 [size=16]

Good2

> and sensors-detect can configure 2 chips so that "sensors" report somethi=
ng like:
>=20
> max1617-i2c-0-18
> Adapter: SMBus I801 adapter at fc00
>=20
> Board:       +53??C  (low  =3D   -55??C, high =3D  +127??C)
> CPU:         +61??C  (low  =3D   -55??C, high =3D   +64??C)
>=20
> adm1023-i2c-0-4c
> Adapter: SMBus I801 adapter at fc00
>=20
> Board:       +35??C  (low  =3D   -55??C, high =3D  +127??C)
> CPU:         +37??C  (low  =3D   -55??C, high =3D   +62??C)
>=20
>=20
>> If you are able to see the smbus device run sensors-detect and please re=
port if=20
>> you found some useful devices. If so, proper quirk needs to be developed=
. You=20
>> should provide:
>> lspci
>> lspci -n
>> lspci -v -v -v
>> lspci -v -v -v -n
>=20
>=20
> Then, I tried to adapt the quirk.c in the same way that it is done for th=
e other
> systems that suffer from the hidden SMBUS issue and understood that the o=
peration is done in 2 steps:
> 1 - identify if the computer model suffers from the problem by comparing =
the hostbridge
>     subsystem_vendor and subsystem_device with those known to be problema=
tic.
>=20
> 2 - if first test succeeds, then write some magic value in pci register w=
hen processing the
>     LPC device.
>=20
> Having understood this, the change should be easy to do but ... the hostb=
ridge of the evo W6000
> does not report a subsystem vendor and device:
>=20
> # lspci -v -v -v -n
> 00:00.0 Class 0600: 8086:2531 (rev 04)
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR+ FastB2B-
>         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort- <T=
Abort- <MAbort+ >SERR+ <PERR+
>         Latency: 0
>         Region 0: Memory at e8000000 (32-bit, prefetchable) [sizedM]
>         Capabilities: [a0] AGP version 2.0
>                 Status: RQ2 Iso- ArqSz=3D0 Cal=3D0 SBA+ ITACoh- GART64- H=
Trans- 64bit- FW+ AGP3- Rate=3Dx1,x2,x4
>                 Command: RQ=3D1 ArqSz=3D0 Cal=3D0 SBA- AGP+ GART64- 64bit=
- FW- Rate=3Dx4
> ...
>=20
> # lspci -v -v -v
> 00:00.0 Host bridge: Intel Corporation 82860 860 (Wombat) Chipset Host Br=
idge (MCH) (rev 04)
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR+ FastB2B-
>         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort- <T=
Abort- <MAbort+ >SERR+ <PERR+
>         Latency: 0
>         Region 0: Memory at e8000000 (32-bit, prefetchable) [sizedM]
>         Capabilities: [a0] AGP version 2.0
>                 Status: RQ2 Iso- ArqSz=3D0 Cal=3D0 SBA+ ITACoh- GART64- H=
Trans- 64bit- FW+ AGP3- Rate=3Dx1,x2,x4
>                 Command: RQ=3D1 ArqSz=3D0 Cal=3D0 SBA- AGP+ GART64- 64bit=
- FW- Rate=3Dx4
>=20
> And the LPC does not have subsystem ID either.
>=20
> # lspci -v -v -v
> 00:1f.0 ISA bridge: Intel Corporation 82801BA ISA Bridge (LPC) (rev 04)
>         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParEr=
r- Stepping- SERR+ FastB2B-
>         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort=
- <TAbort- <MAbort- >SERR+ <PERR-
>=20
>=20
> Also there are no PCI device processed before the LPC that have subsystem=
 info (otherwise they could be used instead of the HB)
>=20
> After the LPC device, there are devices with subsystem information such a=
s the IDE interface:
>=20
> 00:1f.1 IDE interface: Intel Corporation 82801BA IDE U100 (rev 04) (prog-=
if 80 [Master])
>         Subsystem: Compaq Computer Corporation Unknown device 0077
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B-
>         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort=
- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Region 4: I/O ports at 2040 [size=16]
>=20
> I wonder how this problem can be worked around:
> I thought about several solutions but I wonder if they may work:
>=20
> idea 1 - do the PCI magic when stumbling upon the IDE interface (it is th=
e first device that reports subsystem IDs that probably correspond indirect=
ly to the mainboard: 0077 )
> =3D> could it work (playing with PCI after having configured the LPC and =
also what is the risk that 0077 is used in another system than evo W6000) ?

Well only compaq people knows it...

>=20
> Idea 2 - detect the type of mainboard thanks to something else than the s=
ubsystem ID of the HB.
> =3D> I'm not certain where this info could be obtained reliably nor how (=
BIOS ?)

DMI is the answer
>=20
> Idea 3 - replace the first step of the detection by a boot parameter
> (one would set "asus_hides_smbus=3D1" in the boot parameters if he has a =
hardware with hidden SMBUS that cannot be quirk'ed because it's HB does not=
 report subsystem IDs such as evo W6000)

Hmm this will work only for the listed IDs
>=20
>=20
> If someone could shed some light on the possible side effects of such sol=
utions or give other tracks, it would be great.
> If nothing safe can be found (that does not risk to make quirk.c bring pr=
oblem on some systems that work today), I guess that people will have to mo=
dify the quirk.c to activate the SMBUS on such hardware.

Well I think we do not want to activate the SMBUs on notebooks because it m=
ay
interfere with the ACPI or SMBIOS code. - Two diffrent "drivers" talking to=
 same
device is no-good. So I would suggest to leave it as it is unless there are
strong reasons why the SMBus has to be un-hidden.

Regards
Rudolf

