From: john.hawk@netzero.net (John Hawk)
Date: Thu, 19 May 2005 06:24:55 +0000
Subject: Emachines M5310
Message-Id: <1082877126.2416.19.camel@eagleone.eagles.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

I have had extended correspondence with Dave Jones of PowerNow and
finally have  PowerNow up and running and a new patch bk2 will alleviate
the need to build custome kernels every time, A Plus

This leads me to my next conquest sensor support on the Emachines M5310.
I have tried the various Windoze (yuk) options and they also complain of
BIOS options. Emachines flat refuses to address any problems with the
M5310 BIOS I have corrected four error in the DSDT and compiled and
installed same in kernel 2.6.5-1.327 Fedora Core 2 test 2.

However, if I run sensor-detect the only thing found (twice as noted
could happen) is an eprom  for memory.=20

If there is anything I can do to provide information to assist both you
and myself in obtaining accurate sensor detection please let me know. I
would like to get this up and running.

I will attach output from a little program that should provided a real
world snapshot of the current config.

Thanks

john


-------------- next part --------------
Start Path=3D/usr/kerberos/sbin:/usr/kerberos/bin:/usr/local/bin:/usr/bin:/=
bin:/usr/X11R6/bin:/home/jhawk/bin:/opt/j2sdk_nb/j2sdk1.4.2/jre/bin
Start Directory-/home/jhawk/bin
New path=3D/usr/kerberos/sbin:/usr/kerberos/bin:/usr/local/bin:/usr/bin:/bi=
n:/usr/X11R6/bin:/home/jhawk/bin:/opt/j2sdk_nb/j2sdk1.4.2/jre/bin:/sbin:/bi=
n:/usr/bin:/usr/sbin
Module                  Size  Used by
nls_utf8                1792  1=20
nls_cp437               5632  1=20
vfat                   10880  1=20
fat                    33856  1 vfat
snd_mixer_oss          13952  3=20
snd_ali5451            17092  4=20
snd_ac97_codec         50820  1 snd_ali5451
snd_pcm                69256  1 snd_ali5451
snd_page_alloc          8196  1 snd_pcm
snd_timer              17412  1 snd_pcm
snd                    38884  7 snd_mixer_oss,snd_ali5451,snd_ac97_codec,sn=
d_pcm,snd_timer
soundcore               6368  4 snd
parport_pc             19648  1=20
lp                      8364  0=20
parport                30024  2 parport_pc,lp
autofs4                11008  0=20
ds                     12420  2=20
yenta_socket           15360  0=20
pcmcia_core            47944  2 ds,yenta_socket
sunrpc                102216  1=20
ndiswrapper            58240  0=20
b44                    16004  0=20
ipt_REJECT              4864  1=20
ipt_state               1664  1=20
ip_conntrack           24112  1 ipt_state
iptable_filter          2304  1=20
ip_tables              13696  3 ipt_REJECT,ipt_state,iptable_filter
sg                     27808  0=20
scsi_mod               92112  1 sg
dm_mod                 32672  0=20
ohci_hcd               15004  0=20
ehci_hcd               21896  0=20
button                  4760  0=20
battery                 7052  0=20
asus_acpi               8728  0=20
ac                      3468  0=20
ipv6                  183648  10=20
ext3                   89000  1=20
jbd                    40472  1 ext3
Linux eagleone.eagles.net 2.6.5-1.327custom #2 Thu Apr 22 22:25:45 CDT 2004=
 i686 athlon i386 GNU/Linux
Linux version 2.6.5-1.327custom (root@eagleone.eagles.net) (gcc version 3.3=
.3 20040412 (Red Hat Linux 3.3.3-7)) #2 Thu Apr 22 22:25:45 CDT 2004
Fedora Core release 1.92 (FC2 Test 3)
DEVICE=3Dlo
IPADDR=127.0.0.1
NETMASK%5.0.0.0
NETWORK=127.0.0.0
# If you're having problems with gated making 127.0.0.0/8 a martian,
# you can change this to something else (255.255.255.255, for example)
BROADCAST=127.255.255.255
ONBOOT=3Dyes
NAME=3Dloopback
Chain INPUT (policy ACCEPT)
target     prot opt source               destination        =20
RH-Firewall-1-INPUT  all  --  0.0.0.0/0            0.0.0.0/0          =20

Chain FORWARD (policy ACCEPT)
target     prot opt source               destination        =20
RH-Firewall-1-INPUT  all  --  0.0.0.0/0            0.0.0.0/0          =20

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination        =20

Chain RH-Firewall-1-INPUT (2 references)
target     prot opt source               destination        =20
ACCEPT     udp  --  66.187.233.4         0.0.0.0/0           udp spt:123 dp=
t:123=20
ACCEPT     udp  --  66.187.233.4         0.0.0.0/0           udp spt:123 dp=
t:123=20
ACCEPT     all  --  0.0.0.0/0            0.0.0.0/0          =20
ACCEPT     icmp --  0.0.0.0/0            0.0.0.0/0           icmp type 255 =

