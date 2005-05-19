From: synaptical@linuxquestions.net (synaptical)
Date: Thu, 19 May 2005 06:24:40 +0000
Subject: can't compile i2c-2.8.3 on linux-2.6.2
Message-Id: <20040204194802.35A2CACA5@sitemail.everyone.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

i compiled the kernel with make clean; lm_sensors compiled after a make clean in lm_sensors. but i2c won't compile, it keeps giving me a "no rule to make target" error:

make: *** No rule to make target `mach_mpspec.h', needed by `kernel/i2c-pport.d'.  Stop.

i've made clean in the i2c directory, but i notice /usr/include/linux doesn't contain mach.mpspec.h -- is it supposed to? any idea on how i fix things so i2c will compile? 

thank you,
syn


_____________________________________________________________
Thank you for choosing LinuxQuestions.
http://www.linuxquestions.org
