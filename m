From: "Cayden" <cocayden@gmail.com>
Date: Fri, 03 Apr 2009 12:53:43 +0000
Subject: [lm-sensors] MSI 945GC with Intel Atom 330,
Message-Id: <000601c9b45b$3a5ee150$af1ca3f0$@com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6380540500259005958=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multipart message in MIME format.

--===============6380540500259005958==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0007_01C9B4AF.0C0AF150"
Content-Language: en-au

This is a multipart message in MIME format.

------=_NextPart_000_0007_01C9B4AF.0C0AF150
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

An unknown sensor is detected when sensors detect is run. 

Found unknown chip with ID 0x0541 is the only real output I get. 

Motherboard Datasheet:
http://www.msi.com/index.php?func=downloaddetail&type=sheet&maincat_no=388&p
rod_no=1614

 

Motherboard: MSI 945GC

Kernel :2.6.18

Lm_sensors : 2.10.7-4

 

 

Lsmod output:

Module                  Size  Used by

i2c_dev                12613  0

autofs4                24261  2

hidp                   23105  2

l2cap                  29505  5 hidp

bluetooth              53797  2 hidp,l2cap

sunrpc                144765  1

ip_conntrack_netbios_ns     6977  0

ipt_REJECT              9537  1

xt_state                6209  9

ip_conntrack           52897  2 ip_conntrack_netbios_ns,xt_state

nfnetlink              10713  1 ip_conntrack

iptable_filter          7105  1

ip_tables              17029  1 iptable_filter

ip6t_REJECT             9409  1

xt_tcpudp               7105  24

ip6table_filter         6849  1

ip6_tables             18053  1 ip6table_filter

x_tables               17349  6
ipt_REJECT,xt_state,ip_tables,ip6t_REJECT,xt_tcpudp,ip6_tables

ipv6                  261473  27 ip6t_REJECT

xfrm_nalgo             13381  1 ipv6

crypto_api             12609  1 xfrm_nalgo

dm_multipath           24013  0

scsi_dh                11713  1 dm_multipath

parport_pc             29157  0

lp                     15849  0

parport                37513  2 parport_pc,lp

snd_hda_intel         343537  0

snd_seq_dummy           7877  0

snd_seq_oss            32577  0

snd_seq_midi_event     11073  1 snd_seq_oss

snd_seq                49585  5 snd_seq_dummy,snd_seq_oss,snd_seq_midi_event

snd_seq_device         11725  3 snd_seq_dummy,snd_seq_oss,snd_seq

snd_pcm_oss            42817  0

snd_mixer_oss          19009  1 snd_pcm_oss

snd_pcm                72133  2 snd_hda_intel,snd_pcm_oss

snd_timer              24517  2 snd_seq,snd_pcm

snd_page_alloc         14281  2 snd_hda_intel,snd_pcm

snd_hwdep              12869  1 snd_hda_intel

snd                    55237  9
snd_hda_intel,snd_seq_oss,snd_seq,snd_seq_device,snd_pcm_oss,snd_mixer_oss,s
nd_pcm,snd_timer,snd_hwdep

soundcore              11553  1 snd

i2c_i801               11725  0

i2c_core               23745  2 i2c_dev,i2c_i801

sg                     36189  0

ide_cd                 40161  0

serio_raw              10693  0

pcspkr                  7105  0

r8169                  37573  0

cdrom                  36577  1 ide_cd

mii                     9409  1 r8169

r8168                  41364  0

dm_raid45              66509  0

dm_message              6977  1 dm_raid45

dm_region_hash         15681  1 dm_raid45

dm_mem_cache            9537  1 dm_raid45

dm_snapshot            22245  0

dm_zero                 6209  0

dm_mirror              23877  0

dm_log                 14529  3 dm_raid45,dm_region_hash,dm_mirror

dm_mod                 62201  11
dm_multipath,dm_raid45,dm_snapshot,dm_zero,dm_mirror,dm_log

