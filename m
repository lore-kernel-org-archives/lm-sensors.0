From: Dmitry Gromov <gromovd@gmail.com>
Date: Tue, 11 May 2010 13:44:49 +0000
Subject: Re: [lm-sensors] Intel Atom thermal sensors
Message-Id: <AANLkTilYenvjB6qvbX2btH7agSnw3mZZxWSkwO3SJdj0@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <u2oe21d97a51004271247n7f5d4fbcn2a3de7429c738a08@mail.gmail.com>
In-Reply-To: <u2oe21d97a51004271247n7f5d4fbcn2a3de7429c738a08@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi!

Well, if anyone is interested. I successfully installed Ubuntu Server 10.04:

Linux dgwind1 2.6.32-21-generic #32-Ubuntu SMP Fri Apr 16 08:09:38 UTC
2010 x86_64 GNU/Linux

I re-run sensors-detect hoping it would fix configuration and allow
Intel Atom sensors to be reported.
It did detect those sensors... but failed to add coretemp driver to /etc/modules

Once I loaded coretemp driver, I was able to see 4 outputs of Atom
temperature sensors - this is dual core N330 CPU, with hyperthreading.
What is interesting though is that it seems like probe of one core
reported as Core 0 and 2 and probe of the second core is reported as
Core 1 and 3 - I thought, they'd be reported sequentially.

There is also an issue with critical temperature for Atom processor.
It is hardcoded in the driver as 90C, which is wrong, because for dual
core Atom N330 it is only 85.2C:
http://processorfinder.intel.com/details.aspx?sSpec=SLG9Y
http://download.intel.com/design/processor/designex/320530.pdf

I see there is a thread about a patch to read Tjmax from CPU, not sure
if it will fix this issue or not.

I'm still having issues with fan speed and adt7468 chip, but I'd
better send separate email about it.

-- 
DG
NJ

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
