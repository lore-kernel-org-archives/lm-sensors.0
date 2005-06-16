From: webmaster@bollchen.de (Burkart Lingner)
Date: Thu, 16 Jun 2005 00:28:47 +0000
Subject: [lm-sensors] Added sysfs support for decode-dimms.pl
Message-Id: <000201c571f9$ac2fb410$4d01a8c0@BURKART>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello everyone!

I needed to take a closer look at my RAM's SPD-EEPROMs today. Too bad the
sysfs of Kernel 2.6 wasn't supported by decode-dimms.pl, so I had to add
support for that myself. Since there probably are more people out there
who'd like to use this tool on a Kernel 2.6 system, it might be a good idea
to include the patched file in the next release of lm_sensors. The new
version can be found at http://www.bollchen.de/decode-dimms.pl. Of course
the "ADDED" comments should be removed then, I just left them in for now and
I can strip them later on demand. The new version does work with Kernel 2.6
and it should as well work with older Kernels and their proc-fs. Since I
only have a system running 2.6, could anyone with an older Kernel please do
a test run? That would be greatly appreciated, to make sure I didn't mess
anything up.

I tested the script on a Fedora Core 3 system with Kernel 2.6.11 and
lm_sensors 2.8.7.

Bye, Burkart 