ata_piix               23621  2

libata                156677  1 ata_piix

sd_mod                 25153  2

scsi_mod              141589  4 scsi_dh,sg,libata,sd_mod

ext3                  124233  2

jbd                    56937  1 ext3

uhci_hcd               25421  0

ohci_hcd               24681  0

ehci_hcd               33357  0

 

Sensors Detect Output:

# sensors-detect revision 5291 (2008-06-23 23:40:46 -0700)

 

This program will help you determine which kernel modules you need

to load to use lm_sensors most effectively. It is generally safe

and recommended to accept the default answers to all questions,

unless you know what you're doing.

 

We can start with probing for (PCI) I2C or SMBus adapters.

Do you want to probe now? (YES/no): YES

Probing for PCI bus adapters...

Use driver `i2c-i801' for device 0000:00:1f.3: Intel 82801G ICH7

 

We will now try to load each adapter module in turn.

Module `i2c-i801' already loaded.

If you have undetectable or unsupported I2C/SMBus adapters, you can have

them scanned by manually loading the modules before running this script.

 

We are now going to do the I2C/SMBus adapter probings. Some chips may

be double detected; we choose the one with the highest confidence

value in that case.

If you found that the adapter hung after probing a certain address,

you can specify that address to remain unprobed.

 

Next adapter: SMBus I801 adapter at 0400 (i2c-0)

Do you want to scan it? (YES/no/selectively): YES

Client found at address 0x50

Probing for `Analog Devices ADM1033'...                     No

Probing for `Analog Devices ADM1034'...                     No

Probing for `SPD EEPROM'...                                 Yes

    (confidence 8, not a hardware monitoring chip)

Probing for `EDID EEPROM'...                                No

 

Some chips are also accessible through the ISA I/O ports. We have to

write to arbitrary I/O ports to probe them. This is usually safe though.

Yes, you do have ISA I/O ports even if you do not have any ISA slots!

Do you want to scan the ISA I/O ports? (YES/no): YES

Probing for `National Semiconductor LM78' at 0x290...       No

Probing for `National Semiconductor LM78-J' at 0x290...     No

Probing for `National Semiconductor LM79' at 0x290...       No

Probing for `Winbond W83781D' at 0x290...                   No

Probing for `Winbond W83782D' at 0x290...                   No

 

Some Super I/O chips may also contain sensors. We have to write to

standard I/O ports to probe them. This is usually safe.

Do you want to scan for Super I/O sensors? (YES/no): YES

Probing for Super-I/O at 0x2e/0x2f

Trying family `National Semiconductor'...                   No

Trying family `SMSC'...                                     No

Trying family `VIA/Winbond/Fintek'...                       No

Trying family `ITE'...                                      No

Probing for Super-I/O at 0x4e/0x4f

Trying family `National Semiconductor'...                   No

Trying family `SMSC'...                                     No

Trying family `VIA/Winbond/Fintek'...                       Yes

Found unknown chip with ID 0x0541

 

Some south bridges, CPUs or memory controllers may also contain

embedded sensors. Do you want to scan for them? (YES/no): YES

Silicon Integrated Systems SIS5595...                       No

VIA VT82C686 Integrated Sensors...                          No

VIA VT8231 Integrated Sensors...                            No

AMD K8 thermal sensors...                                   No

AMD K10 thermal sensors...                                  No

Intel AMB FB-DIMM thermal sensor...                         No

 

Sorry, no sensors were detected.

Either your sensors are not supported, or they are connected to an

I2C or SMBus adapter that is not supported.

 

Lspci Output:

00:00.0 0600: 8086:2770 (rev 02)

00:02.0 0300: 8086:2772 (rev 02)

00:1b.0 0403: 8086:27d8 (rev 01)

00:1c.0 0604: 8086:27d0 (rev 01)

00:1c.1 0604: 8086:27d2 (rev 01)

00:1d.0 0c03: 8086:27c8 (rev 01)

