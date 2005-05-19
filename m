From: frodol@dds.nl (Frodo Looijaard)
Date: Thu, 19 May 2005 06:23:47 +0000
Subject: LM85 Sensor (fwd)
Message-Id: <200302121312.h1CDCCIM001515@shire.frodo.local>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

----- Forwarded message from Margit Schubert-While -----

Received: by morannon.frodo.local (8.11.3/8.11.3) id h1CDA4n21771 ; Wed, 12 Feb 2003 14:10:04 +0100
Return-path: <margitsw@t-online.de>
Received: from pop3.dds.nl [213.196.1.204]
	by localhost with POP3 (fetchmail-6.2.0)
	for frodo@localhost (single-drop); Wed, 12 Feb 2003 14:10:04 +0100 (CET)
Received: (qmail-ldap/ctrl 12534 invoked from network); 12 Feb 2003 13:00:54 -0000
Received: from mailout08.sul.t-online.com ([194.25.134.20]) (envelope-sender <margitsw@t-online.de>)
	         by dds.nl (qmail-ldap-1.03) with SMTP
	         for <frodol@dds.nl>; 12 Feb 2003 13:00:54 -0000
Received: from fwd05.sul.t-online.de 
	by mailout08.sul.t-online.com with smtp 
	id 18iwVR-0006h6-0A; Wed, 12 Feb 2003 14:00:53 +0100
Received: from margit.t-online.de (520024700093-0001@[217.226.114.124]) by fwd05.sul.t-online.com
	with esmtp id 18iwVE-1gTl6uC; Wed, 12 Feb 2003 14:00:40 +0100
Message-ID: <4.3.2.7.2.20030212135848.00b62490@mail.dns-host.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Wed, 12 Feb 2003 14:01:45 +0100
To: frodol@dds.nl
From: margitsw@t-online.de (Margit Schubert-While)
Subject: LM85 Sensor
cc: phil@netroedge.com
X-Sender: 520024700093-0001@t-dialin.net
X-Loop-Procmail: PreventLoop

Hi,
	I took a shot at the LM85 found on eg. Intel D845PE MB among
	others.
	At the moment, this is read-only, providing values for voltages,
	temps, fans, status in /proc/...

	There are "ifdefs" for the I2C ID and SYSCTL's, so doesn't rely
	on changes in the normal include files.
	"inttemp" is the LM85 temp.
	"proctemp" is the processor temp.
	"remtemp" is the temp at the edge of the keep-out zone.
	The rest are obvious.

	The 2V5 reading, at first glance, looks weird, however it is correct.
	The 845PESV has 1V5 here, although the scale muliplier is still 250.

	Register definitions are complete, based on the Nat Sem specs at :
	<http://www.national.com/pf/LM/LM85.html>^

	Cheers

	Margit

	lsmod :
Module                  Size  Used by    Not tainted
lm85                    5204   0  (unused)
i2c-proc                7120   0  [lm85]
i2c-dev                 4420   0  (unused)
i2c-i801                4756   0  (unused)
i2c-core               14856   0  [lm85 i2c-proc i2c-dev i2c-i801]

/proc/sys/dev/sensors # ls
	chips  lm85-i2c-0-2e

/proc/sys/dev/sensors/lm85-i2c-0-2e # ls
	12v  3v3  alarms   fan1  fan3  inttemp   remtemp
	2v5  5v   corevcc  fan2  fan4  proctemp  vccp

cat 12v
	0.00 15.93 12.00
cat 2v5
	0.00 3.32 1.49
cat 3v3
	0.00 4.38 3.24
cat 5v
	0.00 6.64 5.05
cat alarms
	0
cat corevcc
	1.500
cat fan1
	0 4112
cat fan2
	0 0
cat fan3
	0 1301
cat fan4
	0 1097
cat inttemp
	-127 127 32
cat proctemp
	-127 127 34
cat remtemp
	-127 127 31
cat vccp
	0.00 2.98 1.45 

[ Attachment, skipping... ]
----- End of forwarded message from Margit Schubert-While -----

-- 
Frodo Looijaard <frodol@dds.nl>  PGP key and more: http://huizen.dds.nl/~frodol
Defenestration n. (formal or joc.):
  The act of removing Windows from your computer in disgust, usually followed
  by the installation of Linux or some other Unix-like operating system.
