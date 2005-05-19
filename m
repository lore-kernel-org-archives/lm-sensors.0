From: frodol@dds.nl (Frodo Looijaard)
Date: Thu, 19 May 2005 06:23:47 +0000
Subject: driver `bt869.o' request for support (fwd)
Message-Id: <200302130653.h1D6rNW09420@morannon.frodo.local>
List-Id: <lm-sensors.vger.kernel.org>
References: <200302130653.h1D6rGK09411@morannon.frodo.local>
In-Reply-To: <200302130653.h1D6rGK09411@morannon.frodo.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Carlo Gebhardt wrote:
From carlo.gebhardt@xinux.de Thu Feb 13 01:10:04 2003
Received: by morannon.frodo.local (8.11.3/8.11.3) id h1D0A3n01975 ; Thu, 13=
 Feb 2003 01:10:04 +0100
Return-Path: <carlo.gebhardt@xinux.de>
Received: from pop3.dds.nl [213.196.1.204]
	by localhost with POP3 (fetchmail-6.2.0)
	for frodo@localhost (single-drop); Thu, 13 Feb 2003 01:10:04 +0100 (CET)
Received: (qmail-ldap/ctrl 10602 invoked from network); 13 Feb 2003 00:01:0=
4 -0000
Received: from mailout01.sul.t-online.com ([194.25.134.80]) (envelope-sende=
r <carlo.gebhardt@xinux.de>)
          by dds.nl (qmail-ldap-1.03) with SMTP
          for <frodol@dds.nl>; 13 Feb 2003 00:01:04 -0000
Received: from fwd09.sul.t-online.de=20
	by mailout01.sul.t-online.com with smtp=20
	id 18j6oI-0000gS-04; Thu, 13 Feb 2003 01:01:02 +0100
Received: from xinux.de (068412214-0001@[80.138.249.116]) by fmrl09.sul.t-o=
nline.com
	with esmtp id 18j6oC-1eY8psC; Thu, 13 Feb 2003 01:00:56 +0100
Message-ID: <3E4AE082.6020603@xinux.de>
Date: Thu, 13 Feb 2003 01:02:10 +0100
From: Carlo Gebhardt <carlo.gebhardt@xinux.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/2002062=
3 Debian/1.0.0-0.woody.1
MIME-Version: 1.0
To: frodol@dds.nl, phil@netroedge.com, rjkm@thp.uni-koeln.de,
   steve@daviesfam.org
Subject: driver `bt869.o' request for support
Content-Type: text/plain; charset=3DISO-8859-15; format=3Dflowed
Content-Transfer-Encoding: 7bit
X-Sender: 068412214-0001@t-dialin.net
X-Loop-Procmail: PreventLoop

Hello,

I have a problem using the bt869 module with my voodoo3 3500 and tv-out.

insmod the modules
Using /lib/modules/2.4.20/kernel/drivers/i2c/i2c-voodoo3.o
i2c-voodoo3.o version 2.7.0 (20021208)
i2c-voodoo3: Using Banshee/Voodoo3 at 0xe8861000
i2c-voodoo3: 1 Banshee/Voodoo3 found.
i2c-voodoo3.o: I2C bus initialized
i2c-voodoo3.o: DDC bus initialized
Using /lib/modules/2.4.20/kernel/drivers/sensors/bt869.o
bt869.o version 2.7.0 (20021208)
bt869.o:  probing address 68 .
bt869.o: address 0x44 testing-->0x22
bt869.o: BT869 detected
bt869.o: write_value(0xBA, 0x80)
bt869.o: write_value(0xA0, 0x80)
bt869.o: write_value(0xBA, 0x20)
bt869.o: write_value(0xC6, 0x1)
bt869.o: write_value(0xC4, 0x1)
bt869.o: write_value(0xC8, 0x0)
----------------
here i can see my console on the tv but it looks bizzar.
i guess its an NTSC-signal
but changing the proc-values leads to an black tv
ether no signal or something else
even cat'ing the values leads to an bt869 update and a black screen
i have tried changing the default values in the drivers to my fits but i=20
didnt' work.
unloading the driver und reloading it brings me back to the console to=20
the tv which looks bizzar.


changing values
Nebuchadnezzar:~# echo "0" >/proc/sys/dev/sensors/bt869-i2c-0-44/ntsc
Starting bt869 update
bt869.o: write_value(0xB8, 0x1)
bt869.o: write_value(0xA0, 0x8C)
bt869.o: writing into config -->0x1
bt869.o: write_value(0xC6, 0x1)
bt869.o: write_value(0xD4, 0x0)
bt869.o: write_value(0xCE, 0x0)
bt869.o: write_value(0xBA, 0x21)
bt869.o: write_value(0xC4, 0x1)
bt869.o: write_value(0x6C, 0x80)
bt869.o: write_value(0xC4, 0x1)
bt869.o: write_value(0xC4, 0x41)
bt869.o: write_value(0xC4, 0x81)
bt869.o: write_value(0xC4, 0xC1)

--------------------


Nebuchadnezzar:~# lsmod
Module                  Size  Used by    Not tainted
ddcmon                  3116   0  (unused)
eeprom                  3536   0  (unused)
i2c-isa                 1228   0  (unused)
i2c-viapro              3892   0  (unused)
i2c-voodoo3             2576   0  (unused)
i2c-algo-bit            8264   2  [i2c-voodoo3]
bt869                   5444   0  (unused)
i2c-proc                6480   0  [ddcmon eeprom bt869]
i2c-core               14544   0  [ddcmon eeprom i2c-isa i2c-viapro=20
i2c-algo-bit bt869 i2c-proc]
------------------








lspci -vv
01:00.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 3 (rev=20
01) (prog-if 00 [VGA])
Subsystem: 3Dfx Interactive, Inc. Voodoo3 3500 TV (PAL)
Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-=20
Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort- <TAbort-=20
<MAbort- >SERR- <PERR+
Interrupt: pin A routed to IRQ 7
Region 0: Memory at d4000000 (32-bit, non-prefetchable) [size2M]
Region 1: Memory at d8000000 (32-bit, prefetchable) [size2M]
        Region 2: I/O ports at 8000 [size%6]
        Expansion ROM at <unassigned> [disabled] [sizedK]
        Capabilities: [54] AGP version 1.0
        Status: RQ=3D7 SBA+ 64bit+ FW- Rate=3Dx1,x2
        Command: RQ=3D0 SBA- AGP- 64bit- FW- Rate=3D<none>
       Capabilities: [60] Power Management version 1
        Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA=20
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-




--=20
Frodo Looijaard <frodol@dds.nl>  PGP key and more: http://huizen.dds.nl/~fr=
odol
Defenestration n. (formal or joc.):
  The act of removing Windows from your computer in disgust, usually follow=
ed
  by the installation of Linux or some other Unix-like operating system.