00:1d.1 0c03: 8086:27c9 (rev 01)

00:1d.2 0c03: 8086:27ca (rev 01)

00:1d.3 0c03: 8086:27cb (rev 01)

00:1d.7 0c03: 8086:27cc (rev 01)

00:1e.0 0604: 8086:244e (rev e1)

00:1f.0 0601: 8086:27b8 (rev 01)

00:1f.1 0101: 8086:27df (rev 01)

00:1f.2 0101: 8086:27c0 (rev 01)

00:1f.3 0c05: 8086:27da (rev 01)

01:00.0 0200: 10ec:8168 (rev 02)

02:00.0 0200: 10ec:8168 (rev 02)

 

Any help getting the sensors to work on this motherboard would be much
appreciated.


------=_NextPart_000_0007_01C9B4AF.0C0AF150
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page Section1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal>An unknown sensor is detected when sensors detect =
is run. <o:p></o:p></p>

<p class=3DMsoNormal>Found unknown chip with ID 0x0541 is the only real =
output I get.
<o:p></o:p></p>

<p class=3DMsoNormal>Motherboard Datasheet: =
http://www.msi.com/index.php?func=3Ddownloaddetail&amp;type=3Dsheet&amp;m=
aincat_no=3D388&amp;prod_no=3D1614<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Motherboard: MSI 945GC<o:p></o:p></p>

<p class=3DMsoNormal>Kernel :2.6.18<o:p></o:p></p>

<p class=3DMsoNormal>Lm_sensors : 2.10.7-4<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Lsmod output:<o:p></o:p></p>

<p =
class=3DMsoNormal>Module&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Size&nbsp; Used by<o:p></o:p></p>

<p =
class=3DMsoNormal>i2c_dev&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
12613&nbsp; 0<o:p></o:p></p>

<p =
class=3DMsoNormal>autofs4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
24261&nbsp; 2<o:p></o:p></p>

<p =
class=3DMsoNormal>hidp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
23105&nbsp; 2<o:p></o:p></p>

<p =
class=3DMsoNormal>l2cap&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
29505&nbsp; 5 hidp<o:p></o:p></p>

<p =
class=3DMsoNormal>bluetooth&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
53797&nbsp; 2 hidp,l2cap<o:p></o:p></p>

<p =
class=3DMsoNormal>sunrpc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
144765&nbsp; 1<o:p></o:p></p>

<p class=3DMsoNormal>ip_conntrack_netbios_ns&nbsp;&nbsp;&nbsp;&nbsp; =
6977&nbsp; 0<o:p></o:p></p>

<p =
class=3DMsoNormal>ipt_REJECT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
9537&nbsp; 1<o:p></o:p></p>

<p =
class=3DMsoNormal>xt_state&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
6209&nbsp; 9<o:p></o:p></p>

<p =
class=3DMsoNormal>ip_conntrack&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;
52897&nbsp; 2 ip_conntrack_netbios_ns,xt_state<o:p></o:p></p>

<p =
class=3DMsoNormal>nfnetlink&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
10713&nbsp; 1 ip_conntrack<o:p></o:p></p>

<p =
class=3DMsoNormal>iptable_filter&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;
7105&nbsp; 1<o:p></o:p></p>

<p =
class=3DMsoNormal>ip_tables&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
17029&nbsp; 1 iptable_filter<o:p></o:p></p>

<p =
class=3DMsoNormal>ip6t_REJECT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;
9409&nbsp; 1<o:p></o:p></p>

<p =
class=3DMsoNormal>xt_tcpudp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
7105&nbsp; 24<o:p></o:p></p>

<p =
class=3DMsoNormal>ip6table_filter&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;
6849&nbsp; 1<o:p></o:p></p>

<p class=3DMsoNormal>ip6_tables&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;18053&nbsp;
1 ip6table_filter<o:p></o:p></p>

