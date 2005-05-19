From: siegert@sfu.ca (Martin Siegert)
Date: Thu, 19 May 2005 06:25:00 +0000
Subject: ticket #1674
Message-Id: <20040531031703.GB6189@stikine.ucs.sfu.ca>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello again,

I found some more time to investigate the duplication of temp1
in /proc/sys/dev/sensors/w83782d-i2c-0-2d.

First of all: I applied the i2c-2.8.4 patch to the original kernel
source and then generated the lm_sensors patch using mkpatch.
dmesg displays the same module version on all modules.
Furthermore, I am running the same kernel on 96 boxes and the problem
appears only on about 2-4 of them. Thus, a mix of different versions
could hardly explain the problem.

But: sensors can read the temperatures just fine (without segfaulting),
thus the libsensors interface is working. Just reading the temperatures
out of /proc does not work. Thus, I rewrote the application that read
temperatures out of /proc to use the libsensors library functions and
that works very well. Hence, although this does not really solve the
original problem, it solves my problem :-)

Thanks for your help and good work!

Cheers,
Martin