ACCEPT     esp  --  0.0.0.0/0            0.0.0.0/0          =20
ACCEPT     ah   --  0.0.0.0/0            0.0.0.0/0          =20
ACCEPT     all  --  0.0.0.0/0            0.0.0.0/0           state RELATED,=
ESTABLISHED=20
REJECT     all  --  0.0.0.0/0            0.0.0.0/0           reject-with ic=
mp-host-prohibited=20
eth0      Link encap:Ethernet  HWaddr 00:03:25:08:AF:22 =20
          BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000=20
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
          Interrupt:11=20

lo        Link encap:Local Loopback =20
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:2339 errors:0 dropped:0 overruns:0 frame:0
          TX packets:2339 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0=20
          RX bytes:2140798 (2.0 Mb)  TX bytes:2140798 (2.0 Mb)

sit0      Link encap:IPv6-in-IPv4 =20
          NOARP  MTU:1480  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0=20
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)

wlan0     Link encap:Ethernet  HWaddr 00:90:96:61:F4:EE =20
          inet addr:192.168.1.101  Bcast:192.168.1.255  Mask:255.255.255.0
          inet6 addr: fe80::290:96ff:fe61:f4ee/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:998 errors:0 dropped:0 overruns:0 frame:0
          TX packets:889 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000=20
          RX bytes:394986 (385.7 Kb)  TX bytes:92983 (90.8 Kb)
          Interrupt:10 Memory:d0004000-d0005fff=20

Kernel IP routing table
Destination     Gateway         Genmask         Flags   MSS Window  irtt If=
ace
192.168.1.0     0.0.0.0         255.255.255.0   U         0 0          0 wl=
an0
169.254.0.0     0.0.0.0         255.255.0.0     U         0 0          0 wl=
an0
127.0.0.0       0.0.0.0         255.0.0.0       U         0 0          0 lo
0.0.0.0         192.168.1.1     0.0.0.0         UG        0 0          0 wl=
an0
Kernel Interface table
Iface       MTU Met    RX-OK RX-ERR RX-DRP RX-OVR    TX-OK TX-ERR TX-DRP TX=
-OVR Flg
1: lo: <LOOPBACK,UP> mtu 16436 qdisc noqueue=20
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
    inet6 ::1/128 scope host=20
       valid_lft forever preferred_lft forever
2: sit0: <NOARP> mtu 1480 qdisc noop=20
    link/sit 0.0.0.0 brd 0.0.0.0
4: eth0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop qlen 1000
    link/ether 00:03:25:08:af:22 brd ff:ff:ff:ff:ff:ff
5: wlan0: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast qlen 1000
    link/ether 00:90:96:61:f4:ee brd ff:ff:ff:ff:ff:ff
    inet 192.168.1.101/24 brd 192.168.1.255 scope global wlan0
    inet6 fe80::290:96ff:fe61:f4ee/64 scope link=20
       valid_lft forever preferred_lft forever
0:	from all lookup local=20
32766:	from all lookup main=20
32767:	from all lookup 253=20
192.168.1.0/24 dev wlan0  proto kernel  scope link  src 192.168.1.101=20
169.254.0.0/16 dev wlan0  scope link=20
127.0.0.0/8 dev lo  scope link=20
default via 192.168.1.1 dev wlan0=20
00:00.0 Class 0600: 1002:cab0 (rev 13)
00:01.0 Class 0604: 1002:700f (rev 01)
00:07.0 Class 0601: 10b9:1533
00:08.0 Class 0401: 10b9:5451 (rev 02)
00:09.0 Class 0703: 10b9:5457
00:0a.0 Class 0607: 104c:ac41 (rev 02)
00:0a.1 Class 0c00: 104c:8017 (rev 02)
00:0c.0 Class 0280: 14e4:4320 (rev 02)
00:0d.0 Class 0c03: 1033:0035 (rev 43)
00:0d.1 Class 0c03: 1033:0035 (rev 43)
00:0d.2 Class 0c03: 1033:00e0 (rev 04)
00:0e.0 Class 0200: 14e4:4401 (rev 01)
00:10.0 Class 0101: 10b9:5229 (rev c4)
00:11.0 Class 0680: 10b9:7101
01:05.0 Class 0300: 1002:4336
00:00.0 Class 0600: 1002:cab0 (rev 13)
00:01.0 Class 0604: 1002:700f (rev 01)
00:07.0 Class 0601: 10b9:1533
00:08.0 Class 0401: 10b9:5451 (rev 02)
00:09.0 Class 0703: 10b9:5457
00:0a.0 Class 0607: 104c:ac41 (rev 02)
00:0a.1 Class 0c00: 104c:8017 (rev 02)
00:0c.0 Class 0280: 14e4:4320 (rev 02)
00:0d.0 Class 0c03: 1033:0035 (rev 43)
00:0d.1 Class 0c03: 1033:0035 (rev 43)
00:0d.2 Class 0c03: 1033:00e0 (rev 04)
00:0e.0 Class 0200: 14e4:4401 (rev 01)
00:10.0 Class 0101: 10b9:5229 (rev c4)
00:11.0 Class 0680: 10b9:7101
01:05.0 Class 0300: 1002:4336
00:00.0 Class 0600: 1002:cab0 (rev 13)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 0: Memory at d4000000 (32-bit, prefetchable)
	Region 1: Memory at d0400000 (32-bit, prefetchable) [size=3D4K]
	Region 2: I/O ports at 8090 [disabled] [size=3D4]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=16 Iso- ArqSz=3D0 Cal=3D0 SBA+ ITACoh- GART64- HTrans- 64bit- =
