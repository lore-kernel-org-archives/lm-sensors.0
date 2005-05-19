From: marcin_ml@sekretarka.no-ip.org (Marcin =?iso-8859-2?q?Ka=B3u=BFa?=)
Date: Thu, 19 May 2005 06:25:00 +0000
Subject: ATXP1 module
Message-Id: <200405271523.46859.marcin_ml@sekretarka.no-ip.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi
I've finished the first working version of the ATXP1 driver
There's still some things to do (detection  of the chip, maybe vendor specific 
features, debug etc), but since my exams are coming soon I suppose I won't 
have time to do it.

As for now I wouldn't use it on non-EPOX mainboard without checking the 
function of the registers used, since I can't tell the results...

I'm open to any critics and suggestions of course ;)

The code is in attachments  (in the end I enclose the makefile, just in case I 
wouldn't be using some defaults - I'm not much into writing modules yet)
In case they are removed by the server they are here:
http://sekretarka.no-ip.org/~mk/atxp1/atxp1-1.0-pre1.tgz

greetz
Martin

-------------- next part --------------
A non-text attachment was scrubbed...
Name: atxp1.c
Type: text/x-csrc
Size: 10031 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040527/20c1a9f0/atxp1.bin
-------------- next part --------------
A non-text attachment was scrubbed...
Name: Makefile
Type: text/x-makefile
Size: 351 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040527/20c1a9f0/Makefile.bin
-------------- next part --------------
A non-text attachment was scrubbed...
Name: atxp1.h
Type: text/x-chdr
Size: 679 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040527/20c1a9f0/atxp1-0001.bin
