From: devinsteffler.lists@gmail.com (Devin Steffler)
Date: Sun, 04 Feb 2007 18:04:11 +0000
Subject: [lm-sensors] Any hope for a Powermac?
Message-Id: <e46c17070702041004y51afac7m9596222c8f356964@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I have a Powermac G4 and would like to see the CPU temperature.  Is there
any hope that this can be done in Linux?  It looks possible for MacOSX:
http://www.bresink.com/osx/HardwareMonitor.html although maybe it isn't
possible for my machine:
http://www.bresink.com/osx/216202/Docs-en/faq.html#TAU

The Powermac I have is a Gigabit Powermac G4 400MHz with AGP.

I tried the following option in the Linux kernel: Platform support ->
On-chip CPU temperature sensor support, but this showed the CPU temperature
as 11-13 C (uncalibrated) in /proc/cpuinfo.  Which is obviously wrong, but
might be correct if calibrated properly.

Any ideas/tips/hints/suggestions?

Thanks,
Devin
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070204/214791be/attachment.html 
