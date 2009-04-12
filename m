From: Linux User <linuxuser17@yahoo.com>
Date: Sun, 12 Apr 2009 02:11:36 +0000
Subject: [lm-sensors] W83627EHG under kernel 2.6.29.1 cannot be read,
Message-Id: <143679.99688.qm@web44701.mail.sp1.yahoo.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5555565776693550081=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org


--===============5555565776693550081==
Content-Type: multipart/alternative; boundary="0-1733181912-1239502296=:99688"


--0-1733181912-1239502296=:99688
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Dear lm-sensors team, =0A =0AI am experiencing fan reading/control problems=
 with a Thinkstation D10 =0Aunder Linux (Debian). A W83627EHG chip (visible=
 on motherboard - =0Apart number 816G9C28083030UB) gets recognized, but I h=
ave the =0Afollowing problems: =0A =0A1) RAM DIMMS get hot under heavy load=
, computer freezes =0A =0A2) cannot read fan RPM with "sensors" =0A =0A3) c=
annot set fan parameters (set fanX_div) with "sensors -s" =0A =0A4) first l=
oading of module w83627ehf yields message:  =0A"Forcibly enabling Super-I/O=
.. Sensor is probably unusable." =0A =0AThe information on my system and out=
put from my trials is included =0Abelow. =0A =0AThank you very much in adva=
nce for your help. =0A =0ALinux User =0A =0A =0ASystem: Lenovo Thinkstation=
 D10 (LENOVO 6427CTO) =0Amotherboard: Lenovo (LENOVO LENOVO) =0A =0Alm_sens=
ors version: 3.1.0 =0A =0Akernel version: 2.6.29.1 =0A =0ASENSORS OUTPUT: =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 =0Aw83627ehf-isa-0ca0 =0AAdapter: ISA adapter =0AVCore:       +1.11 V  (mi=
n =3D  +0.00 V, max =3D  +1.74 V)    =0A+12V:        +7.92 V  (min =3D +12.=
62 V, max =3D +13.46 V)   ALARM =0AAVCC:        +3.30 V  (min =3D  +4.08 V,=
 max =3D  +4.06 V)   ALARM =0A3VCC:        +3.30 V  (min =3D  +4.08 V, max =
=3D  +3.06 V)   ALARM =0Ain4:         +1.14 V  (min =3D  +1.98 V, max =3D  =
+2.04 V)   ALARM =0Ain5:         +1.60 V  (min =3D  +2.04 V, max =3D  +1.45=
 V)   ALARM =0A+5V:         +4.92 V  (min =3D  +6.48 V, max =3D  +6.53 V)  =
 ALARM =0AVSB:         +3.30 V  (min =3D  +4.08 V, max =3D  +4.06 V)   ALAR=
M =0AVBAT:        +3.18 V  (min =3D  +4.08 V, max =3D  +3.06 V)   ALARM =0A=
in9:         +1.12 V  (min =3D  +2.04 V, max =3D  +2.03 V)   ALARM =0ACase =
Fan:      0 RPM  (min =3D    0 RPM, div =3D 128) =0ACPU Fan:       0 RPM  (=
min =3D    0 RPM, div =3D 128) =0AAux Fan:       0 RPM  (min =3D    0 RPM, =
div =3D 128) =0AFan 5:         0 RPM  (min =3D    0 RPM, div =3D 128) =0ASy=
s Temp:    +49.0=B0C  (high =3D  -2.0=B0C, hyst =3D -17.0=B0C)  ALARM  sens=
or =3D thermistor =0ACPU Temp:    +46.0=B0C  (high =3D +80.0=B0C, hyst =3D =
+75.0=B0C)  sensor =3D thermistor =0AAUX Temp:   +120.0=B0C  (high =3D +80.=
0=B0C, hyst =3D +75.0=B0C)  ALARM  sensor =3D thermistor =0Acpu0_vid:   +2.=
050 V =0A=0ADMESG: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =0Aw8=
3627ehf: Forcibly enabling Super-I/O. Sensor is probably unusable. =0Aw8362=
7ehf: Found W83627EHG chip at 0xca0 =0A =0A[later:] =0Aw83627ehf w83627ehf.=
3232: Increasing fan1 clock divider from 8 to 16 =0Aw83627ehf w83627ehf.323=
2: Increasing fan2 clock divider from 8 to 16 =0Aw83627ehf w83627ehf.3232: =
Increasing fan3 clock divider from 8 to 16 =0Aw83627ehf w83627ehf.3232: Inc=
reasing fan5 clock divider from 2 to 4 =0Aw83627ehf w83627ehf.3232: Increas=
ing fan1 clock divider from 16 to 32 =0Aw83627ehf w83627ehf.3232: Increasin=
g fan2 clock divider from 16 to 32 =0Aw83627ehf w83627ehf.3232: Increasing =
fan3 clock divider from 16 to 32 =0Aw83627ehf w83627ehf.3232: Increasing fa=
n5 clock divider from 4 to 8 =0Aw83627ehf w83627ehf.3232: Increasing fan1 c=
lock divider from 32 to 64 =0Aw83627ehf w83627ehf.3232: Increasing fan2 clo=
ck divider from 32 to 64 =0Aw83627ehf w83627ehf.3232: Increasing fan3 clock=
 divider from 32 to 64 =0Aw83627ehf w83627ehf.3232: Increasing fan5 clock d=
ivider from 8 to 16 =0Aw83627ehf w83627ehf.3232: Increasing fan1 clock divi=
der from 64 to 128 =0Aw83627ehf w83627ehf.3232: Increasing fan2 clock divid=
er from 64 to 128 =0Aw83627ehf w83627ehf.3232: Increasing fan3 clock divide=
r from 64 to 128 =0Aw83627ehf w83627ehf.3232: Increasing fan5 clock divider=
 from 16 to 32 =0Aw83627ehf w83627ehf.3232: Increasing fan5 clock divider f=
