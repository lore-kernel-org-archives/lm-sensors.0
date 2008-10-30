From: "Phil Miller" <unmobile@gmail.com>
Date: Thu, 30 Oct 2008 16:34:06 +0000
Subject: [lm-sensors] Opteron and ASUS L1N64-SLI WS/B: Status of K10 module,
Message-Id: <81f018ac0810300934u627ec401qeee23b7ee93f8517@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I'm running a new system with a pair of Opteron 2356 quad-core CPUs on
ASUS's L1N64-SLI WS/B motherboard. After running sensors-detect [0]
and searching the mailing lists, it looks like the code necessary to
fully support this board might be in need of testing or revision.

It looks like Jordan Crouse has offered a patch for the ADT7475 [1]
that was in need of updates before incorporating it. I would
appreciate a copy of or reference to the latest revision of that patch
so I can build and test.

According to a post in April [2], the temperature sensors in some
revisions of the K10 are inconsistent, and so shouldn't be relied
upon. That post asks the original poster for output from cpuid, but
doesn't mention how to identify the affected revisions from that. A
brief search of the web indicates that mine might be an afflicted B3
revision, but that output can be found at [4]

Finally, the board also has what is detected as an IT8716F chip
supported by the it87 driver, but I'm seeing some really weird
readings on the 5V lines and two of the three temperature lines.
Specifically, I'm seeing 6.85 volts on both +5V and 5VSB, and +127C on
a pair of sensors listed as a 'thermal diode' and 'transistor',
respectively, while the first transistor reports a perfectly sane 27C.

Phil

[0] http://charm.cs.uiuc.edu/~phil/sensors-detect
[1] Thread starts at
http://lists.lm-sensors.org/pipermail/lm-sensors/2008-September/024073.html
[2] http://lists.lm-sensors.org/pipermail/lm-sensors/2008-April/022839.html
[4] http://charm.cs.uiuc.edu/~phil/cpuid
[5] http://charm.cs.uiuc.edu/~phil/sensors

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
