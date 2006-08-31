From: jim.cromie@gmail.com (Jim Cromie)
Date: Thu, 31 Aug 2006 18:33:17 +0000
Subject: [lm-sensors] regression test script for sensors output
Message-Id: <44F72B6D.4050207@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


attached script reads `sensors` output, compares to file content
(which should contain sensors output from baseline driver, before you hack)

#> perl sensorck.pl -h
Unknown option: h
usage: sensorck.pl [opts] <filename>
    -v  : verbose
    -d <5> : percentage difference (5% is default)
    -e  : verbose on difference errlm


#> perl sensorck.pl -d 1 sensor-out
[222399.418306] pc87360 9191-6620: Data update
check VPWR
val out of range 0.0178282009724474: 12.34 should be 12.12
check VCORE
check VCC
check Vbat
check Critical
check -12V
check Vsb
check Vdd
check +12V
check Temp
check AVdd
check avi0
check GND

I hope this simplifies your future hacking...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: sensorck.pl
Type: application/x-perl
Size: 2234 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060831/72a96224/attachment.bin 
