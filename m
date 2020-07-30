From: Brian <bvamundsen@gmail.com>
Date: Thu, 30 Jul 2020 19:44:08 +0000
Subject: Re: Help with Intel 945GCL MB and Intel 950 CPU hwmon temp
Message-Id: <20200730144408.5a47c6ec@Hicrest1.UGATE2>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I'm struggling to get lm-sensors to see the CPU coretemps available on
this motherboard for the CPU.  The sensor-detect identified SMSC
LPC47M182, i2c-i801 and aSC7611, but nothing to be written. It also
says "SMSC LPC47m182 Super IO Fan Sensors, (but not activate.)".
Apparently the smc47m1 and smc47m192 don't support smc47m182, since no
driver is listed for 182. Nor does the aSC7621 support aSC7611
(confidence 5, "driver-to-be-written", but the description available
suggest the aSC7621 extends what Andigilog made available with
aSC7611. The CPU thermal coretemp is monitored and able to be
displayed with the BIOS setup screen, so I know the sensors are
working for it, but why don't they work with Linux?  The odd thing is
that /sys/class/thermal/cooling_device0/type is PROCESSOR?

How would I go about adapting or modify the modules to work properly
on this Intel motherboard?  I'm using Slackware64 14.2.

I've checked that Linux kernel 4.4.231 config has HWMON and THERMAL
set to "yes".

While this mother board and CPU are old, they are sufficient for my
needs.  Any advice would be appreciated.  Cheers, BrianA_MN.
P.S. I'm also on ##kernel, but have not seen any responses to inquiry
there.







