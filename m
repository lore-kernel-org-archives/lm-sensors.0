From: Philipp Kraus <philipp.kraus@flashpixx.de>
Date: Sat, 30 Jun 2012 05:52:06 +0000
Subject: [lm-sensors] CPU fan with full speed
Message-Id: <jsm40t$qk8$1@dough.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I'm using on a dual xeon system lmsensors and pwmconfig for listing and 
controlling the fan speed.
Lmsensors is configurated and checks the temperature of the CPUs, but 
the fans rotate every time with
full speed:

CPU1 Fan:    5555 RPM  (min = 2000 RPM)
CPU2 Fan:    5895 RPM  (min = 2000 RPM)

CPU 1 Temp:   +50.0 C  (high = +75.0 C, hyst = +60.0 C)  sensor = Intel PECI
CPU 2 Temp:   +53.0 C  (high = +75.0 C, hyst = +60.0 C)  sensor = Intel PECI

On booting up the fans have got around 2000 RPMs but some minuts the 
system speeds up on idle status
Can you help me please to configure the options correctly, that the 
RPMs are only gown up if needed?

Thanks

Phil



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