FW+ AGP3- Rate=3Dx1,x2,x4
		Command: RQ=3D1 ArqSz=3D0 Cal=3D0 SBA- AGP- GART64- 64bit- FW- Rate=3D<no=
ne>

00:01.0 Class 0604: 1002:700f (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 99
	Bus: primary=00, secondary=01, subordinate=01, sec-latencyh
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: d0100000-d01fffff
	Prefetchable memory behind bridge: e0000000-efffffff
	Secondary status: SERR
	Expansion ROM at 00009000 [disabled] [size=3D4K]
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 Class 0601: 10b9:1533
	Subsystem: 10b9:1533
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [a0] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:08.0 Class 0401: 10b9:5451 (rev 02)
	Subsystem: 161f:2029
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR+ <PERR+
	Latency: 64 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 8400
	Region 1: Memory at d0008000 (32-bit, non-prefetchable) [size=3D4K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2+,D3hot+,D3col=
d+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:09.0 Class 0703: 10b9:5457
	Subsystem: 161f:2027
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at d0009000 (32-bit, non-prefetchable)
	Region 1: I/O ports at 8800 [size%6]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot+,D3col=
d+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:0a.0 Class 0607: 104c:ac41 (rev 02)
	Subsystem: 161f:2029
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 168, Cache Line Size 20
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at ffbfe000 (32-bit, non-prefetchable)
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: ffbfd000-ffbfd000 (prefetchable)
	Memory window 1: fbbfd000-ffbfc000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:0a.1 Class 0c00: 104c:8017 (rev 02) (prog-if 10)
	Subsystem: 161f:2029
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at d000c000 (32-bit, non-prefetchable)
	Region 1: Memory at d0000000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 1
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2+,D3hot+,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:0c.0 Class 0280: 14e4:4320 (rev 02)
	Subsystem: 144f:7050
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at d0004000 (32-bit, non-prefetchable)
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent75mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D2 PME-

00:0d.0 Class 0c03: 1033:0035 (rev 43) (prog-if 10)
	Subsystem: 161f:2029
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64 (250ns min, 10500ns max), Cache Line Size 10
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at d000a000 (32-bit, non-prefetchable)
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2+,D3hot+,D3col=
d+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:0d.1 Class 0c03: 1033:0035 (rev 43) (prog-if 10)
	Subsystem: 161f:2029
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64 (250ns min, 10500ns max), Cache Line Size 10
	Interrupt: pin B routed to IRQ 11
	Region 0: Memory at d000b000 (32-bit, non-prefetchable)
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2+,D3hot+,D3col=
d+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:0d.2 Class 0c03: 1033:00e0 (rev 04) (prog-if 20)
	Subsystem: 161f:2029
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 132 (4000ns min, 8500ns max), Cache Line Size 10
	Interrupt: pin C routed to IRQ 11
	Region 0: Memory at d000c800 (32-bit, non-prefetchable)
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2+,D3hot+,D3col=
d+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:0e.0 Class 0200: 14e4:4401 (rev 01)
	Subsystem: 161f:2029
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort+ <TAbort- <M=
Abort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at d0006000 (32-bit, non-prefetchable)
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent75mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D2 PME-

00:10.0 Class 0101: 10b9:5229 (rev c4) (prog-if fa)
	Subsystem: 161f:2029
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 0 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 0
	Region 4: I/O ports at 8080 [size=16]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:11.0 Class 0680: 10b9:7101
	Subsystem: 161f:2029
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-

01:05.0 Class 0300: 1002:4336
	Subsystem: 161f:2029
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng+ SERR- FastB2B+
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min), Cache Line Size 10
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at e0000000 (32-bit, prefetchable)
	Region 1: I/O ports at 9000 [size%6]
	Region 2: Memory at d0100000 (32-bit, non-prefetchable) [sizedK]
	Capabilities: [58] AGP version 2.0
		Status: RQH Iso- ArqSz=3D0 Cal=3D0 SBA+ ITACoh- GART64- HTrans- 64bit- FW=
- AGP3- Rate=3Dx1,x2,x4
		Command: RQ=3D1 ArqSz=3D0 Cal=3D0 SBA+ AGP- GART64- 64bit- FW- Rate=3D<no=
ne>
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

PCI devices found:
  Bus  0, device   0, function  0:
    Class 0600: PCI device 1002:cab0 (rev 19).
      Master Capable.  Latencyd. =20
      Prefetchable 32 bit memory at 0xd4000000 [0xd7ffffff].
      Prefetchable 32 bit memory at 0xd0400000 [0xd0400fff].
      I/O at 0x8090 [0x8093].
  Bus  0, device   1, function  0:
    Class 0604: PCI device 1002:700f (rev 1).
      Master Capable.  Latency=99.  Min Gnt=12.
  Bus  0, device   7, function  0:
    Class 0601: PCI device 10b9:1533 (rev 0).
  Bus  0, device   8, function  0:
    Class 0401: PCI device 10b9:5451 (rev 2).
      IRQ 11.
      Master Capable.  Latencyd.  Min Gnt=3D2.Max Lat$.
      I/O at 0x8400 [0x84ff].
      Non-prefetchable 32 bit memory at 0xd0008000 [0xd0008fff].
  Bus  0, device   9, function  0:
    Class 0703: PCI device 10b9:5457 (rev 0).
      IRQ 5.
      Master Capable.  Latencyd. =20
      Non-prefetchable 32 bit memory at 0xd0009000 [0xd0009fff].
      I/O at 0x8800 [0x88ff].
  Bus  0, device  10, function  0:
    Class 0607: PCI device 104c:ac41 (rev 2).
      IRQ 10.
      Master Capable.  Latency=168.  Min Gnt=192.Max Lat=3D5.
      Non-prefetchable 32 bit memory at 0xffbfe000 [0xffbfefff].
  Bus  0, device  10, function  1:
    Class 0c00: PCI device 104c:8017 (rev 2).
      IRQ 10.
      Master Capable.  Latencyd.  Min Gnt=3D3.Max Lat=3D4.
      Non-prefetchable 32 bit memory at 0xd000c000 [0xd000c7ff].
      Non-prefetchable 32 bit memory at 0xd0000000 [0xd0003fff].
  Bus  0, device  12, function  0:
    Class 0280: PCI device 14e4:4320 (rev 2).
      IRQ 10.
      Master Capable.  Latencyd. =20
      Non-prefetchable 32 bit memory at 0xd0004000 [0xd0005fff].
  Bus  0, device  13, function  0:
    Class 0c03: PCI device 1033:0035 (rev 67).
      IRQ 11.
      Master Capable.  Latencyd.  Min Gnt=3D1.Max LatB.
      Non-prefetchable 32 bit memory at 0xd000a000 [0xd000afff].
  Bus  0, device  13, function  1:
    Class 0c03: PCI device 1033:0035 (rev 67).
      IRQ 11.
      Master Capable.  Latencyd.  Min Gnt=3D1.Max LatB.
      Non-prefetchable 32 bit memory at 0xd000b000 [0xd000bfff].
  Bus  0, device  13, function  2:
    Class 0c03: PCI device 1033:00e0 (rev 4).
      IRQ 11.
      Master Capable.  Latency=132.  Min Gnt=16.Max Lat4.
      Non-prefetchable 32 bit memory at 0xd000c800 [0xd000c8ff].
  Bus  0, device  14, function  0:
    Class 0200: PCI device 14e4:4401 (rev 1).
      IRQ 11.
      Master Capable.  Latencyd. =20
      Non-prefetchable 32 bit memory at 0xd0006000 [0xd0007fff].
  Bus  0, device  16, function  0:
    Class 0101: PCI device 10b9:5229 (rev 196).
      Master Capable.  No bursts.  Min Gnt=3D2.Max Lat=3D4.
      I/O at 0x8080 [0x808f].
  Bus  0, device  17, function  0:
    Class 0680: PCI device 10b9:7101 (rev 0).
  Bus  1, device   5, function  0:
    Class 0300: PCI device 1002:4336 (rev 0).
      IRQ 10.
      Master Capable.  Latencyf.  Min Gnt=3D8.
      Prefetchable 32 bit memory at 0xe0000000 [0xefffffff].
      I/O at 0x9000 [0x90ff].
      Non-prefetchable 32 bit memory at 0xd0100000 [0xd010ffff].
ro root=3DLABEL=3D/ resume=3D/dev/hda3 vga=3D0x318 rhgb quiet selinux=3D0
1339.97 1179.05
Character devices:
  1 mem
  4 /dev/vc/0
  4 tty
  4 ttyS
  5 /dev/tty
  5 /dev/console
  5 /dev/ptmx
  6 lp
  7 vcs
 10 misc
 13 input
 14 sound
 21 sg
 29 fb
 36 netlink
116 alsa
128 ptm
136 pts
180 usb
254 pcmcia

Block devices:
  1 ramdisk
  3 ide0
  9 md
 22 ide1
253 device-mapper
254 mdp
  0 ndiswrapper
 63 device-mapper
175 agpgart
135 rtc
nodev	sysfs
nodev	rootfs
nodev	bdev
nodev	proc
nodev	sockfs
nodev	usbfs
nodev	usbdevfs
nodev	futexfs
nodev	tmpfs
nodev	pipefs
nodev	eventpollfs
nodev	devpts
	ext2
nodev	ramfs
nodev	hugetlbfs
	iso9660
nodev	mqueue
	ext3
nodev	rpc_pipefs
nodev	autofs
	vfat
           CPU0      =20
  0:    1332647          XT-PIC  timer
  1:       2700          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  8:          1          XT-PIC  rtc
  9:        243          XT-PIC  acpi
 10:      27121          XT-PIC  ndiswrapper, yenta
 11:         12          XT-PIC  ehci_hcd, ohci_hcd, ohci_hcd, ALI 5451
 12:     171810          XT-PIC  i8042
 14:      16208          XT-PIC  ide0
 15:        460          XT-PIC  ide1
NMI:          0=20
ERR:          1
00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cdfff : Video ROM
000f0000-000fffff : System ROM
00100000-1beeffff : System RAM
  00100000-00275fff : Kernel code
  00276000-0030cbff : Kernel data
1bef0000-1befefff : ACPI Tables
1beff000-1befffff : ACPI Non-volatile Storage
1bf00000-1bffffff : System RAM
d0000000-d0003fff : 0000:00:0a.1
d0004000-d0005fff : 0000:00:0c.0
  d0004000-d0005fff : bcmwl5.sys
d0006000-d0007fff : 0000:00:0e.0
  d0006000-d0007fff : b44
d0008000-d0008fff : 0000:00:08.0
d0009000-d0009fff : 0000:00:09.0
d000a000-d000afff : 0000:00:0d.0
  d000a000-d000afff : ohci_hcd
d000b000-d000bfff : 0000:00:0d.1
  d000b000-d000bfff : ohci_hcd
d000c000-d000c7ff : 0000:00:0a.1
d000c800-d000c8ff : 0000:00:0d.2
  d000c800-d000c8ff : ehci_hcd
d0100000-d01fffff : PCI Bus #01
  d0100000-d010ffff : 0000:01:05.0
d0400000-d0400fff : 0000:00:00.0
d4000000-d7ffffff : 0000:00:00.0
e0000000-efffffff : PCI Bus #01
  e0000000-efffffff : 0000:01:05.0
    e0000000-e0ffffff : vesafb
fbbfd000-ffbfcfff : PCI CardBus #02
ffbfd000-ffbfdfff : PCI CardBus #02
ffbfe000-ffbfefff : 0000:00:0a.0
  ffbfe000-ffbfefff : yenta_socket
fff80000-ffffffff : reserved
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
0378-037a : parport0
03b0-03bb : RadeonIGP
03c0-03df : vesafb
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
4000-40ff : PCI CardBus #02
4400-44ff : PCI CardBus #02
8000-803f : 0000:00:11.0
8040-805f : 0000:00:11.0
8080-808f : 0000:00:10.0
  8080-8087 : ide0
  8088-808f : ide1
8090-8093 : 0000:00:00.0
8400-84ff : 0000:00:08.0
  8400-84ff : ALI 5451
8800-88ff : 0000:00:09.0
  8828-882f : serial
  8840-8847 : serial
  8850-8857 : serial
  8860-8867 : serial
  8870-8877 : serial
9000-9fff : PCI Bus #01
  9000-90ff : 0000:01:05.0
 4: cascade
major minor  #blocks  name

   3     0   39070080 hda
   3     1   15470563 hda1
   3     2   17967600 hda2
   3     3    1535688 hda3
   3     4          1 hda4
   3     5    4095976 hda5
rootfs / rootfs rw 0 0
/dev/root.old /initrd ext2 rw 0 0
/dev/root / ext3 rw 0 0
/proc /proc proc rw 0 0
/sys /sys sysfs rw 0 0
none /dev/pts devpts rw 0 0
usbdevfs /proc/bus/usb usbdevfs rw 0 0
none /dev/shm tmpfs rw 0 0
sunrpc /var/lib/nfs/rpc_pipefs rpc_pipefs rw 0 0
/dev/hda5 /mnt/aux vfat rw,nodiratime,nosuid,nodev,noexec,uidP0,gidP0,fmask=
=0022,dmask=0022,codepage=3Dcp437 0 0
Filename				Type		Size	Used	Priority
/dev/hda3                               partition	1535680	0	-1
MemTotal:       452280 kB
MemFree:          5840 kB
Buffers:         31460 kB
Cached:         237912 kB
SwapCached:          0 kB
Active:         199740 kB
Inactive:       194648 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       452280 kB
LowFree:          5840 kB
SwapTotal:     1535680 kB
SwapFree:      1535680 kB
Dirty:             208 kB
Writeback:           0 kB
Mapped:         182808 kB
Slab:            43196 kB
Committed_AS:   398884 kB
PageTables:       2788 kB
VmallocTotal:  3678200 kB
VmallocUsed:     19140 kB
VmallocChunk:  3658988 kB
HugePages_Total:     0
HugePages_Free:      0
Hugepagesize:     4096 kB
cpu  9854 170 5282 107798 9872 289 0
cpu0 9854 170 5282 107798 9872 289 0
intr 1551243 1332681 2700 0 1 1 1 1 3 1 243 27121 12 171810 0 16208 460
ctxt 517379
btime 1082875553
processes 2750
procs_running 2
procs_blocked 0
nls_utf8 1792 1 - Live 0x1fa70000
nls_cp437 5632 1 - Live 0x1fa73000
vfat 10880 1 - Live 0x1fa3f000
fat 33856 1 vfat, Live 0x1fab9000
snd_mixer_oss 13952 3 - Live 0x1fa89000
snd_ali5451 17092 4 - Live 0x1fa83000
snd_ac97_codec 50820 1 snd_ali5451, Live 0x1faab000
snd_pcm 69256 1 snd_ali5451, Live 0x1fa99000
snd_page_alloc 8196 1 snd_pcm, Live 0x1fa43000
snd_timer 17412 1 snd_pcm, Live 0x1fa6a000
snd 38884 7 snd_mixer_oss,snd_ali5451,snd_ac97_codec,snd_pcm,snd_timer, Liv=
e 0x1fa78000
soundcore 6368 4 snd, Live 0x1f84a000
parport_pc 19648 1 - Live 0x1f9c9000
lp 8364 0 - Live 0x1fa3b000
parport 30024 2 parport_pc,lp, Live 0x1fa61000
autofs4 11008 0 - Live 0x1f9d5000
ds 12420 2 - Live 0x1fa36000
yenta_socket 15360 0 - Live 0x1f9d0000
pcmcia_core 47944 2 ds,yenta_socket, Live 0x1fa29000
sunrpc 102216 1 - Live 0x1fa47000
ndiswrapper 58240 0 - Live 0x1f9d9000
b44 16004 0 - Live 0x1f8bb000
ipt_REJECT 4864 1 - Live 0x1f9c3000
ipt_state 1664 1 - Live 0x1f891000
ip_conntrack 24112 1 ipt_state, Live 0x1f9bc000
iptable_filter 2304 1 - Live 0x1f865000
ip_tables 13696 3 ipt_REJECT,ipt_state,iptable_filter, Live 0x1f895000
sg 27808 0 - Live 0x1f9ab000
scsi_mod 92112 1 sg, Live 0x1f8a3000
dm_mod 32672 0 - Live 0x1f89a000
ohci_hcd 15004 0 - Live 0x1f88a000
ehci_hcd 21896 0 - Live 0x1f869000
button 4760 0 - Live 0x1f858000
battery 7052 0 - Live 0x1f845000
asus_acpi 8728 0 - Live 0x1f85d000
ac 3468 0 - Live 0x1f848000
ipv6 183648 10 - Live 0x1f8c0000
ext3 89000 1 - Live 0x1f873000
jbd 40472 1 ext3, Live 0x1f84d000
module-init-tools version 3.0-pre10
include /etc/modprobe.conf.dist
#
## NETWORK CARDS ETHERNET & WIRELESS
#
alias eth0 b44
alias wlan0 ndiswrapper
#
## USB & FIREWIRE
#
alias usb-controller ehci-hcd
alias usb-controller1 ohci-hcd
alias ieee1394-controller ohci1394
#
## SOUND_CARD
#
alias sound-slot-0 snd-ali5451
install snd-ali5451 /sbin/modprobe --ignore-install snd-ali5451 && /usr/sbi=
n/alsactl restore >/dev/null 2>&1 || :
remove snd-ali5451 { /usr/sbin/alsactl store >/dev/null 2>&1 || : ; }; /sbi=
n/modprobe -r --ignore-remove snd-ali5451

/dev/tty             /dev/tty        5       0 system:/dev/tty
/dev/console         /dev/console    5       1 system:console
/dev/ptmx            /dev/ptmx       5       2 system
/dev/vc/0            /dev/vc/0       4       0 system:vtmaster
serial               /dev/ttyS       4   64-71 serial
pty_slave            /dev/pts      136 0-1048575 pty:slave
pty_master           /dev/ptm      128 0-1048575 pty:master
unknown              /dev/tty        4    1-63 console
serinfo:1.0 driver revision:
0: uart:8250 port:00008828 irq:5 tx:0 rx:0
1: uart:8250 port:00008840 irq:5 tx:0 rx:0
2: uart:8250 port:00008850 irq:5 tx:0 rx:0
3: uart:8250 port:00008860 irq:5 tx:0 rx:0
4: uart:8250 port:00008870 irq:5 tx:0 rx:0
5: uart:unknown port:000088F8 irq:5
6: uart:unknown port:00008810 irq:5
7: uart:unknown port:00008818 irq:5
Linux version 2.6.5-1.327custom (root@eagleone.eagles.net) (gcc version 3.3=
.3 20040412 (Red Hat Linux 3.3.3-7)) #2 Thu Apr 22 22:25:45 CDT 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ce000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001bef0000 (usable)
 BIOS-e820: 000000001bef0000 - 000000001beff000 (ACPI data)
 BIOS-e820: 000000001beff000 - 000000001bf00000 (ACPI NVS)
 BIOS-e820: 000000001bf00000 - 000000001c000000 (usable)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
448MB LOWMEM available.
zapping low mappings.
On node 0 totalpages: 114688
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 110592 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 ARIMA                                     ) @ 0x000f7680
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x1befae80
ACPI: FADT (v001 ARIMA  W720-K7  0x06040000 PTL_ 0x000f4240) @ 0x1befee53
ACPI: SSDT (v001 PTLTD  POWERNOW 0x06040000  LTP 0x00000001) @ 0x1befeec7
ACPI: DSDT (v001 ARIMA  W720-K7  0x06040000 MSFT 0x0100000d) @ 0x00000000
ACPI: PM-Timer IO Port: 0x8008
Built 1 zonelists
Kernel command line: ro root=3DLABEL=3D/ resume=3D/dev/hda3 vga=3D0x318 rhg=
b quiet selinux=3D0
mapped 4G/4G trampoline to ffff3000.
Initializing CPU#0
CPU 0 irqstacks, hard=0233c000 soft=0233b000
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1789.346 MHz processor.
Using pmtmr for high-res timesource
Console: colour dummy device 80x25
Memory: 451564k/458752k available (1496k kernel code, 6348k reserved, 603k =
data, 148k init, 0k highmem)
Calibrating delay loop... 3555.32 BogoMIPS
Security Scaffold v1.0.0 initialized
Capability LSM initialized
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
checking if image is initramfs...it isn't (no cpio magic); looks like an in=
itrd
Freeing initrd memory: 179k freed
CPU:     After generic identify, caps: 0383f9ff c1cbf9ff 00000000 00000000
CPU:     After vendor identify, caps: 0383f9ff c1cbf9ff 00000000 00000000
CPU: CLK_CTL MSR was 60071263. Reprogramming to 20071263
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU:     After all inits, caps: 0383f9ff c1cbf9ff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Mobile AMD Athlon(tm) XP 2400+ stepping 00
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd88e, last bus=3D1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
    ACPI-0291: *** Info: Table [DSDT] replaced by host OS
