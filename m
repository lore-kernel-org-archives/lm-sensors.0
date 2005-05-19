From: frodol@dds.nl (Frodo Looijaard)
Date: Thu, 19 May 2005 06:23:47 +0000
Subject: bug with sensors-detect recommendation for modprobe (fwd)
Message-Id: <200302161315.h1GDFx1N000464@shire.frodo.local>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

----- Forwarded message from ccd -----

Received: by morannon.frodo.local (8.11.3/8.11.3) id h1GBt3n32514 ; Sun, 16=
 Feb 2003 12:55:04 +0100
Return-path: <chuacd@pacific.net.sg>
Received: from pop3.dds.nl [213.196.1.204]
	by localhost with POP3 (fetchmail-6.2.0)
	for frodo@localhost (single-drop); Sun, 16 Feb 2003 12:55:04 +0100 (CET)
Received: (qmail-ldap/ctrl 22100 invoked from network); 16 Feb 2003 11:53:0=
2 -0000
Received: from maxwell1.pacific.net.sg ([203.120.90.191]) (envelope-sender =
<chuacd@pacific.net.sg>)
	         by dds.nl (qmail-ldap-1.03) with SMTP
	         for <frodol@dds.nl>; 16 Feb 2003 11:53:02 -0000
Received: from ppp110.dyn98.pacific.net.sg ([210.24.98.110])
	         by maxwell1.pacific.net.sg with ESMTP
	         id <20030216115258.DUAD28479.maxwell1.pacific.net.sg@ppp110.dyn98=
.pacific.net.sg>
	         for <frodol@dds.nl>; Sun, 16 Feb 2003 19:52:58 +0800
Subject: bug with sensors-detect recommendation for modprobe
From: ccd <chuacd@pacific.net.sg>
To: frodol@dds.nl
X-Mailer: Ximian Evolution 1.0.8-3mdk=20
Date: 16 Feb 2003 19:52:57 +0800
Message-ID: <1045396378.2988.5.camel@mandrake9_ccdDesktop>
X-Loop-Procmail: PreventLoop

hello,

I found a problem with the modprobe recommendation of sensors-detect.

It should be=20

  MODULE_0=3Di2c-viapro
  MODULE_1=3Di2c-isa
  MODULE_2=EEprom
  MODULE_3=ADm1021
  MODULE_4=3Dvia686a

instead of

  MODULE_1=3Di2c-viapro
  MODULE_2=3Di2c-isa
  MODULE_3=EEprom
  MODULE_4=ADm1021
  MODULE_5=3Dvia686a

due to the way the loop processing is done in /etc/rc.d/init.d/sensors.

I am using Mandrake 9.0 and lm_sensors-2.6.4-4mdk.rpm.


regards


----- End of forwarded message from ccd -----

--=20
Frodo Looijaard <frodol@dds.nl>  PGP key and more: http://huizen.dds.nl/~fr=
odol
Defenestration n. (formal or joc.):
  The act of removing Windows from your computer in disgust, usually follow=
ed
  by the installation of Linux or some other Unix-like operating system.
