From: r.marek@assembler.cz (Rudolf Marek)
Date: Tue, 26 Sep 2006 22:12:17 +0000
Subject: [lm-sensors] coretemp - digital temperature driver for Intel Core
Message-Id: <4519A5C1.8010207@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello all,

I had today some time and coded the driver for Core 2 processors which will read 
the temperature from the CPU. (precisely I worked on it from 16:36 to 23:59 with 
some preemptions ;)

I dont have such CPU so I'm looking for brave testers!

The code is "virgin" it compiles but that is all I know. Testers should expect 
oops, panic or simple crash... Or maybe if I did not make any mistake (hehe) the 
temperature in /sys/class/hwmon/correcthwmondir/temp1_input

To compile:
make -C /lib/modules/`uname -r`/build SUBDIRS=$PWD  modules

Again this should be for either brave testers or persons with the knowledge of C 
... I will review the code tomorrow again.

Good luck and thanks!

regards
Rudolf
-------------- next part --------------
A non-text attachment was scrubbed...
Name: coretemp.c
Type: application/octet
Size: 8780 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060927/5ad49cd3/attachment.bin 
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: Makefile
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060927/5ad49cd3/attachment.pl 
