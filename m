From: dll@microwave.com (dll@microwave.com)
Date: Thu, 19 May 2005 06:23:30 +0000
Subject: Ticket #: 818
Message-Id: <Pine.LNX.4.33.0202180028560.22876-100000@hal.microwave.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hrm. I installed lm_sensers from RedHat's RPM, and it didn't include any
modules, the ones I do have are part of the kernel RPM. I tried rebuilding
the source RPM, but it gets stuck in an infinite loop.

Apparently RedHat has chosen to package this differently for some reason -
I suppose I'ld just grab the source tarball and make it myself, unless you
have any other suggestions..

--


I have the K7S5a MB with SiS735 chipset.

I have managed to find here that I need the it87 modules.

I have installed lm_sensors 2.6.2, yet I do not _have_ the it87 modules.

Where the heck do I get it?

Reply from support:

it?s in lm_sensors 2.6.2, in kernel/chips.
If you did ?make install? then you should be able to ?modprobe it87?.
If you need more help email us and reference your ticket #.
MDS 2/17/02


