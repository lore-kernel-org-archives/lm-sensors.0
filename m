From: frodol@dds.nl (Frodo Looijaard)
Date: Thu, 19 May 2005 06:23:49 +0000
Subject: A7V8X sensor (w83781d.o module that support ASB100 chip) usage problem.
Message-Id: <200303032100.h23L0UVh002674@shire.frodo.local>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

----- Forwarded message from Andrea Rossetti -----

Received: by morannon.frodo.local (8.11.3/8.11.3) id h23Kt3I06279 ; Mon, 3 Mar 2003 21:55:03 +0100
Return-path: <andros@nemo.myhome.ros>
Received: from pop3.dds.nl [213.196.1.204]
	by localhost with POP3 (fetchmail-6.2.0)
	for frodo@localhost (single-drop); Mon, 03 Mar 2003 21:55:03 +0100 (CET)
Received: (qmail-ldap/ctrl 26592 invoked from network); 3 Mar 2003 20:48:12 -0000
Received: from unknown (HELO smtp2.cp.tin.it) ([212.216.176.222]) (envelope-sender <andros@nemo.myhome.ros>)
	         by dds.nl (qmail-ldap-1.03) with SMTP
	         for <frodol@dds.nl>; 3 Mar 2003 20:48:12 -0000
Received: from nemo.myhome.ros (80.181.71.17) by smtp2.cp.tin.it (6.5.033)
	       id 3E50C314005AB96A; Mon, 3 Mar 2003 21:48:12 +0100
Received: from andros by nemo.myhome.ros with local (Exim 3.36 #1 (Debian))
	id 18pwr9-0000BS-00; Mon, 03 Mar 2003 21:48:15 +0100
From: Andrea Rossetti <andy.ros@tin.it>
To: Frodo Looijaard <frodol@dds.nl>, Philip Edelbrock <phil@netroedge.com>, 
	   Mark Studebaker <mdsxyz123@yahoo.com>
Subject: A7V8X sensor (w83781d.o module that support ASB100 chip) usage problem.
Date: Mon, 3 Mar 2003 21:48:14 +0100
User-Agent: KMail/1.5
Content-Disposition: inline
Message-ID: <200303032148.15122.andy.ros@tin.it>
Sender: Andrea Rossetti <andros@nemo.myhome.ros>
X-Loop-Procmail: PreventLoop

Hi, I've a problem!

I'use Debian sid/unstable and I've installed the sources of i2c and lm_sensors 
and compiled/deb-packed and installed this modules (I've the 2.4.20 version 
of the kernel).

I've the A7V8X motherboard that have a built-in ASB100 sensor chip supported 
by the w83781d.o

I do
# modprobe w83781d
# lsmod
Module                  Size  Used by    Tainted: P
w83781d                19248   0  (unused)
i2c-proc                6832   0  [w83781d]
i2c-core               14468   0  [w83781d i2c-proc]
...
...

but if I do

# sensors
No sensors found!


how can monitor the parameters ?

2nd question: there are other sensor chips in this motherboard (the 
following), how can I monitor this chips?

Board	Sensor Chip	Case Sensor	CPU Sensor 
A7V8X	ASB100		Asus 1		Asus 2 socket/Asus 4 diode

Thanks in advance.

Andrea.

----- End of forwarded message from Andrea Rossetti -----

-- 
Frodo Looijaard <frodol@dds.nl>  PGP key and more: http://huizen.dds.nl/~frodol
Defenestration n. (formal or joc.):
  The act of removing Windows from your computer in disgust, usually followed
  by the installation of Linux or some other Unix-like operating system.