ACPI: IRQ9 SCI: Edge set to Level Trigger.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 6 7 10 11 12)
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 10 *11 12)
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 *10 11 12)
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 10 *11 12)
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 7 10 11 12)
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 10 11 12)
ACPI: PCI Interrupt Link [LNK6] (IRQs 3 4 *5 6 7 10 11 12)
ACPI: PCI Interrupt Link [LNK7] (IRQs 3 4 5 6 7 10 *11 12)
ACPI: PCI Interrupt Link [LNK8] (IRQs 3 4 5 6 7 10 11 12)
ACPI: Embedded Controller [EC] (gpe 24)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ACPI: PCI Interrupt Link [LNK7] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNK6] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNK2] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNK3] enabled at IRQ 11
ACPI: No IRQ known for interrupt pin A of device 0000:00:10.0
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=3Dnoacpi' or even 'a=
cpi=3Doff'
vesafb: framebuffer at 0xe0000000, mapped to 0x1e808000, size 16384k
vesafb: mode is 1024x768x24, linelength072, pages'
vesafb: protected mode interface info at c000:50f9
vesafb: scrolling: redraw
vesafb: directcolor: size=3D0:8:8:8, shift=3D0:16:8:0
fb0: VESA VGA frame buffer device
powernow: PowerNOW! Technology present. Can scale: frequency and voltage.
powernow: Found PSB header at 020f0c70
powernow: Table version: 0x12
powernow: Flags: 0x0 (Mobile voltage regulator)
powernow: Settling Time: 100 microseconds.
powernow: Has 43 PST tables. (Only dumping ones relevant to this CPU).
powernow: PST:30 (@020f0e7c)
powernow:  cpuid: 0x781	fsb: 133	maxFID: 0x15	startvid: 0xb
powernow:    FID: 0x12 (4.0x [532MHz])	VID: 0x19 (1.050V)
powernow:    FID: 0x4 (5.0x [665MHz])	VID: 0x19 (1.050V)
powernow:    FID: 0x6 (6.0x [798MHz])	VID: 0x19 (1.050V)
powernow:    FID: 0x8 (7.0x [931MHz])	VID: 0x19 (1.050V)
powernow:    FID: 0xe (10.0x [1330MHz])	VID: 0xe (1.300V)
powernow:    FID: 0x15 (13.5x [1795MHz])	VID: 0xb (1.450V)

