From: frodol@dds.nl (frodol@dds.nl)
Date: Thu, 19 May 2005 06:23:36 +0000
Subject: Parsing bug in sensord(8) (fwd)
Message-Id: <200207291650.g6TGo1t01083@shire.frodo.local>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Richard Gooch wrote:
From rgooch@ras.ucalgary.ca Mon Jul 29 03:40:04 2002
Received: by morannon.frodo.local (8.11.3/8.11.3) id g6T1e4k14669 ; Mon, 29 Jul 2002 03:40:04 +0200
Return-Path: <rgooch@ras.ucalgary.ca>
Received: from pop3.dds.nl [213.196.1.121]
	by localhost with POP3 (fetchmail-5.4.4)
	for frodo@localhost (single-drop); Mon, 29 Jul 2002 03:40:04 +0200 (CEST)
Received: (qmail 29283 invoked from network); 29 Jul 2002 01:21:17 -0000
Received: from unknown (HELO vindaloo.ras.ucalgary.ca) ([136.159.55.21]) (envelope-sender <rgooch@vindaloo.ras.ucalgary.ca>)
          by arkanoid.cybercomm.nl (qmail-ldap-1.03) with SMTP
          for <frodol@dds.nl>; 29 Jul 2002 01:21:17 -0000
Received: (from rgooch@localhost)
	by vindaloo.ras.ucalgary.ca (8.10.0/8.10.0) id g6T1ZbO04727;
	Sun, 28 Jul 2002 19:35:37 -0600
Date: Sun, 28 Jul 2002 19:35:37 -0600
Message-Id: <200207290135.g6T1ZbO04727@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Merlin Hughes <merlin@merlin.org>
Cc: Frodo Looijaard <frodol@dds.nl>
Subject: Parsing bug in sensord(8)
X-Loop-Procmail: PreventLoop

  Hi, guys. I'm trying to use sensord(8) to maintain a RR database.
It's working fine on two machines, but on another machine I get the
following error in my syslog:

sensord: Error creating RRD file: /var/log/sensord.rrd: can't parse argument 'DS:2.0V:GAUGE:300:U:U'

I suspect the cause of this is that the "raw" feature names that the
motherboard provides are not simple ones like "in0", but instead are
things like "2.0V". Perhaps the '.' is confusing the parser in
sensord(8)?

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca


-- 
Frodo Looijaard <frodol@dds.nl>  PGP key and more: http://huizen.dds.nl/~frodol
Defenestration n. (formal or joc.):
  The act of removing Windows from your computer in disgust, usually followed
  by the installation of Linux or some other Unix-like operating system.
