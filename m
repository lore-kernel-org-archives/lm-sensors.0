From: frodol@dds.nl (Frodo Looijaard)
Date: Thu, 19 May 2005 06:23:36 +0000
Subject: missing i2c-algo-8xx files (i2c-2.6.4 mkpatch  + 2.4.19rc3) (fwd)
Message-Id: <200207232137.g6NLbuo01890@morannon.frodo.local>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

"James G. Sack (jim)" wrote:
From jsack@land-5.com Tue Jul 23 21:25:05 2002
Received: by morannon.frodo.local (8.11.3/8.11.3) id g6NJP5829927 ; Tue, 23 Jul 2002 21:25:05 +0200
Return-Path: <jsack@land-5.com>
Received: from pop3.dds.nl [213.196.1.122]
	by localhost with POP3 (fetchmail-5.4.4)
	for frodo@localhost (single-drop); Tue, 23 Jul 2002 21:25:05 +0200 (CEST)
Received: (qmail 27417 invoked from network); 23 Jul 2002 19:02:28 -0000
Received: from unknown (HELO mail.land-5.com) ([209.220.38.130]) (envelope-sender <jsack@inostor.com>)
          by arkanoid.cybercomm.nl (qmail-ldap-1.03) with SMTP
          for <frodol@dds.nl>; 23 Jul 2002 19:02:28 -0000
Received: from inostor.com (unknown [172.16.1.75])
	by mail.land-5.com (Postfix) with ESMTP id A2C262B51E
	for <frodol@dds.nl>; Tue, 23 Jul 2002 12:13:21 -0700 (PDT)
Sender: jsack@land-5.com
Message-ID: <3D3DAB91.F6BC7720@inostor.com>
Date: Tue, 23 Jul 2002 12:16:33 -0700
From: "James G. Sack (jim)" <jsack@inostor.com>
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.4.18PP-server i686)
X-Accept-Language: en, de, fr, el, ru, ko, ja, af, is, fi, zh, no
MIME-Version: 1.0
To: frodol@dds.nl
Subject: missing i2c-algo-8xx files (i2c-2.6.4 mkpatch  + 2.4.19rc3)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Loop-Procmail: PreventLoop

Applying mkpatch/mkpatch.pl to kernel 2.4.19-rc3 seems to leave the 2
files i2c-algo-8xx{c,h} missing in the /usr/src/linux/kernel/i2c
directory.

make dep reports an error 
copying the files eliminates the make dep error

..jim


-- 
Frodo Looijaard <frodol@dds.nl>  PGP key and more: http://huizen.dds.nl/~frodol
Defenestration n. (formal or joc.):
  The act of removing Windows from your computer in disgust, usually followed
  by the installation of Linux or some other Unix-like operating system.