powernow: Minimum speed 532 MHz. Maximum speed 1795 MHz.
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
audit: initializing netlink socket (disabled)
audit(1082853953.545:0): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Initializing Cryptographic API
ATI Northbridge, reserving I/O ports 0x3b0 to 0x3bb.
Activating ISA DMA hang workarounds.
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI: Processor [CPU0] (supports C1 C2)
ACPI: Thermal Zone [THRM] (59 C)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Console: switching to colour frame buffer device 128x48
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected Ati IGP320/M chipset
agpgart: Maximum main memory to use for agp memory: 381M
agpgart: AGP aperture is 64M @ 0xd4000000
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x8828 (irq =3D 5) is a 8250
ttyS1 at I/O 0x8840 (irq =3D 5) is a 8250
ttyS2 at I/O 0x8850 (irq =3D 5) is a 8250
ttyS3 at I/O 0x8860 (irq =3D 5) is a 8250
ttyS4 at I/O 0x8870 (irq =3D 5) is a 8250
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
divert: not allocating divert_blk for non-ethernet device lo
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
Warning: ATI Radeon IGP Northbridge is not yet fully tested.
ALI15X3: IDE controller at PCI slot 0000:00:10.0
ACPI: No IRQ known for interrupt pin A of device 0000:00:10.0
ALI15X3: chipset revision 196
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x8080-0x8087, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x8088-0x808f, BIOS settings: hdc:DMA, hdd:pio
hda: FUJITSU MHT2040AT, ATA DISK drive
Using cfq io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: TOSHIBA DVD-ROM SD-R2312, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 78140160 sectors (40007 MB) w/2048KiB Cache, CHSe535/16/63, UDMA(100)
 hda: hda1 hda2 hda3 hda4 < hda5 >
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
usbcore: registered new driver hiddev
usbcore: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
synaptics reset failed
synaptics reset failed
synaptics reset failed
Synaptics Touchpad, model: 1
 Firmware: 5.8
 Sensor: 35
 new absolute packet format
 Touchpad has extended capability bits
 -> multifinger detection
 -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
