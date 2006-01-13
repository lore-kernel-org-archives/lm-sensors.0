From: jschrod@acm.org (Joachim Schrod)
Date: Fri, 13 Jan 2006 00:31:01 +0000
Subject: [lm-sensors] Questions on sensors.conf
Message-Id: <dq6sc5$n2s$1@sea.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I started to use lm_sensors to monitor my hardware. In particular, I want to
monitor temperature and fan functionality.

The system has an Intel D865GBF ATX Mainboard, with a Pentium 4 3 GHz processor,
800 MHz FSB, 1 MB Cache. I'm using lm_sensors version 2.9.1 that came with SUSE 
10.0.

sensors-detect went fine, it detected the LM85 sensor chip "lm85b-i2c-0-2e";
start of the lm_sensors service as well, then calling sensors got:

CPU_Fan:   2669 RPM  (min = 4000 RPM)                     ALARM
fan2:         0 RPM  (min =    0 RPM)
fan3:         0 RPM  (min =    0 RPM)
fan4:         0 RPM  (min =    0 RPM)
CPU:         +45 C  (low  =   +10 C, high =   +50 C)
Board:       +36 C  (low  =   +10 C, high =   +35 C)     ALARM
Remote:      +37 C  (low  =   +10 C, high =   +35 C)     ALARM

Oops, obviouslsy too much alarms for my taste. ;-)
So I learned that I have to configure /etc/sensors.cfg.

First, I wanted to check the measured values. So I rebooted and looked into the 
BIOS read-out.
My BIOS reports the CPU temperature to be 56?C, System Zone 1 as 40?C, and 
System Zone 2 as 45?C. (Wherever zone 1 and 2 are -- I assume that they match 
temp2_* and temp3_* whereas temp1_* is the CPU.)
The CPU fan speed is the same, so that doesn't need any adaption.


So here's my first question:
Is it best practice to assume that the BIOS values are OK and to add compute 
statements to increase the lm_sensors values to match them?

Is the relation between BIOS measurement and sensors measurement usually linear?
I.e., do I just add and subtract the difference in a compute statement?
Or does your experience tell that this needs some scale factor as well?


And my second question:
The semantics of the temperature limits in sensors.conf are still unclear to me.

There is temp#_min, temp#_max, temp#_hyst, and temp#_over.
min and max are not explained.
hyst and over are not used in the LM85 example configuration.
As far as I understood, if a temperature gets > temp#_over, ALARM is turned on; 
and if it gets (subsequently) < temp#_hyst, ALARM is turned off again.
But what happens if the temperature is below temp#_min or above temp#_max?
How is the relation between these two vars and hyst/over?

In addition, the documentation of lm85 mentions other sensors.conf variables 
named zone#_{limit,hyst,range,critical} which aren't used at all. It looks as if 
the documentation is out of date and these variables don't exist any more. Is 
that assumption true?

Last, the documentation mentions a /proc interface. I gather that this got 
replaced by the /sys interface. There I find files/variables named 
temp#_auto_temp_* that look interesting. Is there any documentation for them?


Sorry for these many questions. If there is documentation that I haven't found 
and that would answer them, I'd also appreciate any hint to it.

Best,
	Joachim

-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
Joachim Schrod                Email: jschrod at acm.org
Roedermark, Germany


