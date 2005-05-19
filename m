From: frodol@dds.nl (frodol@dds.nl)
Date: Thu, 19 May 2005 06:23:37 +0000
Subject: lm-sensors (fwd)
Message-Id: <200208162140.g7GLeru05322@shire.frodo.local>
List-Id: <lm-sensors.vger.kernel.org>
References: <3C61EE92.392A5D31@paradyne.com>
In-Reply-To: <3C61EE92.392A5D31@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

tedturbo@katamail.com wrote:
From tedturbo@katamail.com Fri Aug 16 23:40:05 2002
Date: Fri, 16 Aug 2002 23:40:05 +0200
Message-Id: <200208162140.g7GLe5701460@morannon.frodo.local>
Received: by morannon.frodo.local (8.11.3/8.11.3) id g7GLe5701460 ; Fri, 16 Aug 2002 23:40:05 +0200
Return-Path: <tedturbo@katamail.com>
Received: from pop3.dds.nl [213.196.1.122]
	by localhost with POP3 (fetchmail-5.4.4)
	for frodo@localhost (single-drop); Fri, 16 Aug 2002 23:40:05 +0200 (CEST)
Received: (qmail 28238 invoked from network); 16 Aug 2002 21:12:11 -0000
Received: from unknown (HELO smtp3.libero.it) ([193.70.192.127]) (envelope-sender <tedturbo@katamail.com>)
          by arkanoid.cybercomm.nl (qmail-ldap-1.03) with SMTP
          for <frodol@dds.nl>; 16 Aug 2002 21:12:11 -0000
Received: from mirkwood (151.27.177.240) by smtp3.libero.it (6.5.028)
        id 3D5121BE00257B41 for frodol@dds.nl; Fri, 16 Aug 2002 23:28:20 +0200
From: tedturbo@katamail.com
To: frodol@dds.nl
Subject: lm-sensors
X-Mailer: Sylpheed version 0.7.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Loop-Procmail: PreventLoop

Hi

i was talking with Martin Peters (Vcool authors)
he says that he has used w83782d datasheet for asus as99.... chip 
it says that 
"The temperature data format is 8-bit twos-complement for sensor 1 and 9-bit twos-complement for 
sensor 2/3."

so if sensors reads only 8 bit from sensors2, beh this is the cause of wrong value and of
"2" factor :)

Bye
Paolo


-- 
Frodo Looijaard <frodol@dds.nl>  PGP key and more: http://huizen.dds.nl/~frodol
Defenestration n. (formal or joc.):
  The act of removing Windows from your computer in disgust, usually followed
  by the installation of Linux or some other Unix-like operating system.