md: md driver 0.90.0 MAX_MD_DEVS%6, MD_SB_DISKS'
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
Resume Machine: resuming from /dev/hda3
Resuming from device hda3
Resume Machine: This is normal swap space
PM: Reading pmdisk image.
PM: Resume from disk failed.
ACPI: (supports S0 S3 S4 S5)
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 148k freed
NET: Registered protocol family 10
Disabled Privacy Extensions on device 022d2020(lo)
IPv6 over IPv4 tunneling driver
divert: not allocating divert_blk for non-ethernet device sit0
mtrr: 0xe0000000,0x4000000 overlaps existing 0xe0000000,0x1000000
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (FF) [SLPF]
ACPI: Lid Switch [LID]
ehci_hcd 0000:00:0d.2: EHCI Host Controller
ehci_hcd 0000:00:0d.2: irq 11, pci mem 1f85b800
ehci_hcd 0000:00:0d.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:0d.2: USB 2.0 enabled, EHCI 1.00, driver 2003-Dec-29
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 5 ports detected
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
ohci_hcd 0000:00:0d.0: OHCI Host Controller
ohci_hcd 0000:00:0d.0: irq 11, pci mem 1f861000
ohci_hcd 0000:00:0d.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
ohci_hcd 0000:00:0d.1: OHCI Host Controller
ohci_hcd 0000:00:0d.1: irq 11, pci mem 1f863000
ohci_hcd 0000:00:0d.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
EXT3 FS on hda2, internal journal
device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
hdc: packet command error: status=3D0x51 { DriveReady SeekComplete Error }
hdc: packet command error: error=3D0x50
ATAPI device hdc:
  Error: Illegal request -- (Sense key=3D0x05)
  Invalid field in command packet -- (asc=3D0x24, ascq=3D0x00)
  The failed "Start/Stop Unit" packet command was:=20
  "1b 00 00 00 03 00 00 00 00 00 00 00 00 00 00 00 "
  Error in command packet byte 4 bit 0
