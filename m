From: frodol@dds.nl (Frodo Looijaard)
Date: Thu, 19 May 2005 06:23:46 +0000
Subject: PII4X/Compaq ProLiant ML370 G2 server (fwd)
Message-Id: <200301281638.h0SGcEm25577@morannon.frodo.local>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Andreas Strodl wrote:
From andreas@strodl.org Tue Jan 28 17:37:37 2003
Received: by morannon.frodo.local (8.11.3/8.11.3) id h0SGbaq25556 ; Tue, 28 Jan 2003 17:37:37 +0100
Return-Path: <andreas@strodl.org>
Received: from pop3.dds.nl [213.196.1.204]
	by localhost with POP3 (fetchmail-6.2.0)
	for frodo@localhost (single-drop); Tue, 28 Jan 2003 17:37:37 +0100 (CET)
Received: (qmail-ldap/ctrl 17015 invoked from network); 28 Jan 2003 16:25:54 -0000
Received: from void.at (HELO moon.void.at) ([212.88.181.16]) (envelope-sender <andreas@strodl.org>)
          by dds.nl (qmail-ldap-1.03) with SMTP
          for <frodol@dds.nl>; 28 Jan 2003 16:25:54 -0000
Received: by moon.void.at (Postfix, from userid 1000)
	id 3890137E48; Tue, 28 Jan 2003 17:23:31 +0100 (CET)
Date: Tue, 28 Jan 2003 17:23:31 +0100
From: Andreas Strodl <andreas@strodl.org>
To: Frodo Looijaard <frodol@dds.nl>
Cc: Philip Edelbrock <phil@netroedge.com>
Subject: PII4X/Compaq ProLiant ML370 G2 server
Message-ID: <20030128162331.GA13253@moon.void.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Loop-Procmail: PreventLoop

Hi,

I'm trying to use lm_sensors package with your i2c-piix4 module.
Compile and everything works fine but when I insert the module
i get:

i2c-piix4.o: init_module: No such device
Hint: insmod errors can be caused by incorrect module parameters,
including invalid IO or IRQ parameters

dmesg says:
i2c-piix4.o: SMB base address uninitialized - upgrade BIOS or use
force_addr=0xaddr
i2c-piix4.o: Module insertion failed.

I've already search through google and found no solution.
Its a Compaq ProLiant ML370 G2 server. It seems ServerWorks
has been loaded correctly:

ServerWorks OSB4: IDE controller on PCI bus 00 dev 79
ServerWorks OSB4: chipset revision 0
ServerWorks OSB4: not 100% native mode: will probe irqs later

I've already updated to
Systems ROMPaq Firmware Upgrade Diskette for Compaq ProLiant ML370 G2
(P25) Servers version 4.04 A (5 Sep 02), but nothing hase changed.

sensor-detect also fails...
and I've tried latest cvs version too... ;)

any Ideas?

so long,
Andrew


-- 
Frodo Looijaard <frodol@dds.nl>  PGP key and more: http://huizen.dds.nl/~frodol
Defenestration n. (formal or joc.):
  The act of removing Windows from your computer in disgust, usually followed
  by the installation of Linux or some other Unix-like operating system.
