From: Dong Huang <borat.gunter@googlemail.com>
Date: Thu, 27 May 2010 08:41:14 +0000
Subject: [lm-sensors] Coretemp ERROR: Can't get value of subfeature
Message-Id: <AANLkTil33EQzUCcwbJT_VHMZKj1FPCwrTCkH28i3FcC5@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5127281713246417123=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============5127281713246417123==
Content-Type: multipart/alternative; boundary=0015174735707488be04878f5a9e

--0015174735707488be04878f5a9e
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello everyone,

i am a newbie here, want to check the temperature of my motherboard with
lm_sensors, unfortunately i got error message as i run sensors. So I really
need your help, thanks in advance.

Here are some informations, that maybe useful to you.
*1. My motherboard info: *
    Manufacturer: "Intel Corporation"
    Product: "440BX Desktop Reference Platform"
    Version: "None"
    Serial: "None"
    Type: 0x01 (Other)

*2. Sensors and Kernel information*
sensors-3.1.1-3.5 i586
Linux version 2.6.31.12-0.2-desktop i686, System:  openSUSE 11.2 (i586),
KDE:  4.3.5

*3. The output of sensors: *
coretemp-isa-0000
Adapter: ISA adapter
ERROR: Can't get value of subfeature temp1_input: Can't read
Core 0:       +0.0=C2=B0C  (high =3D +100.0=C2=B0C, crit =3D +100.0=C2=B0C)

*4. demsg:*
there's so many text, i put it in a file as an appendix.

*5. output of sensors-detect*
Shutting down sensors:

done
# sensors-detect revision 5729 (2009-06-02 15:51:29 +0200)
# System: VMware, Inc. VMware Virtual Platform
# Board: Intel Corporation 440BX Desktop Reference Platform

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

