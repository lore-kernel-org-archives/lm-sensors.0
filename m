From: frodol@dds.nl (frodol@dds.nl)
Date: Thu, 19 May 2005 06:23:31 +0000
Subject: Feedback (fwd)
Message-Id: <200203231220.g2NCKQD01021@shire.frodo.local>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Pepe Herrera wrote:
From ppherrera@supercable.es Sat Mar 23 11:25:04 2002
Received: by morannon.frodo.local (8.11.3/8.11.3) id g2NAP4d05095 ; Sat, 23 Mar 2002 11:25:04 +0100
Return-Path: <ppherrera@supercable.es>
Received: from pop3.dds.nl [213.196.1.121]
	by localhost with POP3 (fetchmail-5.4.4)
	for frodo@localhost (single-drop); Sat, 23 Mar 2002 11:25:04 +0100 (CET)
Received: (qmail 4819 invoked from network); 23 Mar 2002 10:07:07 -0000
Received: from unknown (HELO smtp.supercable.es) ([212.79.128.148]) (envelope-sender <ppherrera@supercable.es>)
          by arkanoid.cybercomm.nl (qmail-ldap-1.03) with SMTP
          for <frodol@dds.nl>; 23 Mar 2002 10:07:07 -0000
Received: from there (cliente-217216147132.cm128.conpb.supercable.es [217.216.147.132])
	by smtp.supercable.es (Switch-2.0.1/Switch-2.0.1) with SMTP id g2NA83Y12582
	for <frodol@dds.nl>; Sat, 23 Mar 2002 11:08:03 +0100 (MET)
Message-Id: <200203231008.g2NA83Y12582@smtp.supercable.es>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Pepe Herrera <ppherrera@supercable.es>
Reply-To: ppherrera@supercable.es
To: frodol@dds.nl
Subject: Feedback
Date: Sat, 23 Mar 2002 11:20:28 +0100
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Frodo:
I don't speak english well, and this e-mail can be telegraphic. I hope you 
understand me:
I have a problem, in the system logs I read:
 kernel: i2c-amd756.o: SMBus collision!
 kernel: i2c-amd756.o: Busy wait timeout! (0800)
and them 
I have a 7IX mother board and a AMD Athlon processor 500 Mhz
When the problem occurs a have run Gkrellm whit the sensors running.
The kernel version is linux-2.4.18, and the driver is instaled in 
/usr/src/linux-2.4.18/drivers/i2c/i2c-amd756.o

After this problem occurs, i see:
# lsmod
Module                  Size  Used by
agpgart                29696   3  (autoclean)
NVdriver              946400  10  (autoclean)
i2c-amd756              3248   0  (unused)
w83781d                17424   1
i2c-dev                 3616   0  (unused)
eeprom                  3072   0
i2c-proc                6256   1  [w83781d eeprom]
i2c-core               13248   0  [i2c-amd756 w83781d i2c-dev eeprom i2c-proc]
es1371                 25920   3
ac97_codec              9376   0  [es1371]
lp                      6080   0
parport_pc             14672   2
parport                24736   2  [lp parport_pc]
ipchains               41280   4
8139too                13264   1  (autoclean)
mii                     1072   0  (autoclean) [8139too]
ide-cd                 26496   0
cdrom                  27488   0  [ide-cd]
ide-scsi                7664   0

You can help me? You need some data more?

Thanks.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8nFb1zh9wrXFT3+URAuXKAKCKJYMi9v/RhXQTNNZKi3Zneo2rCgCeKeLB
wtVanZL51SPscwvyjnLh68s=UsrF
-----END PGP SIGNATURE-----


-- 
Frodo Looijaard <frodol@dds.nl>  PGP key and more: http://huizen.dds.nl/~frodol
Defenestration n. (formal or joc.):
  The act of removing Windows from your computer in disgust, usually followed
  by the installation of Linux or some other Unix-like operating system.
