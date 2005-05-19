From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:23:52 +0000
Subject: lm-sensors: w83627hf.c (fwd)
Message-Id: <3E93787C.2010107@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200304061852.h36Iq8uf000590@shire.frodo.local>
In-Reply-To: <200304061852.h36Iq8uf000590@shire.frodo.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks for the info.
Sorry, though, we don't have any great contacts at those companies.
Your best bet is to actually look at your board and see what's on there.
Also, of course, sensors-detect and i2cdetect / i2cdump.
As the 627HF is a Super I/O chip it's unlikely you have two.
You could have another (different) sensor chip though (which is a possiblility you didn't mention).
If you figure it out let us know.

Frodo Looijaard wrote:
> ----- Forwarded message from Damian Menscher -----
> 
> Received: from localhost (frodo@localhost [127.0.0.1])
> 	by morannon.frodo.local (8.12.3/8.12.3/Debian-6.3) with ESMTP id h36Be5i0029483
> 	for <frodo@localhost>; Sun, 6 Apr 2003 13:40:05 +0200
> Received: from pop3.dds.nl [213.204.195.153]
> 	by localhost with POP3 (fetchmail-5.9.11)
> 	for frodo@localhost (single-drop); Sun, 06 Apr 2003 13:40:05 +0200 (CEST)
> Received: (qmail-ldap/ctrl 4982 invoked from network); 6 Apr 2003 11:28:31 -0000
> Received: from unknown (HELO intellx2.physics.uiuc.edu) ([128.174.129.13]) (envelope-sender <menscher@uiuc.edu>)
> 	         by dds.vsp.scarlet-internet.nl (qmail-ldap-1.03) with SMTP
> 	         for <frodol@dds.nl>; 6 Apr 2003 11:28:31 -0000
> Received: (qmail 21749 invoked by uid 3121); 6 Apr 2003 11:28:25 -0000
> Date: Sun, 6 Apr 2003 06:28:25 -0500 (CDT)
> From: Damian Menscher <menscher@uiuc.edu>
> X-X-Sender: menscher@lx2.physics.uiuc.edu
> Reply-To: Damian Menscher <menscher@uiuc.edu>
> To: frodol@dds.nl,  <phil@netroedge.com>,  <mdsxyz123@yahoo.com>
> Subject: lm-sensors: w83627hf.c
> Message-ID: <Pine.LNX.4.44.0304060520001.21269-100000@lx2.physics.uiuc.edu>
> X-Loop-Procmail: PreventLoop
> Return-Path: <menscher@uiuc.edu>
> 
> I'm writing to you because I've found a rather unusual inconsistency
> between the spec sheets for the Winbond W83627HF and my motherboard.
> 
> According to the Winbond spec sheet:
>    http://www.winbond.com/PDF/sheet/w83627hf.pdf
> The chip supports
>  3 thermal inputs from optionally remote thermistors or 2N3904
>    transistors or PentiumTM II (Deschutes) thermal diode output
>  7 positive voltage inputs (typical for +12V, -12V, +5V, -5V, +3.3V,
>    VcoreA, VcoreB)
>  2 intrinsic voltage monitoring (typical for Vbat, +5VSB)
>  3 fan speed monitoring inputs
>  2 fan speed control
>  Build in Case open detection circuit
>  WATCHDOG comparison of all monitored values
>  Programmable hysteresis and setting points for all monitored items
> etc...
> 
> Your driver, w83627hf.c (downloaded from CVS a few hours ago), agrees
> with this spec sheet.
> 
> But I have a motherboard, the Intel SE7505VB2, that has a differing
> opinion.  According to page 47 of its spec sheet:
> ftp://download.intel.com/support/motherboards/server/se7505vb2/tps.pdf
> it uses the W83627HF, but manages to monitor:
> 3 temperatures
> 9 voltages
> 2 PWM
> 6 fan speeds!
> 
>>From the BIOS, I can see four system fans and two CPU fans.  So, I
> know there really are 6 fan monitors.  So something doesn't make
> sense here.
> 
> I see a few possibilities:
>  - The SE7505VB2 uses more than one W83627HF.
>  - The Intel spec sheet is wrong.
>  - The Winbond spec sheet is wrong.
> 
> Since you apparently have contacts at both Winbond and Intel, I'm
> guessing it'll be easier for you to track this down than for me.
> And I'm sure you'll want your driver to take advantage of the other
> four fans counters, if they exist!
> 
> I'm currently setting up a cluster of systems, and I don't mind
> doing some testing of drivers on them before they go into production
> mode.  Let me know if there's anything I can do to help.
> 
> On an unrelated note, how do I acknowledge the intrusion alarm?  I
> can't get the thing to stop complaining.
> 
> Thanks,
> 
> Damian Menscher