<p =
class=3DMsoNormal>x_tables&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
17349&nbsp; 6 =
ipt_REJECT,xt_state,ip_tables,ip6t_REJECT,xt_tcpudp,ip6_tables<o:p></o:p>=
</p>

<p =
class=3DMsoNormal>ipv6&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
261473&nbsp; 27 ip6t_REJECT<o:p></o:p></p>

<p =
class=3DMsoNormal>xfrm_nalgo&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;
13381&nbsp; 1 ipv6<o:p></o:p></p>

<p =
class=3DMsoNormal>crypto_api&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;
12609&nbsp; 1 xfrm_nalgo<o:p></o:p></p>

<p =
class=3DMsoNormal>dm_multipath&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;
24013&nbsp; 0<o:p></o:p></p>

<p =
class=3DMsoNormal>scsi_dh&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
11713&nbsp; 1 dm_multipath<o:p></o:p></p>

<p =
class=3DMsoNormal>parport_pc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;
29157&nbsp; 0<o:p></o:p></p>

<p =
class=3DMsoNormal>lp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
15849&nbsp; 0<o:p></o:p></p>

<p =
class=3DMsoNormal>parport&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
37513&nbsp; 2 parport_pc,lp<o:p></o:p></p>

<p =
class=3DMsoNormal>snd_hda_intel&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;
343537&nbsp; 0<o:p></o:p></p>

<p =
class=3DMsoNormal>snd_seq_dummy&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;
7877&nbsp; 0<o:p></o:p></p>

<p =
class=3DMsoNormal>snd_seq_oss&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;
32577&nbsp; 0<o:p></o:p></p>

<p class=3DMsoNormal>snd_seq_midi_event&nbsp;&nbsp;&nbsp;&nbsp; =
11073&nbsp; 1
snd_seq_oss<o:p></o:p></p>

<p =
class=3DMsoNormal>snd_seq&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
49585&nbsp; 5 =
snd_seq_dummy,snd_seq_oss,snd_seq_midi_event<o:p></o:p></p>

<p =
class=3DMsoNormal>snd_seq_device&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;
11725&nbsp; 3 snd_seq_dummy,snd_seq_oss,snd_seq<o:p></o:p></p>

<p =
class=3DMsoNormal>snd_pcm_oss&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;
42817&nbsp; 0<o:p></o:p></p>

<p =
class=3DMsoNormal>snd_mixer_oss&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;
19009&nbsp; 1 snd_pcm_oss<o:p></o:p></p>

<p =
class=3DMsoNormal>snd_pcm&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
72133&nbsp; 2 snd_hda_intel,snd_pcm_oss<o:p></o:p></p>

<p =
class=3DMsoNormal>snd_timer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
24517&nbsp; 2 snd_seq,snd_pcm<o:p></o:p></p>

<p =
class=3DMsoNormal>snd_page_alloc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;
14281&nbsp; 2 snd_hda_intel,snd_pcm<o:p></o:p></p>

<p =
class=3DMsoNormal>snd_hwdep&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
12869&nbsp; 1 snd_hda_intel<o:p></o:p></p>

<p class=3DMsoNormal>snd&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;5=
5237&nbsp;
9
snd_hda_intel,snd_seq_oss,snd_seq,snd_seq_device,snd_pcm_oss,snd_mixer_os=
s,snd_pcm,snd_timer,snd_hwdep<o:p></o:p></p>

<p =
class=3DMsoNormal>soundcore&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
11553&nbsp; 1 snd<o:p></o:p></p>

<p =
class=3DMsoNormal>i2c_i801&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
11725&nbsp; 0<o:p></o:p></p>

<p =
class=3DMsoNormal>i2c_core&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
23745&nbsp; 2 i2c_dev,i2c_i801<o:p></o:p></p>

<p =
class=3DMsoNormal>sg&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;36189&nbsp; =
0<o:p></o:p></p>

<p =
class=3DMsoNormal>ide_cd&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
40161&nbsp; 0<o:p></o:p></p>

