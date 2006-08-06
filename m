From: mlo@js8tb.org (mlo)
Date: Sun, 06 Aug 2006 00:02:15 +0000
Subject: [lm-sensors]  compaq evo w6000
Message-Id: <44D53187.6040200@js8tb.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4464301C.9030003@tu-bs.de>
In-Reply-To: <4464301C.9030003@tu-bs.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,

I stumbled upon an exchange of messages on this list concerning sensors
on a Compaq evo W6000 (dating back 15-May-2006) where Rudolf Marek gave
a procedure to activate a possibly existing but hidden SMBUS where
sensors could be attached. I have an evo W6000 and could run the
proposed procedure and here are the results.

> Quick howto:
> 1) lspci -n will tell you the IDs, you will need: pci Id of 0000:00:1f.0
>=20
> first part is 8086: which is intel, second part is the requested ID
>=20
> 2) quick hack the quirks.c
>=20
> change this:
> static int __initdata asus_hides_smbus =3D 0;
> to
> static int __initdata asus_hides_smbus =3D 1;
>=20
> Then recompile and run. you should now see the smbus. If not then take th=
e pci=20
> ID from step 1 and change following line:
> DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82801=
BA_0,=20
> asus_hides_smbus_lpc );
>=20
> into
> DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,   0xNNNN,  asus_hides_smbus=
_lpc );
>=20
> where NNNN is you ID number.


For the evo, NNNN is 0x2440 and is already in the quirk.c as PCI_DEVICE_ID_=
INTEL_82801BA_0
Therefore, the only thing to change in quirk.c was to set asus_hides_smbus=
=3D1 ...
and it worked, lspci now reports the SMBUS:

00:1f.3 SMBus: Intel Corporation 82801BA/BAM SMBus (rev 04)
        Subsystem: Compaq Computer Corporation Evo W6000
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 5
        Region 4: I/O ports at fc00 [size=16]

and sensors-detect can configure 2 chips so that "sensors" report something=
 like:

max1617-i2c-0-18
Adapter: SMBus I801 adapter at fc00

Board:       +53??C  (low  =3D   -55??C, high =3D  +127??C)
CPU:         +61??C  (low  =3D   -55??C, high =3D   +64??C)

adm1023-i2c-0-4c
Adapter: SMBus I801 adapter at fc00

Board:       +35??C  (low  =3D   -55??C, high =3D  +127??C)
CPU:         +37??C  (low  =3D   -55??C, high =3D   +62??C)


> If you are able to see the smbus device run sensors-detect and please rep=
ort if=20
> you found some useful devices. If so, proper quirk needs to be developed.=
 You=20
> should provide:
> lspci
> lspci -n
> lspci -v -v -v
> lspci -v -v -v -n


Then, I tried to adapt the quirk.c in the same way that it is done for the =
other
systems that suffer from the hidden SMBUS issue and understood that the ope=
ration is done in 2 steps:
1 - identify if the computer model suffers from the problem by comparing th=
e hostbridge
    subsystem_vendor and subsystem_device with those known to be problemati=
c.

2 - if first test succeeds, then write some magic value in pci register whe=
n processing the
    LPC device.

Having understood this, the change should be easy to do but ... the hostbri=
dge of the evo W6000
does not report a subsystem vendor and device:

# lspci -v -v -v -n
00:00.0 Class 0600: 8086:2531 (rev 04)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort- <TAb=
ort- <MAbort+ >SERR+ <PERR+
        Latency: 0
        Region 0: Memory at e8000000 (32-bit, prefetchable) [sizedM]
        Capabilities: [a0] AGP version 2.0
                Status: RQ2 Iso- ArqSz=3D0 Cal=3D0 SBA+ ITACoh- GART64- HTr=
ans- 64bit- FW+ AGP3- Rate=3Dx1,x2,x4
                Command: RQ=3D1 ArqSz=3D0 Cal=3D0 SBA- AGP+ GART64- 64bit- =
FW- Rate=3Dx4
...

# lspci -v -v -v
00:00.0 Host bridge: Intel Corporation 82860 860 (Wombat) Chipset Host Brid=
ge (MCH) (rev 04)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort- <TAb=
ort- <MAbort+ >SERR+ <PERR+
        Latency: 0
        Region 0: Memory at e8000000 (32-bit, prefetchable) [sizedM]
        Capabilities: [a0] AGP version 2.0
                Status: RQ2 Iso- ArqSz=3D0 Cal=3D0 SBA+ ITACoh- GART64- HTr=
ans- 64bit- FW+ AGP3- Rate=3Dx1,x2,x4
                Command: RQ=3D1 ArqSz=3D0 Cal=3D0 SBA- AGP+ GART64- 64bit- =
FW- Rate=3Dx4

And the LPC does not have subsystem ID either.

# lspci -v -v -v
00:1f.0 ISA bridge: Intel Corporation 82801BA ISA Bridge (LPC) (rev 04)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-=
 Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR+ <PERR-


Also there are no PCI device processed before the LPC that have subsystem i=
nfo (otherwise they could be used instead of the HB)

After the LPC device, there are devices with subsystem information such as =
the IDE interface:

00:1f.1 IDE interface: Intel Corporation 82801BA IDE U100 (rev 04) (prog-if=
 80 [Master])
        Subsystem: Compaq Computer Corporation Unknown device 0077
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 4: I/O ports at 2040 [size=16]

I wonder how this problem can be worked around:
I thought about several solutions but I wonder if they may work:

idea 1 - do the PCI magic when stumbling upon the IDE interface (it is the =
first device that reports subsystem IDs that probably correspond indirectly=
 to the mainboard: 0077 )
=3D> could it work (playing with PCI after having configured the LPC and al=
so what is the risk that 0077 is used in another system than evo W6000) ?

Idea 2 - detect the type of mainboard thanks to something else than the sub=
system ID of the HB.
=3D> I'm not certain where this info could be obtained reliably nor how (BI=
OS ?)

Idea 3 - replace the first step of the detection by a boot parameter
(one would set "asus_hides_smbus=3D1" in the boot parameters if he has a ha=
rdware with hidden SMBUS that cannot be quirk'ed because it's HB does not r=
eport subsystem IDs such as evo W6000)


If someone could shed some light on the possible side effects of such solut=
ions or give other tracks, it would be great.
If nothing safe can be found (that does not risk to make quirk.c bring prob=
lem on some systems that work today), I guess that people will have to modi=
fy the quirk.c to activate the SMBUS on such hardware.

Regards,

Michel