cdrom: open failed.
Adding 1535680k swap on /dev/hda3.  Priority:-1 extents:1
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
SCSI subsystem initialized
b44.c:v0.93 (Mar, 2004)
divert: allocating divert_blk for eth0
eth0: Broadcom 4400 10/100BaseT Ethernet 00:03:25:08:af:22
divert: freeing divert_blk for eth0
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (3584 buckets, 28672 max) - 296 bytes per conntrack
b44.c:v0.93 (Mar, 2004)
divert: allocating divert_blk for eth0
eth0: Broadcom 4400 10/100BaseT Ethernet 00:03:25:08:af:22
ndiswrapper version 0.6+CVS loaded
ndiswrapper adding bcmwl5.sys
divert: allocating divert_blk for wlan0
wlan0: ndiswrapper ethernet device 00:90:96:61:f4:ee using driver bcmwl5.sys
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
Yenta: CardBus bridge found at 0000:00:0a.0 [161f:2029]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:0a.0, mfunc 0x01001c00, devctl 0x64
Yenta: ISA IRQ mask 0x00f8, PCI irq 10
Socket status: 30000006
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x200-0x207 0x378-0x37f 0x408-0x=
40f 0x480-0x48f 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
wlan0: no IPv6 routers present
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
lp0: using parport0 (polling).
lp0: console ready
mtrr: 0xe0000000,0x4000000 overlaps existing 0xe0000000,0x1000000
spurious 8259A interrupt: IRQ7.