<p =
class=3DMsoNormal>serio_raw&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
10693&nbsp; 0<o:p></o:p></p>

<p =
class=3DMsoNormal>pcspkr&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
7105&nbsp; 0<o:p></o:p></p>

<p =
class=3DMsoNormal>r8169&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
37573&nbsp; 0<o:p></o:p></p>

<p =
class=3DMsoNormal>cdrom&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
36577&nbsp; 1 ide_cd<o:p></o:p></p>

<p =
class=3DMsoNormal>mii&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
9409&nbsp; 1 r8169<o:p></o:p></p>

<p =
class=3DMsoNormal>r8168&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
41364&nbsp; 0<o:p></o:p></p>

<p =
class=3DMsoNormal>dm_raid45&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
66509&nbsp; 0<o:p></o:p></p>

<p =
class=3DMsoNormal>dm_message&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
6977&nbsp; 1 dm_raid45<o:p></o:p></p>

<p =
class=3DMsoNormal>dm_region_hash&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;
15681&nbsp; 1 dm_raid45<o:p></o:p></p>

<p =
class=3DMsoNormal>dm_mem_cache&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
9537&nbsp; 1 dm_raid45<o:p></o:p></p>

<p =
class=3DMsoNormal>dm_snapshot&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;
22245&nbsp; 0<o:p></o:p></p>

<p =
class=3DMsoNormal>dm_zero&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
6209&nbsp; 0<o:p></o:p></p>

<p =
class=3DMsoNormal>dm_mirror&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
23877&nbsp; 0<o:p></o:p></p>

<p =
class=3DMsoNormal>dm_log&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
14529&nbsp; 3 dm_raid45,dm_region_hash,dm_mirror<o:p></o:p></p>

<p =
class=3DMsoNormal>dm_mod&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
62201&nbsp; 11 =
dm_multipath,dm_raid45,dm_snapshot,dm_zero,dm_mirror,dm_log<o:p></o:p></p=
>

<p =
class=3DMsoNormal>ata_piix&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
23621&nbsp; 2<o:p></o:p></p>

<p =
class=3DMsoNormal>libata&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
156677&nbsp; 1 ata_piix<o:p></o:p></p>

<p =
class=3DMsoNormal>sd_mod&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
25153&nbsp; 2<o:p></o:p></p>

<p =
class=3DMsoNormal>scsi_mod&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
141589&nbsp; 4 scsi_dh,sg,libata,sd_mod<o:p></o:p></p>

<p =
class=3DMsoNormal>ext3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
124233&nbsp; 2<o:p></o:p></p>

<p =
class=3DMsoNormal>jbd&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
56937&nbsp; 1 ext3<o:p></o:p></p>

<p =
class=3DMsoNormal>uhci_hcd&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
25421&nbsp; 0<o:p></o:p></p>

<p =
class=3DMsoNormal>ohci_hcd&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
24681&nbsp; 0<o:p></o:p></p>

<p =
class=3DMsoNormal>ehci_hcd&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
33357&nbsp; 0<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Sensors Detect Output:<o:p></o:p></p>

<p class=3DMsoNormal># sensors-detect revision 5291 (2008-06-23 23:40:46 =
-0700)<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>This program will help you determine which kernel =
modules
you need<o:p></o:p></p>

<p class=3DMsoNormal>to load to use lm_sensors most effectively. It is =
generally
safe<o:p></o:p></p>

<p class=3DMsoNormal>and recommended to accept the default answers to =
all
questions,<o:p></o:p></p>

<p class=3DMsoNormal>unless you know what you're doing.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>We can start with probing for (PCI) I2C or SMBus =
adapters.<o:p></o:p></p>

<p class=3DMsoNormal>Do you want to probe now? (YES/no): =
YES<o:p></o:p></p>

<p class=3DMsoNormal>Probing for PCI bus adapters...<o:p></o:p></p>