rom 32 to 64 =0Aw83627ehf w83627ehf.3232: Increasing fan5 clock divider fro=
m 64 to 128 =0A SENSORS-DETECT OUTPUT: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =0A# sensors-detect revision 5666 (=
2009-02-26 17:15:04 +0100) =0A# System: LENOVO 6427CTO =0A# Board: LENOVO L=
ENOVO =0A =0AThis program will help you determine which kernel modules you =
need =0Ato load to use lm_sensors most effectively. It is generally safe =
=0Aand recommended to accept the default answers to all questions, =0Aunles=
s you know what you're doing. =0A =0ASome south bridges, CPUs or memory con=
trollers contain embedded sensors. =0ADo you want to scan for them? This is=
 totally safe. (YES/no):  =0ASilicon Integrated Systems SIS5595...         =
              No =0AVIA VT82C686 Integrated Sensors...                     =
     No =0AVIA VT8231 Integrated Sensors...                            No =
=0AAMD K8 thermal sensors...                                   No =0AAMD K1=
0 thermal sensors...                                  No =0AIntel Core fami=
ly thermal sensor...                         Success! =0A    (driver `coret=
emp') =0AIntel AMB FB-DIMM thermal sensor...                         Succes=
s! =0A    (driver `i5k_amb') =0AVIA C7 thermal and voltage sensors...      =
                 No =0A =0ASome Super I/O chips contain embedded sensors. W=
e have to write to =0Astandard I/O ports to probe them. This is usually saf=
e. =0ADo you want to scan for Super I/O sensors? (YES/no):  =0AProbing for =
Super-I/O at 0x2e/0x2f =0ATrying family `National Semiconductor'...        =
           No =0ATrying family `SMSC'...                                   =
  No =0ATrying family `VIA/Winbond/Fintek'...                       Yes =0A=
Found `Winbond W83627EHF/EF/EHG/EG Super IO Sensors'        Success! =0A   =
 (address 0xca0, driver `w83627ehf') =0AProbing for Super-I/O at 0x4e/0x4f =
=0ATrying family `National Semiconductor'...                   No =0ATrying=
 family `SMSC'...                                     No =0ATrying family `=
VIA/Winbond/Fintek'...                       No =0ATrying family `ITE'...  =
                                    No =0A =0ASome systems (mainly servers)=
 implement IPMI, a set of common interfaces =0Athrough which system health =
data may be retrieved, amongst other things. =0AWe have to read from arbitr=
ary I/O ports to probe for such interfaces. =0AThis is normally safe. Do yo=
u want to scan for IPMI interfaces? =0A(YES/no):  =0AProbing for `IPMI BMC =
KCS' at 0xca0...                      No =0AProbing for `IPMI BMC SMIC' at =
0xca8...                     No =0A =0ASome hardware monitoring chips are a=
ccessible through the ISA I/O ports. =0AWe have to write to arbitrary I/O p=
orts to probe them. This is usually =0Asafe though. Yes, you do have ISA I/=
O ports even if you do not have any =0AISA slots! Do you want to scan the I=
SA I/O ports? (yes/NO):  =0A =0ALastly, we can probe the I2C/SMBus adapters=
 for connected hardware =0Amonitoring devices. This is the most risky part,=
 and while it works =0Areasonably well on most systems, it has been reporte=
d to cause trouble =0Aon some systems. =0ADo you want to probe the I2C/SMBu=
s adapters now? (YES/no):  =0AUsing driver `i2c-i801' for device 0000:00:1f=
..3: Intel Enterprise Southbridge - ESB2 =0AModule i2c-dev loaded successful=
ly. =0A =0ANext adapter: SMBus I801 adapter at 1100 (i2c-0) =0ADo you want =
to scan it? (yes/NO/selectively):  =0A=0ANext adapter: NVIDIA i2c adapter  =
(i2c-2) =0ADo you want to scan it? (YES/no/selectively):  =0AClient found a=
t address 0x50 =0AProbing for `Analog Devices ADM1033'...                  =
   No =0AProbing for `Analog Devices ADM1034'...                     No =0A=
Probing for `SPD EEPROM'...                                 No =0AProbing f=
or `EDID EEPROM'...                                Yes =0A    (confidence 8=
, not a hardware monitoring chip) =0A =0ANext adapter: NVIDIA i2c adapter  =
(i2c-3) =0ADo you want to scan it? (YES/no/selectively):  =0AClient found a=
t address 0x2e =0AProbing for `Myson MTP008'...                            =
   No =0AProbing for `National Semiconductor LM78'...                No =0A=
Probing for `National Semiconductor LM79'...                No =0AProbing f=
or `National Semiconductor LM80'...                No =0AProbing for `Natio=
nal Semiconductor LM85'...                No =0AProbing for `National Semic=
onductor LM96000 or PC8374L'...  No =0AProbing for `Analog Devices ADM1027'=
....                     No =0AProbing for `Analog Devices ADT7460 or ADT746=
3'...          No =0AProbing for `SMSC EMC6D100 or EMC6D101'...            =
      No =0AProbing for `SMSC EMC6D102'...                              No =
=0AProbing for `SMSC EMC6D103'...                              No =0AProbin=
g for `Winbond WPCD377I'...                           No =0AProbing for `An=
alog Devices ADT7467 or ADT7468'...          No =0AProbing for `Analog Devi=
ces ADT7470'...                     No =0AProbing for `Analog Devices ADT74=
73'...                     Success! =0A    (confidence 5, driver `adt7473')=
 =0AProbing for `Analog Devices ADT7475'...                     No =0AProbi=
ng for `Analog Devices ADT7476'...                     No =0AProbing for `A=
ndigilog aSC7611'...                          No =0AProbing for `Andigilog =
aSC7621'...                          No =0AProbing for `National Semiconduc=
tor LM87'...                No =0AProbing for `Analog Devices ADM1024'...  =
                   No =0AProbing for `National Semiconductor LM93'...      =
          No =0AProbing for `Winbond W83781D'...                           =
 No =0AProbing for `Winbond W83782D'...                            No =0APr=
obing for `Winbond W83791D'...                            No =0AProbing for=
 `Winbond W83792D'...                            No =0AProbing for `Winbond=
 W83793R/G'...                          No =0AProbing for `Winbond W83627HF=
'...                           No =0AProbing for `Winbond W83627EHF'...    =
                      No =0AProbing for `Winbond W83627DHG'...             =
             No =0AProbing for `Asus AS99127F (rev.1)'...                  =
    No =0AProbing for `Asus AS99127F (rev.2)'...                      No =
=0AProbing for `Asus ASB100 Bach'...                           No =0AProbin=
g for `Winbond W83L786NR/NG/R/G'...                   No =0AProbing for `Wi=
nbond W83L785TS-S'...                        No =0AProbing for `Analog Devi=
ces ADM9240'...                     No =0AProbing for `Dallas Semiconductor=
 DS1780'...                No =0AProbing for `National Semiconductor LM81'.=
...                No =0AProbing for `Analog Devices ADM1026'...            =
         No =0AProbing for `Analog Devices ADM1025'...                     =
No =0AProbing for `Analog Devices ADM1029'...                     No =0APro=
bing for `Analog Devices ADM1030'...                     No =0AProbing for =
`Analog Devices ADM1031'...                     No =0AProbing for `Analog D=
evices ADM1022'...                     No =0AProbing for `Texas Instruments=
 THMC50'...                   No =0AProbing for `Analog Devices ADM1028'...=
                     No =0AProbing for `Texas Instruments THMC51'...       =
            No =0AProbing for `ITE IT8712F'...                             =
   No =0AProbing for `SMSC DME1737'...                               No =0A=
Probing for `SMSC SCH5027D-NW'...                           No =0AProbing f=
or `Fintek F75373S/SG'...                          No =0AProbing for `Finte=
k F75375S/SP'...                          No =0AProbing for `Fintek F75387S=
G/RG'...                         No =0AProbing for `Winbond W83791SD'...   =
                        No =0A =0ANow follows a summary of the probes I hav=
e just done. =0AJust press ENTER to continue:  =0A=0ADriver `w83627ehf': =
=0A  * ISA bus, address 0xca0 =0A    Chip `Winbond W83627EHF/EF/EHG/EG Supe=
r IO Sensors' (confidence: 9) =0A =0ADriver `adt7473': =0A  * Bus `NVIDIA i=
2c adapter ' =0A    Busdriver `nvidia', I2C address 0x2e =0A    Chip `Analo=
g Devices ADT7473' (confidence: 5) =0A =0ADriver `coretemp': =0A  * Chip `I=
ntel Core family thermal sensor' (confidence: 9) =0A =0ADriver `i5k_amb': =
=0A  * Chip `Intel AMB FB-DIMM thermal sensor' (confidence: 9) =0A =0ATo lo=
ad everything that is needed, add this to /etc/modules: =0A#----cut here---=
- =0A# Adapter drivers =0Anvidia =0A# Chip drivers =0Aadt7473 =0Acoretemp =
=0Ai5k_amb =0Aw83627ehf =0A#----cut here---- =0AIf you have some drivers bu=
ilt into your kernel, the list above will =0Acontain too many modules. Skip=
 the appropriate ones! =0A =0ADo you want to add these lines automatically =
to /etc/modules? (yes/NO) =0A =0AUnloading i2c-dev... OK =0A=0ALSMOD OUTPUT=
: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D =0AModule                  Size  Used by =0Aw83627ehf              2432=
8  0  =0Appp_async              10072  1  =0Acrc_ccitt               1944  =
1 ppp_async =0Appp_generic            21720  5 ppp_async =0Aslhc           =
         5752  1 ppp_generic =0Ahwmon_vid               3480  1 w83627ehf =
=0Acoretemp                6360  0  =0Aadt7473                20232  0  =0A=
nvidia               8113496  26  =0Aloop                   17252  0  =0Asg=
                     32640  0  =0Asr_mod                 15940  0  =0Asnd_h=
da_codec_realtek   253884  1  =0Acdrom                  37704  1 sr_mod =0A=
usb_storage            56416  0  =0Aata_piix               26396  0  =0Asnd=
_hda_intel          26952  3  =0Aahci                   35876  0  =0Auhci_h=
cd               34680  0  =0Aehci_hcd               52816  0  =0Aohci1394 =
              32276  0  =0Ae1000e                125960  0  =0Asnd_hda_code=
c          58712  2 snd_hda_codec_realtek,snd_hda_intel =0Alibata          =
      174380  2 ata_piix,ahci =0Ai5k_amb                 6720  0  =0Ahwmon =
                  2888  4 w83627ehf,coretemp,adt7473,i5k_amb =0Ai2c_i801   =
            10612  0  =0A=0AOUTPUT OF LSPCI -NN: =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =0A00:00.0 Host bridge =
[0600]: Intel Corporation 5400 Chipset Memory Controller Hub [8086:4001] (r=
ev 20) =0A00:01.0 PCI bridge [0604]: Intel Corporation 5400 Chipset PCI Exp=
ress Port 1 [8086:4021] (rev 20) =0A00:05.0 PCI bridge [0604]: Intel Corpor=
ation 5400 Chipset PCI Express Port 5 [8086:4025] (rev 20) =0A00:09.0 PCI b=
ridge [0604]: Intel Corporation 5400 Chipset PCI Express Port 9 [8086:4029]=
 (rev 20) =0A00:10.0 Host bridge [0600]: Intel Corporation 5400 Chipset FSB=
 Registers [8086:4030] (rev 20) =0A00:10.1 Host bridge [0600]: Intel Corpor=
ation 5400 Chipset FSB Registers [8086:4030] (rev 20) =0A00:10.2 Host bridg=
e [0600]: Intel Corporation 5400 Chipset FSB Registers [8086:4030] (rev 20)=
 =0A00:10.3 Host bridge [0600]: Intel Corporation 5400 Chipset FSB Register=
s [8086:4030] (rev 20) =0A00:10.4 Host bridge [0600]: Intel Corporation 540=
0 Chipset FSB Registers [8086:4030] (rev 20) =0A00:11.0 Host bridge [0600]:=
 Intel Corporation 5400 Chipset CE/SF Registers [8086:4031] (rev 20) =0A00:=
15.0 Host bridge [0600]: Intel Corporation 5400 Chipset FBD Registers [8086=
:4035] (rev 20) =0A00:15.1 Host bridge [0600]: Intel Corporation 5400 Chips=
et FBD Registers [8086:4035] (rev 20) =0A00:16.0 Host bridge [0600]: Intel =
Corporation 5400 Chipset FBD Registers [8086:4036] (rev 20) =0A00:16.1 Host=
 bridge [0600]: Intel Corporation 5400 Chipset FBD Registers [8086:4036] (r=
ev 20) =0A00:1b.0 Audio device [0403]: Intel Corporation 631xESB/632xESB Hi=
gh Definition Audio Controller [8086:269a] (rev 09) =0A00:1c.0 PCI bridge [=
0604]: Intel Corporation 631xESB/632xESB/3100 Chipset PCI Express Root Port=
 1 [8086:2690] (rev 09) =0A00:1d.0 USB Controller [0c03]: Intel Corporation=
 631xESB/632xESB/3100 Chipset UHCI USB Controller #1 [8086:2688] (rev 09) =
=0A00:1d.1 USB Controller [0c03]: Intel Corporation 631xESB/632xESB/3100 Ch=
ipset UHCI USB Controller #2 [8086:2689] (rev 09) =0A00:1d.2 USB Controller=
 [0c03]: Intel Corporation 631xESB/632xESB/3100 Chipset UHCI USB Controller=
 #3 [8086:268a] (rev 09) =0A00:1d.3 USB Controller [0c03]: Intel Corporatio=
n 631xESB/632xESB/3100 Chipset UHCI USB Controller #4 [8086:268b] (rev 09) =
=0A00:1d.7 USB Controller [0c03]: Intel Corporation 631xESB/632xESB/3100 Ch=
ipset EHCI USB2 Controller [8086:268c] (rev 09) =0A00:1e.0 PCI bridge [0604=
]: Intel Corporation 82801 PCI Bridge [8086:244e] (rev d9) =0A00:1f.0 ISA b=
ridge [0601]: Intel Corporation 631xESB/632xESB/3100 Chipset LPC Interface =
Controller [8086:2670] (rev 09) =0A00:1f.1 IDE interface [0101]: Intel Corp=
oration 631xESB/632xESB IDE Controller [8086:269e] (rev 09) =0A00:1f.2 SATA=
 controller [0106]: Intel Corporation 631xESB/632xESB SATA AHCI Controller =
[8086:2681] (rev 09) =0A00:1f.3 SMBus [0c05]: Intel Corporation 631xESB/632=
xESB/3100 Chipset SMBus Controller [8086:269b] (rev 09) =0A05:00.0 VGA comp=
atible controller [0300]: nVidia Corporation Quadro FX 1700 [10de:040f] (re=
v a1) =0A09:00.0 PCI bridge [0604]: Intel Corporation 6311ESB/6321ESB PCI E=
xpress Upstream Port [8086:3500] (rev 01) =0A09:00.3 PCI bridge [0604]: Int=
el Corporation 6311ESB/6321ESB PCI Express to PCI-X Bridge [8086:350c] (rev=
 01) =0A0a:00.0 PCI bridge [0604]: Intel Corporation 6311ESB/6321ESB PCI Ex=
press Downstream Port E1 [8086:3510] (rev 01) =0A0a:01.0 PCI bridge [0604]:=
 Intel Corporation 6311ESB/6321ESB PCI Express Downstream Port E2 [8086:351=
4] (rev 01) =0A0a:02.0 PCI bridge [0604]: Intel Corporation 6311ESB/6321ESB=
 PCI Express Downstream Port E3 [8086:3518] (rev 01) =0A0f:00.0 Ethernet co=
ntroller [0200]: Intel Corporation 80003ES2LAN Gigabit Ethernet Controller =
(Copper) [8086:1096] (rev 01) =0A0f:00.1 Ethernet controller [0200]: Intel =
Corporation 80003ES2LAN Gigabit Ethernet Controller (Copper) [8086:1096] (r=
ev 01) =0A1f:00.0 SCSI storage controller [0100]: LSI Logic / Symbios Logic=
 SAS1068E PCI-Express Fusion-MPT SAS [1000:0058] (rev 04) =0A20:04.0 Audio =
device [0403]: Creative Labs SB X-Fi [1102:0005] =0A20:05.0 FireWire (IEEE =
1394) [0c00]: Texas Instruments TSB43AB22/A IEEE-1394a-2000 Controller (PHY=
/Link) [104c:8023] =0A =0A =0ACHIP PART NUMBER: =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =0A816G9C28083030UB =0A =
=0A"SENSORS -S ERRORS": =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D =0Aioctl(3, SNDCTL_TMR_TIMEBASE or TCGETS, 0x7fff8=
6877cd0) =3D -1 ENOTTY (Inappropriate ioctl for device) =0Aioctl(3, SNDCTL_=
TMR_TIMEBASE or TCGETS, 0x7fff86876570) =3D -1 ENOTTY (Inappropriate ioctl =
for device) =0A=0A=0A      
--0-1733181912-1239502296=:99688
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman,new york,times,serif;fon=
t-size:12pt"><div>Dear lm-sensors team, <br>&nbsp;<br>I am experiencing fan=
 reading/control problems with a Thinkstation D10 <br>under Linux (Debian).=
 A W83627EHG chip (visible on motherboard - <br>part number 816G9C28083030U=
B) gets recognized, but I have the <br>following problems: <br>&nbsp;<br>1)=
 RAM DIMMS get hot under heavy load, computer freezes <br>&nbsp;<br>2) cann=
ot read fan RPM with "sensors" <br>&nbsp;<br>3) cannot set fan parameters (=
set fanX_div) with "sensors -s" <br>&nbsp;<br>4) first loading of module w8=
3627ehf yields message:&nbsp; <br>"Forcibly enabling Super-I/O. Sensor is p=
robably unusable." <br>&nbsp;<br>The information on my system and output fr=
om my trials is included <br>below. <br>&nbsp;<br>Thank you very much in ad=
vance for your help. <br>&nbsp;<br>Linux User
 <br>&nbsp;<br>&nbsp;<br>System: Lenovo Thinkstation D10 (LENOVO 6427CTO) <=
br>motherboard: Lenovo (LENOVO LENOVO) <br>&nbsp;<br>lm_sensors version: 3.=
1.0 <br>&nbsp;<br>kernel version: 2.6.29.1 <br>&nbsp;<br>SENSORS OUTPUT: =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 <br>w83627ehf-isa-0ca0 <br>Adapter: ISA adapter <br>VCore:&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; +1.11 V&nbsp; (min =3D&nbsp; +0.00 V, max =3D&nbsp; +1=
..74 V)&nbsp;&nbsp;&nbsp; <br>+12V:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; +7.92 V&nbsp; (min =3D +12.62 V, max =3D +13.46 V)&nbsp;&nbsp; ALARM <br>=
AVCC:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +3.30 V&nbsp; (min =3D&nbsp=
; +4.08 V, max =3D&nbsp; +4.06 V)&nbsp;&nbsp; ALARM <br>3VCC:&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; +3.30 V&nbsp; (min =3D&nbsp; +4.08 V, max =3D&=
nbsp; +3.06 V)&nbsp;&nbsp; ALARM <br>in4:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; +1.14 V&nbsp; (min =3D&nbsp; +1.98 V, max =3D&nbsp; +2.04 V)=
&nbsp;&nbsp; ALARM
 <br>in5:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +1.60 V&nbsp; (mi=
n =3D&nbsp; +2.04 V, max =3D&nbsp; +1.45 V)&nbsp;&nbsp; ALARM <br>+5V:&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +4.92 V&nbsp; (min =3D&nbsp; +6=
..48 V, max =3D&nbsp; +6.53 V)&nbsp;&nbsp; ALARM <br>VSB:&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +3.30 V&nbsp; (min =3D&nbsp; +4.08 V, max =3D=
&nbsp; +4.06 V)&nbsp;&nbsp; ALARM <br>VBAT:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; +3.18 V&nbsp; (min =3D&nbsp; +4.08 V, max =3D&nbsp; +3.06 V)&nbs=
p;&nbsp; ALARM <br>in9:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +1.=
12 V&nbsp; (min =3D&nbsp; +2.04 V, max =3D&nbsp; +2.03 V)&nbsp;&nbsp; ALARM=
 <br>Case Fan:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 RPM&nbsp; (min =3D&nbsp;&nbs=
p;&nbsp; 0 RPM, div =3D 128) <br>CPU Fan:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 0 RPM&nbsp; (min =3D&nbsp;&nbsp;&nbsp; 0 RPM, div =3D 128) <br>Aux Fan:&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 RPM&nbsp; (min =3D&nbsp;&nbsp;&nbsp; =
0 RPM, div =3D 128)
 <br>Fan 5:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 RPM&nbsp; (mi=
n =3D&nbsp;&nbsp;&nbsp; 0 RPM, div =3D 128) <br>Sys Temp:&nbsp;&nbsp;&nbsp;=
 +49.0=B0C&nbsp; (high =3D&nbsp; -2.0=B0C, hyst =3D -17.0=B0C)&nbsp; ALARM&=
nbsp; sensor =3D thermistor <br>CPU Temp:&nbsp;&nbsp;&nbsp; +46.0=B0C&nbsp;=
 (high =3D +80.0=B0C, hyst =3D +75.0=B0C)&nbsp; sensor =3D thermistor <br>A=
UX Temp:&nbsp;&nbsp; +120.0=B0C&nbsp; (high =3D +80.0=B0C, hyst =3D +75.0=
=B0C)&nbsp; ALARM&nbsp; sensor =3D thermistor <br>cpu0_vid:&nbsp;&nbsp; +2.=
050 V <br><br>DMESG: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D <br>w=
83627ehf: Forcibly enabling Super-I/O. Sensor is probably unusable. <br>w83=
627ehf: Found W83627EHG chip at 0xca0 <br>&nbsp;<br>[later:] <br>w83627ehf =
w83627ehf.3232: Increasing fan1 clock divider from 8 to 16 <br>w83627ehf w8=
3627ehf.3232: Increasing fan2 clock divider from 8 to 16 <br>w83627ehf w836=
27ehf.3232: Increasing fan3 clock divider from 8 to 16 <br>w83627ehf
 w83627ehf.3232: Increasing fan5 clock divider from 2 to 4 <br>w83627ehf w8=
3627ehf.3232: Increasing fan1 clock divider from 16 to 32 <br>w83627ehf w83=
627ehf.3232: Increasing fan2 clock divider from 16 to 32 <br>w83627ehf w836=
27ehf.3232: Increasing fan3 clock divider from 16 to 32 <br>w83627ehf w8362=
7ehf.3232: Increasing fan5 clock divider from 4 to 8 <br>w83627ehf w83627eh=
f.3232: Increasing fan1 clock divider from 32 to 64 <br>w83627ehf w83627ehf=
..3232: Increasing fan2 clock divider from 32 to 64 <br>w83627ehf w83627ehf.=
3232: Increasing fan3 clock divider from 32 to 64 <br>w83627ehf w83627ehf.3=
232: Increasing fan5 clock divider from 8 to 16 <br>w83627ehf w83627ehf.323=
2: Increasing fan1 clock divider from 64 to 128 <br>w83627ehf w83627ehf.323=
2: Increasing fan2 clock divider from 64 to 128 <br>w83627ehf w83627ehf.323=
2: Increasing fan3 clock divider from 64 to 128 <br>w83627ehf w83627ehf.323=
2: Increasing fan5 clock divider from 16 to 32 <br>w83627ehf
 w83627ehf.3232: Increasing fan5 clock divider from 32 to 64 <br>w83627ehf =
w83627ehf.3232: Increasing fan5 clock divider from 64 to 128 <br>&nbsp;SENS=
ORS-DETECT OUTPUT: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D <br># sensors-detect revision 5666 (2009-02-26 17:15:=
04 +0100) <br># System: LENOVO 6427CTO <br># Board: LENOVO LENOVO <br>&nbsp=
;<br>This program will help you determine which kernel modules you need <br=
>to load to use lm_sensors most effectively. It is generally safe <br>and r=
ecommended to accept the default answers to all questions, <br>unless you k=
now what you're doing. <br>&nbsp;<br>Some south bridges, CPUs or memory con=
trollers contain embedded sensors. <br>Do you want to scan for them? This i=
s totally safe. (YES/no):&nbsp; <br>Silicon Integrated Systems SIS5595...&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No <br>VIA VT82C686=
 Integrated
 Sensors...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; No <br>VIA VT8231 Integrated Sensors...&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No <br>AMD =
K8 thermal sensors...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 No <br>AMD K10 thermal sensors...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; No <br>Intel Core family thermal
 sensor...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; Success! <br>&nbsp;&nbsp;&nbsp; (driver `coretemp') <br>Intel AMB FB-D=
IMM thermal sensor...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; Success! <br>&nbsp;&nbsp;&nbsp; (driver `i5k_amb') <br>VIA =
C7 thermal and voltage sensors...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; No <br>&nbsp;<br>Some Super I/O chips contain embedded sens=
ors. We have to write to <br>standard I/O ports to probe them. This is usua=
lly safe. <br>Do you want to scan for Super I/O sensors? (YES/no):&nbsp; <b=
r>Probing for Super-I/O at 0x2e/0x2f <br>Trying family `National
 Semiconductor'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No <br>Trying family `S=
MSC'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; N=
o <br>Trying family `VIA/Winbond/Fintek'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; Yes <br>Found `Winbond W83627EHF/EF/EHG/EG Super =
IO Sensors'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success! <br>&nbsp;&n=
bsp;&nbsp; (address 0xca0, driver `w83627ehf') <br>Probing for Super-I/O at=
 0x4e/0x4f <br>Trying family `National Semiconductor'...&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; No <br>Trying family
 `SMSC'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; No <br>Trying family `VIA/Winbond/Fintek'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; No <br>Trying family `ITE'...&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No <br>&nbsp;<br>So=
me systems (mainly servers) implement IPMI, a set of common interfaces <br>=
through which system health data may be retrieved, amongst other things. <b=
r>We have to read from arbitrary I/O ports to probe for such interfaces. <b=
r>This is normally safe. Do you want to scan for IPMI interfaces?
 <br>(YES/no):&nbsp; <br>Probing for `IPMI BMC KCS' at 0xca0...&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No <br>Probing for `IPMI BMC SMIC' =
at 0xca8...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No <br>&nbsp;<br>S=
ome hardware monitoring chips are accessible through the ISA I/O ports. <br=
>We have to write to arbitrary I/O ports to probe them. This is usually <br=
>safe though. Yes, you do have ISA I/O ports even if you do not have any <b=
r>ISA slots! Do you want to scan the ISA I/O ports? (yes/NO):&nbsp; <br>&nb=
sp;<br>Lastly, we can probe the I2C/SMBus adapters for connected hardware <=
br>monitoring devices. This is the most risky part, and while it works <br>=
reasonably well on most systems, it has been reported to cause trouble <br>=
on some systems. <br>Do you want to probe the I2C/SMBus adapters
 now? (YES/no):&nbsp; <br>Using driver `i2c-i801' for device 0000:00:1f.3: =
Intel Enterprise Southbridge - ESB2 <br>Module i2c-dev loaded successfully.=
 <br>&nbsp;<br>Next adapter: SMBus I801 adapter at 1100 (i2c-0) <br>Do you =
want to scan it? (yes/NO/selectively):&nbsp; <br><br>Next adapter: NVIDIA i=
2c adapter&nbsp; (i2c-2) <br>Do you want to scan it? (YES/no/selectively):&=
nbsp; <br>Client found at address 0x50 <br>Probing for `Analog Devices ADM1=
033'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No <br>Probing for `An=
alog Devices ADM1034'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No <b=
r>Probing for `SPD
 EEPROM'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No <br>Probing for `E=
DID EEPROM'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Yes <br>&nbsp;&nbsp;&nbs=
p; (confidence 8, not a hardware monitoring chip) <br>&nbsp;<br>Next adapte=
r: NVIDIA i2c adapter&nbsp; (i2c-3) <br>Do you want to scan it? (YES/no/sel=
ectively):&nbsp; <br>Client found at address 0x2e <br>Probing for `Myson MT=
P008'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No <br>Probing for `National Semicon=
ductor
 LM78'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; No <br>Probing for `National Semiconductor LM79'..=
..&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; No <br>Probing for `National Semiconductor LM80'...&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; No <br>Probing for `National Semiconductor LM85'...&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 No <br>Probing for `National Semiconductor LM96000 or PC8374L'...&nbsp; No=
 <br>Probing for `Analog Devices ADM1027'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; No <br>Probing for `Analog Devices ADT7460 or ADT7463'...&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No <br>Probing for `SMS=
C EMC6D100 or
 EMC6D101'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No <br>Probing for `SMSC EMC6D102'=
....&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; No <br>Probing for `SMSC EMC6D103'...&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; No <br>Probing for `Winbond WPCD377I'...&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No <br>Probin=
g for `Analog Devices ADT7467 or ADT7468'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; No <br>Probing for `Analog Devices
 ADT7470'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No <br>Probing fo=
r `Analog Devices ADT7473'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
Success! <br>&nbsp;&nbsp;&nbsp; (confidence 5, driver `adt7473') <br>Probin=
g for `Analog Devices ADT7475'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; No <br>Probing for `Analog Devices ADT7476'...&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; No <br>Probing for `Andigilog aSC7611'...&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No <br>Probi=
ng for `Andigilog
 aSC7621'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; No <br>Probing for `National Semiconductor LM87'...&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; No <br>Probing for `Analog Devices ADM1024'...&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; No <br>Probing for `National Semiconductor LM93'...&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; No <br>Probing for `Winbond W83781D'...&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No <br>Pr=
obing for `Winbond
 W83782D'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; No <br>Probing for `Winbond W83791D'...&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; No <br>Probing for `Winbond W83792D'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No <br>Probing for `W=
inbond W83793R/G'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; No <br>Probing for `Winbond W83627HF'...&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 No <br>Probing for `Winbond W83627EHF'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No <br>Probing for `Winbond W836=
27DHG'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; No <br>Probing for `Asus AS99127F (rev.1)'...&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No <br>Probing for `Asus AS99127F (rev.2)'.=
...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No <br>Probing for `A=
sus ASB100 Bach'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; No <br>Probing for `Winbond
 W83L786NR/NG/R/G'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No <br>Probing for `=
Winbond W83L785TS-S'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; No <br>Probing for `Analog Devices ADM9240'...&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; No <br>Probing for `Dallas Semiconductor DS178=
0'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; No <br>Probing for `National Semiconductor LM81'...&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; No <br>Probing for `Analog Devices ADM1026'...&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No <br>Probing for `Analog Devices
 ADM1025'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No <br>Probing fo=
r `Analog Devices ADM1029'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
No <br>Probing for `Analog Devices ADM1030'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; No <br>Probing for `Analog Devices ADM1031'...&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No <br>Probing for `Analog Devices ADM102=
2'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No <br>Probing for `Texa=
s Instruments THMC50'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No
 <br>Probing for `Analog Devices ADM1028'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; No <br>Probing for `Texas Instruments THMC51'...&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; No <br>Probing for `ITE IT8712F'...&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; No <br>Probing for `SMSC DME1737'...&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; No <br>Probing for `SMSC SCH5027D-NW'...&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No
 <br>Probing for `Fintek F75373S/SG'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No <br>Probing for `Fintek F75375S/=
SP'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; No <br>Probing for `Fintek F75387SG/RG'...&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No <br>Probing for `Winbond W83=
791SD'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; No <br>&nbsp;<br>Now follows a summary of the probes I have=
 just done. <br>Just press ENTER to continue:&nbsp; <br><br>Driver `w83627e=
hf': <br>&nbsp; * ISA bus, address 0xca0 <br>&nbsp;&nbsp;&nbsp; Chip
 `Winbond W83627EHF/EF/EHG/EG Super IO Sensors' (confidence: 9) <br>&nbsp;<=
br>Driver `adt7473': <br>&nbsp; * Bus `NVIDIA i2c adapter ' <br>&nbsp;&nbsp=
;&nbsp; Busdriver `nvidia', I2C address 0x2e <br>&nbsp;&nbsp;&nbsp; Chip `A=
nalog Devices ADT7473' (confidence: 5) <br>&nbsp;<br>Driver `coretemp': <br=
>&nbsp; * Chip `Intel Core family thermal sensor' (confidence: 9) <br>&nbsp=
;<br>Driver `i5k_amb': <br>&nbsp; * Chip `Intel AMB FB-DIMM thermal sensor'=
 (confidence: 9) <br>&nbsp;<br>To load everything that is needed, add this =
to /etc/modules: <br>#----cut here---- <br># Adapter drivers <br>nvidia <br=
># Chip drivers <br>adt7473 <br>coretemp <br>i5k_amb <br>w83627ehf <br>#---=
-cut here---- <br>If you have some drivers built into your kernel, the list=
 above will <br>contain too many modules. Skip the appropriate ones! <br>&n=
bsp;<br>Do you want to add these lines automatically to /etc/modules? (yes/=
NO) <br>&nbsp;<br>Unloading i2c-dev... OK <br><br>LSMOD OUTPUT:
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D <br>Module&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Size&nbsp; Used by <br>w83627ehf&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 24328&nbsp; 0&nbsp; <br>ppp_async&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10072&nbsp; 1&nbsp; <br>crc_ccitt&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; 1944&nbsp; 1 ppp_async <br>ppp_generic&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 21720&nbsp; 5 ppp_async <br>slhc&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5752&nbsp; 1 ppp_generic <br>hwmon_vid&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; 3480&nbsp; 1 w83627ehf
 <br>coretemp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; 6360&nbsp; 0&nbsp; <br>adt7473&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
20232&nbsp; 0&nbsp; <br>nvidia&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8113496&nbsp; 26&nbsp; <br>loop&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 17252&nbsp; 0&nbsp; <br>sg&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; 32640&nbsp; 0&nbsp; <br>sr_mod&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; 15940&nbsp; 0&nbsp; <br>snd_hda_codec_realtek&nbsp;&nbsp; 253884&nbsp; =
1&nbsp; <br>cdrom&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 37704&nbsp; 1 sr_mod
 <br>usb_storage&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; 56416&nbsp; 0&nbsp; <br>ata_piix&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 26396&nbsp; 0&nbsp; <br>s=
nd_hda_intel&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 26952&nb=
sp; 3&nbsp; <br>ahci&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 35876&nbsp; 0&nbsp; <=
br>uhci_hcd&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; 34680&nbsp; 0&nbsp; <br>ehci_hcd&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 52816&nbsp; =
0&nbsp; <br>ohci1394&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 32276&nbsp; 0&nbsp; <br>e1000e&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 125960&nbsp; 0&nbsp;
 <br>snd_hda_codec&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 58=
712&nbsp; 2 snd_hda_codec_realtek,snd_hda_intel <br>libata&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1=
74380&nbsp; 2 ata_piix,ahci <br>i5k_amb&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6720&nbsp; 0&n=
bsp; <br>hwmon&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2888&nbsp; 4 w83627ehf,core=
temp,adt7473,i5k_amb <br>i2c_i801&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10612&nbsp; 0&nbsp; <br><br>OUTP=
UT OF LSPCI -NN: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D <br>00:00.0 Host bridge [0600]: Intel Corporation 5400 C=
hipset Memory Controller Hub [8086:4001] (rev 20) <br>00:01.0 PCI bridge [0=
604]: Intel Corporation 5400 Chipset PCI Express Port 1 [8086:4021] (rev 20=
) <br>00:05.0 PCI
 bridge [0604]: Intel Corporation 5400 Chipset PCI Express Port 5 [8086:402=
5] (rev 20) <br>00:09.0 PCI bridge [0604]: Intel Corporation 5400 Chipset P=
CI Express Port 9 [8086:4029] (rev 20) <br>00:10.0 Host bridge [0600]: Inte=
l Corporation 5400 Chipset FSB Registers [8086:4030] (rev 20) <br>00:10.1 H=
ost bridge [0600]: Intel Corporation 5400 Chipset FSB Registers [8086:4030]=
 (rev 20) <br>00:10.2 Host bridge [0600]: Intel Corporation 5400 Chipset FS=
B Registers [8086:4030] (rev 20) <br>00:10.3 Host bridge [0600]: Intel Corp=
oration 5400 Chipset FSB Registers [8086:4030] (rev 20) <br>00:10.4 Host br=
idge [0600]: Intel Corporation 5400 Chipset FSB Registers [8086:4030] (rev =
20) <br>00:11.0 Host bridge [0600]: Intel Corporation 5400 Chipset CE/SF Re=
gisters [8086:4031] (rev 20) <br>00:15.0 Host bridge [0600]: Intel Corporat=
ion 5400 Chipset FBD Registers [8086:4035] (rev 20) <br>00:15.1 Host bridge=
 [0600]: Intel Corporation 5400 Chipset FBD Registers [8086:4035]
 (rev 20) <br>00:16.0 Host bridge [0600]: Intel Corporation 5400 Chipset FB=
D Registers [8086:4036] (rev 20) <br>00:16.1 Host bridge [0600]: Intel Corp=
oration 5400 Chipset FBD Registers [8086:4036] (rev 20) <br>00:1b.0 Audio d=
evice [0403]: Intel Corporation 631xESB/632xESB High Definition Audio Contr=
oller [8086:269a] (rev 09) <br>00:1c.0 PCI bridge [0604]: Intel Corporation=
 631xESB/632xESB/3100 Chipset PCI Express Root Port 1 [8086:2690] (rev 09) =
<br>00:1d.0 USB Controller [0c03]: Intel Corporation 631xESB/632xESB/3100 C=
hipset UHCI USB Controller #1 [8086:2688] (rev 09) <br>00:1d.1 USB Controll=
er [0c03]: Intel Corporation 631xESB/632xESB/3100 Chipset UHCI USB Controll=
er #2 [8086:2689] (rev 09) <br>00:1d.2 USB Controller [0c03]: Intel Corpora=
tion 631xESB/632xESB/3100 Chipset UHCI USB Controller #3 [8086:268a] (rev 0=
9) <br>00:1d.3 USB Controller [0c03]: Intel Corporation 631xESB/632xESB/310=
0 Chipset UHCI USB Controller #4 [8086:268b] (rev 09) <br>00:1d.7
 USB Controller [0c03]: Intel Corporation 631xESB/632xESB/3100 Chipset EHCI=
 USB2 Controller [8086:268c] (rev 09) <br>00:1e.0 PCI bridge [0604]: Intel =
Corporation 82801 PCI Bridge [8086:244e] (rev d9) <br>00:1f.0 ISA bridge [0=
601]: Intel Corporation 631xESB/632xESB/3100 Chipset LPC Interface Controll=
er [8086:2670] (rev 09) <br>00:1f.1 IDE interface [0101]: Intel Corporation=
 631xESB/632xESB IDE Controller [8086:269e] (rev 09) <br>00:1f.2 SATA contr=
oller [0106]: Intel Corporation 631xESB/632xESB SATA AHCI Controller [8086:=
2681] (rev 09) <br>00:1f.3 SMBus [0c05]: Intel Corporation 631xESB/632xESB/=
3100 Chipset SMBus Controller [8086:269b] (rev 09) <br>05:00.0 VGA compatib=
le controller [0300]: nVidia Corporation Quadro FX 1700 [10de:040f] (rev a1=
) <br>09:00.0 PCI bridge [0604]: Intel Corporation 6311ESB/6321ESB PCI Expr=
ess Upstream Port [8086:3500] (rev 01) <br>09:00.3 PCI bridge [0604]: Intel=
 Corporation 6311ESB/6321ESB PCI Express to PCI-X Bridge [8086:350c]
 (rev 01) <br>0a:00.0 PCI bridge [0604]: Intel Corporation 6311ESB/6321ESB =
PCI Express Downstream Port E1 [8086:3510] (rev 01) <br>0a:01.0 PCI bridge =
[0604]: Intel Corporation 6311ESB/6321ESB PCI Express Downstream Port E2 [8=
086:3514] (rev 01) <br>0a:02.0 PCI bridge [0604]: Intel Corporation 6311ESB=
/6321ESB PCI Express Downstream Port E3 [8086:3518] (rev 01) <br>0f:00.0 Et=
hernet controller [0200]: Intel Corporation 80003ES2LAN Gigabit Ethernet Co=
ntroller (Copper) [8086:1096] (rev 01) <br>0f:00.1 Ethernet controller [020=
0]: Intel Corporation 80003ES2LAN Gigabit Ethernet Controller (Copper) [808=
6:1096] (rev 01) <br>1f:00.0 SCSI storage controller [0100]: LSI Logic / Sy=
mbios Logic SAS1068E PCI-Express Fusion-MPT SAS [1000:0058] (rev 04) <br>20=
:04.0 Audio device [0403]: Creative Labs SB X-Fi [1102:0005] <br>20:05.0 Fi=
reWire (IEEE 1394) [0c00]: Texas Instruments TSB43AB22/A IEEE-1394a-2000 Co=
ntroller (PHY/Link) [104c:8023] <br>&nbsp;<br>&nbsp;<br>CHIP PART
 NUMBER: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D <br>816G9C28083030UB <br>&nbsp;<br>"SENSORS -S ERRORS": =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D <br>ioct=
l(3, SNDCTL_TMR_TIMEBASE or TCGETS, 0x7fff86877cd0) =3D -1 ENOTTY (Inapprop=
riate ioctl for device) <br>ioctl(3, SNDCTL_TMR_TIMEBASE or TCGETS, 0x7fff8=
6876570) =3D -1 ENOTTY (Inappropriate ioctl for device) <br><br></div></div=
><br>=0A=0A      </body></html>
--0-1733181912-1239502296=:99688--



--===============5555565776693550081==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5555565776693550081==--