Some south bridges, CPUs or memory controllers contain embedded sensors.
Do you want to scan for them? This is totally safe. (YES/no):
Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   No
AMD K10 thermal sensors...                                  No
Intel Core family thermal sensor...                         Success!
    (driver `coretemp')
Intel AMB FB-DIMM thermal sensor...                         No
VIA C7 thermal and voltage sensors...                       No

Some Super I/O chips contain embedded sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no):
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       No
Trying family `ITE'...                                      No
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       No
Trying family `ITE'...                                      No

Some systems (mainly servers) implement IPMI, a set of common interfaces
through which system health data may be retrieved, amongst other things.
We first try to get the information from SMBIOS. If we don't find it
there, we have to read from arbitrary I/O ports to probe for such
interfaces. This is normally safe. Do you want to scan for IPMI
interfaces? (YES/no):
Probing for `IPMI BMC KCS' at 0xca0...                      No
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Some hardware monitoring chips are accessible through the ISA I/O ports.
We have to write to arbitrary I/O ports to probe them. This is usually
safe though. Yes, you do have ISA I/O ports even if you do not have any
ISA slots! Do you want to scan the ISA I/O ports? (YES/no):
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No

Lastly, we can probe the I2C/SMBus adapters for connected hardware
monitoring devices. This is the most risky part, and while it works
reasonably well on most systems, it has been reported to cause trouble
on some systems.
Do you want to probe the I2C/SMBus adapters now? (YES/no):
Using driver `i2c-piix4' for device 0000:00:07.3: Intel 82371AB PIIX4 ACPI
Module i2c-dev loaded successfully.

Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `coretemp':
  * Chip `Intel Core family thermal sensor' (confidence: 9)

Do you want to overwrite /etc/sysconfig/lm_sensors? (YES/no):
Unloading i2c-dev... OK

*6. output of lsmod*
Module                  Size  Used by
vmsync                  4572  0
vmmemctl               10556  0
vmblock                14468  1
edd                    10472  0
fuse                   74332  1
loop                   17228  0
ppdev                  10276  0
parport_pc             40356  0
parport                39948  2 ppdev,parport_pc
floppy                 61220  0
i2c_piix4              13840  0
sr_mod                 17572  0
pcspkr                  2784  0
vmxnet                 20132  0
pcnet32                38244  0
vmci                   36484  0
sg                     32884  0
cdrom                  40768  1 sr_mod
mptctl                 28804  0
shpchp                 36660  0
pci_hotplug            33696  1 shpchp
container               4064  0
intel_agp              31460  1
ac                      4964  0
button                  6608  0
ext4                  381512  3
jbd2                   96288  1 ext4
crc16                   1952  1 ext4
linear                  6500  0
dm_snapshot            30952  0
dm_mod                 84900  10 dm_snapshot
fan                     5028  0
processor              50576  0
ide_pci_generic         4036  0
piix                    6760  0
ide_core              122540  2 ide_pci_generic,piix
ata_generic             4836  0
mptspi                 17992  2
mptscsih               28288  1 mptspi
mptbase                71268  3 mptctl,mptspi,mptscsih
scsi_transport_spi     27552  1 mptspi
thermal                21084  0
thermal_sys            18344  3 fan,processor,thermal

*7. output of lspci -nn*
00:00.0 Host bridge [0600]: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX
Host bridge [8086:7190] (rev 01)
00:01.0 PCI bridge [0604]: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX AG=
P
bridge [8086:7191] (rev 01)
00:07.0 ISA bridge [0601]: Intel Corporation 82371AB/EB/MB PIIX4 ISA
[8086:7110] (rev 08)
00:07.1 IDE interface [0101]: Intel Corporation 82371AB/EB/MB PIIX4 IDE
[8086:7111] (rev 01)
00:07.3 Bridge [0680]: Intel Corporation 82371AB/EB/MB PIIX4 ACPI
[8086:7113] (rev 08)
00:07.7 System peripheral [0880]: VMware Virtual Machine Communication
Interface [15ad:0740] (rev 10)
00:0f.0 VGA compatible controller [0300]: VMware SVGA II Adapter [15ad:0405=
]
00:10.0 SCSI storage controller [0100]: LSI Logic / Symbios Logic 53c1030
PCI-X Fusion-MPT Dual Ultra320 SCSI [1000:0030] (rev 01)
00:11.0 PCI bridge [0604]: VMware PCI bridge [15ad:0790] (rev 02)
00:15.0 PCI bridge [0604]: VMware PCI Express Root Port [15ad:07a0] (rev 01=
)
00:15.1 PCI bridge [0604]: VMware PCI Express Root Port [15ad:07a0] (rev 01=
)
00:15.2 PCI bridge [0604]: VMware PCI Express Root Port [15ad:07a0] (rev 01=
)
00:15.3 PCI bridge [0604]: VMware PCI Express Root Port [15ad:07a0] (rev 01=
)
00:15.4 PCI bridge [0604]: VMware PCI Express Root Port [15ad:07a0] (rev 01=
)
00:15.5 PCI bridge [0604]: VMware PCI Express Root Port [15ad:07a0] (rev 01=
)
00:15.6 PCI bridge [0604]: VMware PCI Express Root Port [15ad:07a0] (rev 01=
)
00:15.7 PCI bridge [0604]: VMware PCI Express Root Port [15ad:07a0] (rev 01=
)
00:16.0 PCI bridge [0604]: VMware PCI Express Root Port [15ad:07a0] (rev 01=
)
00:16.1 PCI bridge [0604]: VMware PCI Express Root Port [15ad:07a0] (rev 01=
)
00:16.2 PCI bridge [0604]: VMware PCI Express Root Port [15ad:07a0] (rev 01=
)
00:16.3 PCI bridge [0604]: VMware PCI Express Root Port [15ad:07a0] (rev 01=
)
00:16.4 PCI bridge [0604]: VMware PCI Express Root Port [15ad:07a0] (rev 01=
)
00:16.5 PCI bridge [0604]: VMware PCI Express Root Port [15ad:07a0] (rev 01=
)
00:16.6 PCI bridge [0604]: VMware PCI Express Root Port [15ad:07a0] (rev 01=
)
00:16.7 PCI bridge [0604]: VMware PCI Express Root Port [15ad:07a0] (rev 01=
)
00:17.0 PCI bridge [0604]: VMware PCI Express Root Port [15ad:07a0] (rev 01=
)
00:17.1 PCI bridge [0604]: VMware PCI Express Root Port [15ad:07a0] (rev 01=
)
00:17.2 PCI bridge [0604]: VMware PCI Express Root Port [15ad:07a0] (rev 01=
)
00:17.3 PCI bridge [0604]: VMware PCI Express Root Port [15ad:07a0] (rev 01=
)
00:17.4 PCI bridge [0604]: VMware PCI Express Root Port [15ad:07a0] (rev 01=
)
00:17.5 PCI bridge [0604]: VMware PCI Express Root Port [15ad:07a0] (rev 01=
)
00:17.6 PCI bridge [0604]: VMware PCI Express Root Port [15ad:07a0] (rev 01=
)
00:17.7 PCI bridge [0604]: VMware PCI Express Root Port [15ad:07a0] (rev 01=
)
00:18.0 PCI bridge [0604]: VMware PCI Express Root Port [15ad:07a0] (rev 01=
)
00:18.1 PCI bridge [0604]: VMware PCI Express Root Port [15ad:07a0] (rev 01=
)
00:18.2 PCI bridge [0604]: VMware PCI Express Root Port [15ad:07a0] (rev 01=
)
00:18.3 PCI bridge [0604]: VMware PCI Express Root Port [15ad:07a0] (rev 01=
)
00:18.4 PCI bridge [0604]: VMware PCI Express Root Port [15ad:07a0] (rev 01=
)
00:18.5 PCI bridge [0604]: VMware PCI Express Root Port [15ad:07a0] (rev 01=
)
00:18.6 PCI bridge [0604]: VMware PCI Express Root Port [15ad:07a0] (rev 01=
)
00:18.7 PCI bridge [0604]: VMware PCI Express Root Port [15ad:07a0] (rev 01=
)
02:00.0 Ethernet controller [0200]: Advanced Micro Devices [AMD] 79c970
[PCnet32 LANCE] [1022:2000] (rev 10)

*8. output of i2cdetect -l* is empty.

I hope you can give me a hand. Thanks a lot.
kind regards
borat

--0015174735707488be04878f5a9e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello everyone,<br><br>i am a newbie here, want to check the temperature
 of my motherboard with lm_sensors, unfortunately i got error message as
 i run sensors. So I really need your help, thanks in advance.<br><br>Here
 are some informations, that maybe useful to you. <br>
<b>1. My motherboard info: </b><br>=A0=A0=A0 Manufacturer: &quot;Intel Corp=
oration&quot;<br>=A0=A0=A0
 Product: &quot;440BX Desktop Reference Platform&quot;<br>=A0=A0=A0 Version=
: &quot;None&quot;<br>=A0=A0=A0
 Serial: &quot;None&quot;<br>=A0=A0=A0 Type: 0x01 (Other)<br>
<br><b>2. Sensors and Kernel information</b><br>sensors-3.1.1-3.5 i586<br>L=
inux
 version 2.6.31.12-0.2-desktop i686, System:=A0 openSUSE 11.2 (i586),=20
KDE:=A0 4.3.5 <br><br><b>3. The output of sensors: </b><br>coretemp-isa-000=
0<br>
Adapter: ISA adapter<br>ERROR: Can&#39;t get value of subfeature=20
temp1_input: Can&#39;t read<br>Core 0:=A0=A0=A0=A0=A0=A0 +0.0=C2=B0C=A0 (hi=
gh =3D +100.0=C2=B0C,=20
crit =3D +100.0=C2=B0C)<br><br><b>4. demsg:</b><br>there&#39;s so many text=
, i put
 it in a file as an appendix.<br>
<br><b>5. output of sensors-detect</b><br>Shutting down=20
sensors:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0<=
div>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0
 done<br>
# sensors-detect revision 5729 (2009-06-02 15:51:29 +0200)<br># System:=20
VMware, Inc. VMware Virtual Platform<br># Board: Intel Corporation 440BX
 Desktop Reference Platform<br><br>This program will help you determine=20
which kernel modules you need<br>
to load to use lm_sensors most effectively. It is generally safe<br>and=20
recommended to accept the default answers to all questions,<br>unless=20
you know what you&#39;re doing.<br><br>Some south bridges, CPUs or memory=
=20
controllers contain embedded sensors.<br>
Do you want to scan for them? This is totally safe. (YES/no):<br>Silicon
 Integrated Systems SIS5595...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 No<br>VIA=20
VT82C686 Integrated Sensors...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>VIA=20
VT8231 Integrated Sensors...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>
AMD K8 thermal sensors...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>AMD
 K10 thermal sensors...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>Intel
 Core family thermal sensor...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 Success!<br>=A0=A0=A0
 (driver `coretemp&#39;)<br>
Intel AMB FB-DIMM thermal sensor...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>VIA
 C7 thermal and voltage sensors...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br><br>Some
 Super I/O chips contain embedded sensors. We have to write to<br>standard
 I/O ports to probe them. This is usually safe.<br>
Do you want to scan for Super I/O sensors? (YES/no):<br>Probing for=20
Super-I/O at 0x2e/0x2f<br>Trying family `National=20
Semiconductor&#39;...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 No<br>Trying family=20
`SMSC&#39;...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>
Trying family `VIA/Winbond/Fintek&#39;...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>Trying
 family `ITE&#39;...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>Probing
 for Super-I/O at 0x4e/0x4f<br>Trying family `National=20
Semiconductor&#39;...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 No<br>
Trying family `SMSC&#39;...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>Trying
 family `VIA/Winbond/Fintek&#39;...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>Trying=20
family `ITE&#39;...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br><br>Some
 systems (mainly servers) implement IPMI, a set of common interfaces<br>
through which system health data may be retrieved, amongst other things.<br=
>We
 first try to get the information from SMBIOS. If we don&#39;t find it<br>t=
here,
 we have to read from arbitrary I/O ports to probe for such<br>
interfaces. This is normally safe. Do you want to scan for IPMI<br>interfac=
es?
 (YES/no):<br>Probing for `IPMI BMC KCS&#39; at=20
0xca0...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<=
br>Probing for `IPMI BMC SMIC&#39; at=20
0xca8...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>
<br>Some hardware monitoring chips are accessible through the ISA I/O=20
ports.<br>We have to write to arbitrary I/O ports to probe them. This is
 usually<br>safe though. Yes, you do have ISA I/O ports even if you do=20
not have any<br>
ISA slots! Do you want to scan the ISA I/O ports? (YES/no):<br>Probing=20
for `National Semiconductor LM78&#39; at 0x290...=A0=A0=A0=A0=A0=A0 No<br>P=
robing for=20
`National Semiconductor LM79&#39; at 0x290...=A0=A0=A0=A0=A0=A0 No<br>Probi=
ng for=20
`Winbond W83781D&#39; at 0x290...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 No<br>
Probing for `Winbond W83782D&#39; at 0x290...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 No<br><br>Lastly,
 we can probe the I2C/SMBus adapters for connected hardware<br>monitoring
 devices. This is the most risky part, and while it works<br>reasonably=20
well on most systems, it has been reported to cause trouble<br>
on some systems.<br>Do you want to probe the I2C/SMBus adapters now?=20
(YES/no):<br>Using driver `i2c-piix4&#39; for device 0000:00:07.3: Intel=20
82371AB PIIX4 ACPI<br>Module i2c-dev loaded successfully.<br><br>Now=20
follows a summary of the probes I have just done.<br>
Just press ENTER to continue:<br><br>Driver `coretemp&#39;:<br>=A0 * Chip=
=20
`Intel Core family thermal sensor&#39; (confidence: 9)<br><br>Do you want t=
o
 overwrite /etc/sysconfig/lm_sensors? (YES/no):<br>Unloading i2c-dev...=20
OK<br>
<br><b>6. output of lsmod</b><br>Module=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 Size=A0 Used by<br>vmsync=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0
 4572=A0 0<br>vmmemctl=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 10556=A0 0=
<br>vmblock=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
14468=A0 1<br>edd=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
10472=A0 0<br>fuse=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
74332=A0 1<br>
loop=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 17228=A0 0<br>pp=
dev=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 10276=A0 0<br>parpor=
t_pc=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
 40356=A0 0<br>parport=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 39948=
=A0 2 ppdev,parport_pc<br>floppy=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
 61220=A0 0<br>i2c_piix4=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 13840=A0 0<=
br>
sr_mod=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 17572=A0 0<br>pcspkr=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 2784=A0 0<br>vmxnet=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
 20132=A0 0<br>pcnet32=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 38244=
=A0 0<br>vmci=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
36484=A0 0<br>sg=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 32884=A0 0<br>cdrom=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=20
40768=A0 1 sr_mod<br>
mptctl=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 28804=A0 0<br>shpchp=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 36660=A0 0<br>pci_hotplug=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
 33696=A0 1 shpchp<br>container=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 4=
064=A0 0<br>intel_agp=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
 31460=A0 1<br>ac=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 4964=A0 0<br>button=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=20
6608=A0 0<br>
ext4=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 381512=A0 3<br>jbd2=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 96288=A0 1 ext4<br>c=
rc16=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
 1952=A0 1 ext4<br>linear=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 6500=A0 0<br>dm_snapshot=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
 30952=A0 0<br>dm_mod=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 84900=
=A0 10 dm_snapshot<br>
fan=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 5028=A0 0<b=
r>processor=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 50576=A0 0<br>ide_pci_ge=
neric=A0=A0=A0=A0=A0=A0=A0=A0
 4036=A0 0<br>piix=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 6760=A0 0<br>ide_core=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
122540=A0 2 ide_pci_generic,piix<br>ata_generic=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 4836=A0 0<br>
mptspi=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 17992=A0 2<br>mptscs=
ih=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 28288=A0 1=20
mptspi<br>mptbase=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 71268=A0 3 m=
ptctl,mptspi,mptscsih<br>scsi_transport_spi=A0=A0=A0=A0
 27552=A0 1 mptspi<br>thermal=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
21084=A0 0<br>thermal_sys=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
 18344=A0 3 fan,processor,thermal<br>
<br><b>7. output of lspci -nn</b><br>00:00.0 Host bridge [0600]: Intel=20
Corporation 440BX/ZX/DX - 82443BX/ZX/DX Host bridge [8086:7190] (rev 01)<br=
>00:01.0
 PCI bridge [0604]: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX AGP=20
bridge [8086:7191] (rev 01)<br>
00:07.0 ISA bridge [0601]: Intel Corporation 82371AB/EB/MB PIIX4 ISA=20
[8086:7110] (rev 08)<br>00:07.1 IDE interface [0101]: Intel Corporation=20
82371AB/EB/MB PIIX4 IDE [8086:7111] (rev 01)<br>00:07.3 Bridge [0680]:=20
Intel Corporation 82371AB/EB/MB PIIX4 ACPI [8086:7113] (rev 08)<br>
00:07.7 System peripheral [0880]: VMware Virtual Machine Communication=20
Interface [15ad:0740] (rev 10)<br>00:0f.0 VGA compatible controller=20
[0300]: VMware SVGA II Adapter [15ad:0405]<br>00:10.0 SCSI storage=20
controller [0100]: LSI Logic / Symbios Logic 53c1030 PCI-X Fusion-MPT=20
Dual Ultra320 SCSI [1000:0030] (rev 01)<br>
00:11.0 PCI bridge [0604]: VMware PCI bridge [15ad:0790] (rev 02)<br>00:15.=
0
 PCI bridge [0604]: VMware PCI Express Root Port [15ad:07a0] (rev 01)<br>00=
:15.1
 PCI bridge [0604]: VMware PCI Express Root Port [15ad:07a0] (rev 01)<br>
00:15.2 PCI bridge [0604]: VMware PCI Express Root Port [15ad:07a0] (rev
 01)<br>00:15.3 PCI bridge [0604]: VMware PCI Express Root Port=20
[15ad:07a0] (rev 01)<br>00:15.4 PCI bridge [0604]: VMware PCI Express=20
Root Port [15ad:07a0] (rev 01)<br>
00:15.5 PCI bridge [0604]: VMware PCI Express Root Port [15ad:07a0] (rev
 01)<br>00:15.6 PCI bridge [0604]: VMware PCI Express Root Port=20
[15ad:07a0] (rev 01)<br>00:15.7 PCI bridge [0604]: VMware PCI Express=20
Root Port [15ad:07a0] (rev 01)<br>
00:16.0 PCI bridge [0604]: VMware PCI Express Root Port [15ad:07a0] (rev
 01)<br>00:16.1 PCI bridge [0604]: VMware PCI Express Root Port=20
[15ad:07a0] (rev 01)<br>00:16.2 PCI bridge [0604]: VMware PCI Express=20
Root Port [15ad:07a0] (rev 01)<br>
00:16.3 PCI bridge [0604]: VMware PCI Express Root Port [15ad:07a0] (rev
 01)<br>00:16.4 PCI bridge [0604]: VMware PCI Express Root Port=20
[15ad:07a0] (rev 01)<br>00:16.5 PCI bridge [0604]: VMware PCI Express=20
Root Port [15ad:07a0] (rev 01)<br>
00:16.6 PCI bridge [0604]: VMware PCI Express Root Port [15ad:07a0] (rev
 01)<br>00:16.7 PCI bridge [0604]: VMware PCI Express Root Port=20
[15ad:07a0] (rev 01)<br>00:17.0 PCI bridge [0604]: VMware PCI Express=20
Root Port [15ad:07a0] (rev 01)<br>
00:17.1 PCI bridge [0604]: VMware PCI Express Root Port [15ad:07a0] (rev
 01)<br>00:17.2 PCI bridge [0604]: VMware PCI Express Root Port=20
[15ad:07a0] (rev 01)<br>00:17.3 PCI bridge [0604]: VMware PCI Express=20
Root Port [15ad:07a0] (rev 01)<br>
00:17.4 PCI bridge [0604]: VMware PCI Express Root Port [15ad:07a0] (rev
 01)<br>00:17.5 PCI bridge [0604]: VMware PCI Express Root Port=20
[15ad:07a0] (rev 01)<br>00:17.6 PCI bridge [0604]: VMware PCI Express=20
Root Port [15ad:07a0] (rev 01)<br>
00:17.7 PCI bridge [0604]: VMware PCI Express Root Port [15ad:07a0] (rev
 01)<br>00:18.0 PCI bridge [0604]: VMware PCI Express Root Port=20
[15ad:07a0] (rev 01)<br>00:18.1 PCI bridge [0604]: VMware PCI Express=20
Root Port [15ad:07a0] (rev 01)<br>
00:18.2 PCI bridge [0604]: VMware PCI Express Root Port [15ad:07a0] (rev
 01)<br>00:18.3 PCI bridge [0604]: VMware PCI Express Root Port=20
[15ad:07a0] (rev 01)<br>00:18.4 PCI bridge [0604]: VMware PCI Express=20
Root Port [15ad:07a0] (rev 01)<br>
00:18.5 PCI bridge [0604]: VMware PCI Express Root Port [15ad:07a0] (rev
 01)<br>00:18.6 PCI bridge [0604]: VMware PCI Express Root Port=20
[15ad:07a0] (rev 01)<br>00:18.7 PCI bridge [0604]: VMware PCI Express=20
Root Port [15ad:07a0] (rev 01)<br>
02:00.0 Ethernet controller [0200]: Advanced Micro Devices [AMD] 79c970=20
[PCnet32 LANCE] [1022:2000] (rev 10)<br><br><b>8. output of i2cdetect -l</b=
>
 is empty.<br><br>I hope you can give me a hand. Thanks a lot.<br>kind=20
regards<br><font color=3D"#888888">
borat</font></div>

--0015174735707488be04878f5a9e--


--===============5127281713246417123==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5127281713246417123==--
