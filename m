From: frodol@dds.nl (frodol@dds.nl)
Date: Thu, 19 May 2005 06:23:42 +0000
Subject: i2c-801 (fwd)
Message-Id: <200211192101.gAJL1Vj03615@shire.frodo.local>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Szabolcs Barsony wrote:
From bvelvet@freemail.hu Tue Nov 19 21:10:05 2002
Received: by morannon.frodo.local (8.11.3/8.11.3) id gAJKA5W24450 ; Tue, 19 Nov 2002 21:10:05 +0100
Return-Path: <bvelvet@freemail.hu>
Received: from pop3.dds.nl [213.196.1.204]
	by localhost with POP3 (fetchmail-5.4.4)
	for frodo@localhost (single-drop); Tue, 19 Nov 2002 21:10:05 +0100 (CET)
Received: (qmail-ldap/ctrl 30842 invoked from network); 19 Nov 2002 20:08:25 -0000
Received: from demokritos.cytanet.com.cy ([195.14.133.252]) (envelope-sender <bvelvet@freemail.hu>)
          by dds.nl (qmail-ldap-1.03) with SMTP
          for <frodol@dds.nl>; 19 Nov 2002 20:08:25 -0000
Received: from localhost.localdomain (li-11-18.cytanet.com.cy [213.149.162.146])
	by demokritos.cytanet.com.cy (8.12.6/8.12.6) with ESMTP id gAJK8L6R025616
	for <frodol@dds.nl>; Tue, 19 Nov 2002 22:08:22 +0200 (EET)
Content-Type: text/plain;
  charset="us-ascii"
From: Szabolcs Barsony <bvelvet@freemail.hu>
Reply-To: bvelvet@freemail.hu
To: frodol@dds.nl
Subject: i2c-801
Date: Tue, 19 Nov 2002 22:07:45 +0000
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Message-Id: <200211192207.45043.bvelvet@freemail.hu>
X-Loop-Procmail: PreventLoop

Hi,

I have a notebook with the following devices. Is it supported by the lm_sensor 
package? If not is there any chance to be supported?

Best regards,
Szabolcs


00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge 
(rev 04)
00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge (rev 
04)
00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 42)
00:1f.0 ISA bridge: Intel Corp. 82801CAM ISA Bridge (LPC) (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801CAM IDE U100 (rev 02)
00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 Audio (rev 
02)

[szabolcs@localhost szabolcs]$ lspci -n
00:00.0 Class 0600: 8086:1a30 (rev 04)
00:01.0 Class 0604: 8086:1a31 (rev 04)
00:1e.0 Class 0604: 8086:2448 (rev 42)
00:1f.0 Class 0601: 8086:248c (rev 02)
00:1f.1 Class 0101: 8086:248a (rev 02)
00:1f.5 Class 0401: 8086:2485 (rev 02)

-- 
      .-.
     /v\    L   I   N   U   X
    // \\  >Phear the Penguin<
   /(   )\
    ^^-^^
___________________________________
Linux is like a wigwam. No gates, no windows just an apache inside.


-- 
Frodo Looijaard <frodol@dds.nl>  PGP key and more: http://huizen.dds.nl/~frodol
Defenestration n. (formal or joc.):
  The act of removing Windows from your computer in disgust, usually followed
  by the installation of Linux or some other Unix-like operating system.
