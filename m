From: David Anderson <davea42@gmail.com>
Date: Mon, 17 Feb 2014 17:34:02 +0000
Subject: Re: [lm-sensors] sensors command now hangs [update]
Message-Id: <5302480A.6020808@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This started  in late 2013, a month or two
after installing Nvidia GTX 760 (and new PSU)
--- I reported system hang
from sensors command  to lm-sensors on Jan 20, 2014.

I was avoiding the sensors command since Jan 20
but something used it (me? I don't recall. ipmi?)
(as reported in kern.log: blocked for more than 120 seconds.)
and it was hanging and the system
hung up totally last night, February 16.

Found Guenter's January advice (impi conflicts with
other hardware monitoring) and since I am not using ipmi
I commented out ipmi-si from /etc/modules and rebooted
today.   lsmod shows no ipmi now. synaptic does not show
any ipmi stuff installed.

Hopefully the hangs will no longer happen.
Thanks. My fault for not finding Guenter's advice sooner.
DavidA.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
