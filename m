From: Mark Preston <emp2008@att.net>
Date: Tue, 16 Feb 2010 20:39:01 +0000
Subject: [lm-sensors] How to compile k10temp?
Message-Id: <4B7B0265.30102@att.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


I have an  MSI motherboard (K9N6PGM-V2) and AMD cpu Athlon II X4 620 (4 
core cpu). I have found that some people have LM-sensors for K10 working 
in Ubuntu (Karmic, v 9.10) and I downloaded the driver: 
lm_sensors-3.1.2.tar.bz2 and following the instructions, tried make all, 
but the terminal returned error messages.

I read at the wiki about AMD

Family 10h CPU, family 11h CPU

and drive k10temp which is in kernel 2.6.33.

My OS: Karmic:~$ uname -r = 2.6.31-19-generic

so will k10 and LM work if I compile a .33 kernel, or will it be OK if I 
compile the K10 into the .31 kernel?

I'm not a programmer, but I can do some compiling tasks, as I'm not 
unfamiliar with ./ and such. I just need to know what order to issue the 
commands in and which ones need 'sudo' in front of them.

Can someone please point me to a tutorial or how-to and help me compile 
this into my OS?

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
