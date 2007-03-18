From: r.marek@assembler.cz (Rudolf Marek)
Date: Sun, 18 Mar 2007 23:13:40 +0000
Subject: [lm-sensors] coretemp - take3
Message-Id: <45FDC7A4.9070601@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello all,

I'm CCing all interested parties, if some isn't please tell!

On URL bellow is current version of coretemp driver.

http://ssh.cz/~ruik/patches/

I do not own this CPU (happy user of overclocked Opteron ;) So it would be great
if someone can give it testing.  We need to test:

CONFIG_SMP y/n
CONFIG_CPU_HOTPLUG y/n
and also for x86_64 and i386 builds.

What was fixed? I fixed the issues Jean pointed out, I created separate patch
for ...msr_safe stuff.

http://lists.lm-sensors.org/pipermail/lm-sensors/2007-March/019169.html
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-March/019175.html

All is only compile tested (I tried SMP y/n with hotplug Y on x86_64)!
And considering late hours spent with this I would be careful ;)

Reviews/comments/testing welcome!
Note that you will need at least lm-sensors 2.10.2.

Rudolf