<p class=3DMsoNormal>Use driver `i2c-i801' for device 0000:00:1f.3: =
Intel 82801G
ICH7<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>We will now try to load each adapter module in =
turn.<o:p></o:p></p>

<p class=3DMsoNormal>Module `i2c-i801' already loaded.<o:p></o:p></p>

<p class=3DMsoNormal>If you have undetectable or unsupported I2C/SMBus =
adapters,
you can have<o:p></o:p></p>

<p class=3DMsoNormal>them scanned by manually loading the modules before =
running
this script.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>We are now going to do the I2C/SMBus adapter =
probings. Some
chips may<o:p></o:p></p>

<p class=3DMsoNormal>be double detected; we choose the one with the =
highest
confidence<o:p></o:p></p>

<p class=3DMsoNormal>value in that case.<o:p></o:p></p>

<p class=3DMsoNormal>If you found that the adapter hung after probing a =
certain
address,<o:p></o:p></p>

<p class=3DMsoNormal>you can specify that address to remain =
unprobed.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Next adapter: SMBus I801 adapter at 0400 =
(i2c-0)<o:p></o:p></p>

<p class=3DMsoNormal>Do you want to scan it? (YES/no/selectively): =
YES<o:p></o:p></p>

<p class=3DMsoNormal>Client found at address 0x50<o:p></o:p></p>

<p class=3DMsoNormal>Probing for `Analog Devices
ADM1033'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
No<o:p></o:p></p>

<p class=3DMsoNormal>Probing for `Analog Devices
ADM1034'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
No<o:p></o:p></p>

<p class=3DMsoNormal>Probing for `SPD
EEPROM'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Yes<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; (confidence 8, not a hardware =
monitoring
chip)<o:p></o:p></p>

<p class=3DMsoNormal>Probing for `EDID
EEPROM'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
No<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Some chips are also accessible through the ISA I/O =
ports. We
have to<o:p></o:p></p>

<p class=3DMsoNormal>write to arbitrary I/O ports to probe them. This is =
usually
safe though.<o:p></o:p></p>

<p class=3DMsoNormal>Yes, you do have ISA I/O ports even if you do not =
have any
ISA slots!<o:p></o:p></p>

<p class=3DMsoNormal>Do you want to scan the ISA I/O ports? (YES/no): =
YES<o:p></o:p></p>

<p class=3DMsoNormal>Probing for `National Semiconductor LM78' at
0x290...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<o:p></o:p></p>

<p class=3DMsoNormal>Probing for `National Semiconductor LM78-J' at
0x290...&nbsp;&nbsp;&nbsp; &nbsp;No<o:p></o:p></p>

<p class=3DMsoNormal>Probing for `National Semiconductor LM79' at
0x290...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<o:p></o:p></p>

<p class=3DMsoNormal>Probing for `Winbond W83781D' at
0x290...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
No<o:p></o:p></p>

<p class=3DMsoNormal>Probing for `Winbond W83782D' at
0x290...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
No<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Some Super I/O chips may also contain sensors. We =
have to
write to<o:p></o:p></p>

<p class=3DMsoNormal>standard I/O ports to probe them. This is usually =
safe.<o:p></o:p></p>

<p class=3DMsoNormal>Do you want to scan for Super I/O sensors? =
(YES/no): YES<o:p></o:p></p>

<p class=3DMsoNormal>Probing for Super-I/O at 0x2e/0x2f<o:p></o:p></p>

<p class=3DMsoNormal>Trying family `National
Semiconductor'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
No<o:p></o:p></p>

<p class=3DMsoNormal>Trying family
`SMSC'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;
No<o:p></o:p></p>

<p class=3DMsoNormal>Trying family
`VIA/Winbond/Fintek'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;
No<o:p></o:p></p>

<p class=3DMsoNormal>Trying family
`ITE'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;
No<o:p></o:p></p>

<p class=3DMsoNormal>Probing for Super-I/O at 0x4e/0x4f<o:p></o:p></p>

<p class=3DMsoNormal>Trying family `National =
Semiconductor'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
No<o:p></o:p></p>

