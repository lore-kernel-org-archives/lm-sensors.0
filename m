From: frodol@dds.nl (Frodo Looijaard)
Date: Thu, 19 May 2005 06:23:46 +0000
Subject: ...no subject... (fwd)
Message-Id: <200301272025.h0RKPRXK001258@shire.frodo.local>
List-Id: <lm-sensors.vger.kernel.org>
References: <200301261540.h0QFeENU001922@shire.frodo.local>
In-Reply-To: <200301261540.h0QFeENU001922@shire.frodo.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

----- Forwarded message from WHarms@bfs.de -----

Received: by morannon.frodo.local (8.11.3/8.11.3) id h0R8P5q21120 ; Mon, 27 Jan 2003 09:25:05 +0100
Return-path: <WHarms@bfs.de>
Received: from pop3.dds.nl [213.196.1.204]
	by localhost with POP3 (fetchmail-6.2.0)
	for frodo@localhost (single-drop); Mon, 27 Jan 2003 09:25:05 +0100 (CET)
Received: (qmail-ldap/ctrl 17266 invoked from network); 27 Jan 2003 08:14:36 -0000
Received: from ws-han1.win-ip.dfn.de ([193.174.75.150]) (envelope-sender <WHarms@bfs.de>)
	         by dds.nl (qmail-ldap-1.03) with SMTP
	         for <frodol@dds.nl>; 27 Jan 2003 08:14:36 -0000
Received: from mail.bfs.de ([194.94.69.67])
	by ws-han1.win-ip.dfn.de (8.12.1/8.12.1) with ESMTP id h0R8EZws005931
	for <frodol@dds.nl>; Mon, 27 Jan 2003 09:14:35 +0100 (MET)
Received: from localhost (localhost [127.0.0.1])
	by mail.bfs.de (BfS Mail Relay) with ESMTP id AE065296FC
	for <frodol@dds.nl>; Mon, 27 Jan 2003 09:14:34 +0100 (CET)
Received: from apz.bfs (apz.bfs [192.168.0.1])
	by mail.bfs.de (BfS Mail Relay) with ESMTP id 2757A296F7
	for <frodol@dds.nl>; Mon, 27 Jan 2003 09:14:34 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by apz.bfs (BfS Mail Hub) with ESMTP id BB64F4917
	for <frodol@dds.nl>; Mon, 27 Jan 2003 09:15:13 +0100 (CET)
Received: from SZKOM.BFS.DE (unknown [193.174.230.136])
	by apz.bfs (BfS Mail Hub) with SMTP id 34BC5467F
	for <frodol@dds.nl>; Mon, 27 Jan 2003 09:15:13 +0100 (CET)
Received: by SZKOM.BFS.DE with VINES-ISMTP; Mon, 27 Jan 2003 9:14:57 +0100
Date: Mon, 27 Jan 2003 9:15:21 +0100
Message-ID: <vines.sxdD+NeCByA@SZKOM.BFS.DE>
X-Priority: 3 (Normal)
To: <frodol@dds.nl>
From: <WHarms@bfs.de> (Walter Harms)
Reply-To: <WHarms@bfs.de>
Errors-To: <WHarms@bfs.de>
Subject: Re: Re: ...no subject...
X-Incognito-SN: 25185
X-Incognito-Version: 5.1.0.84
X-Virus-Scanned: by BfS Mail Hub
X-Virus-Scanned: by BfS Mail Relay
X-Loop-Procmail: PreventLoop

hi,
perhaps you should post that to the MAINTAINES maintainer too. the www is also
not reachable and your address is the only working one.

just an idea,

	walter





- - - - - - - - - - - - - - Original Message - - - - - - - - - - - - - -
From: Frodo Looijaard <frodol@dds.nl>
Subject: Re: ...no subject...
Date: 01/26/03 16:40

WHarms@bfs.de wrote:
> hi frodo,
> i coudnt reach pelican,

True. I have had problems too.

Try sensors@Stimpy.netroedge.com for now (I've cc-ed this).
 
> <linux-i2c@pelican.tk.uni-linz.ac.at>... Deferred: Connection timed out with pelican.tk.uni-linz.ac.at. 
> 
> because you are mentioned as i2c maintainer this is of
> interessed for you also.
> 
> 	walter
> 
> 
> 
> Hi, 
> i was looking into the i2c code and found that some 
> sprintf() statement simply print without any 
> range restictions. 
> I dont thing this is a security problem but an buffer overflow is basicly possible. 
> e.g. 
> /* from i2c-core.c */ 
> if (i2cproc_initialized) { 
> char name[8]; 
> struct proc_dir_entry *proc_entry; 
> 
> -> sprintf(name,"i2c-%d", i); 
> 
> 
> In this example i=1..I2C_ADAP_MAX what is now 16 but 
> sprintf(name,"i2c-%02d", i); is a simple solution that 
> secures agains any accidentle overflow. 
> 
> 
> hope that helps, 
> walter 
> 
> ps: if you like i can send a patch 
> 

-- 
Frodo Looijaard <frodol@dds.nl>  PGP key and more: http://huizen.dds.nl/~frodol
Defenestration n. (formal or joc.):
  The act of removing Windows from your computer in disgust, usually followed
  by the installation of Linux or some other Unix-like operating system.

----- End of forwarded message from WHarms@bfs.de -----

-- 
Frodo Looijaard <frodol@dds.nl>  PGP key and more: http://huizen.dds.nl/~frodol
Defenestration n. (formal or joc.):
  The act of removing Windows from your computer in disgust, usually followed
  by the installation of Linux or some other Unix-like operating system.