<p class=3DMsoNormal>Trying family
`SMSC'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;
No<o:p></o:p></p>

<p class=3DMsoNormal>Trying family
`VIA/Winbond/Fintek'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;
Yes<o:p></o:p></p>

<p class=3DMsoNormal>Found unknown chip with ID 0x0541<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Some south bridges, CPUs or memory controllers may =
also
contain<o:p></o:p></p>

<p class=3DMsoNormal>embedded sensors. Do you want to scan for them? =
(YES/no):
YES<o:p></o:p></p>

<p class=3DMsoNormal>Silicon Integrated Systems
SIS5595...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
No<o:p></o:p></p>

<p class=3DMsoNormal>VIA VT82C686 Integrated
Sensors...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;
No<o:p></o:p></p>

<p class=3DMsoNormal>VIA VT8231 Integrated
Sensors...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;
No<o:p></o:p></p>

<p class=3DMsoNormal>AMD K8 thermal
sensors...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
No<o:p></o:p></p>

<p class=3DMsoNormal>AMD K10 thermal
sensors...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
No<o:p></o:p></p>

<p class=3DMsoNormal>Intel AMB FB-DIMM thermal
sensor...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;
No<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Sorry, no sensors were detected.<o:p></o:p></p>

<p class=3DMsoNormal>Either your sensors are not supported, or they are =
connected
to an<o:p></o:p></p>

<p class=3DMsoNormal>I2C or SMBus adapter that is not =
supported.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Lspci Output:<o:p></o:p></p>

<p class=3DMsoNormal>00:00.0 0600: 8086:2770 (rev 02)<o:p></o:p></p>

<p class=3DMsoNormal>00:02.0 0300: 8086:2772 (rev 02)<o:p></o:p></p>

<p class=3DMsoNormal>00:1b.0 0403: 8086:27d8 (rev 01)<o:p></o:p></p>

<p class=3DMsoNormal>00:1c.0 0604: 8086:27d0 (rev 01)<o:p></o:p></p>

<p class=3DMsoNormal>00:1c.1 0604: 8086:27d2 (rev 01)<o:p></o:p></p>

<p class=3DMsoNormal>00:1d.0 0c03: 8086:27c8 (rev 01)<o:p></o:p></p>

<p class=3DMsoNormal>00:1d.1 0c03: 8086:27c9 (rev 01)<o:p></o:p></p>

<p class=3DMsoNormal>00:1d.2 0c03: 8086:27ca (rev 01)<o:p></o:p></p>

<p class=3DMsoNormal>00:1d.3 0c03: 8086:27cb (rev 01)<o:p></o:p></p>

<p class=3DMsoNormal>00:1d.7 0c03: 8086:27cc (rev 01)<o:p></o:p></p>

<p class=3DMsoNormal>00:1e.0 0604: 8086:244e (rev e1)<o:p></o:p></p>

<p class=3DMsoNormal>00:1f.0 0601: 8086:27b8 (rev 01)<o:p></o:p></p>

<p class=3DMsoNormal>00:1f.1 0101: 8086:27df (rev 01)<o:p></o:p></p>

<p class=3DMsoNormal>00:1f.2 0101: 8086:27c0 (rev 01)<o:p></o:p></p>

<p class=3DMsoNormal>00:1f.3 0c05: 8086:27da (rev 01)<o:p></o:p></p>

<p class=3DMsoNormal>01:00.0 0200: 10ec:8168 (rev 02)<o:p></o:p></p>

<p class=3DMsoNormal>02:00.0 0200: 10ec:8168 (rev 02)<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Any help getting the sensors to work on this =
motherboard
would be much appreciated.<o:p></o:p></p>

</div>

</body>

</html>

------=_NextPart_000_0007_01C9B4AF.0C0AF150--



--===============6380540500259005958==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6380540500259005958==--

