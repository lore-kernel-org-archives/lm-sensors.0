From: eric@brouhaha.com (Eric Smith)
Date: Mon, 10 Oct 2005 03:05:24 +0000
Subject: [lm-sensors] decode-dimms.pl updated for kernel 2.6
Message-Id: <45257.71.129.198.222.1128906245.squirrel@71.129.198.222>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I've modified decode-dimms.pl to work on kernel 2.6 using /sys/bus/i2c in
place of /proc/sys/dev/sensors.  I tried to preserve the ability to work
with /proc, but I don't have a system running an old kernel to test it on.
I've tested the new code on a Tyan S2892 motherboard running Fedora Core 4
with kernel-2.6.13-1.1526_FC4.

The original script repeatedly grabbed 16 bytes of EEPROM data; I moved
that code into a subroutine get_16_bytes().  In the subroutine it now
decides which method to use to grab the data based on whether the filename
starts with /proc.  If not, it invokes 'od' with various arguments to
get the data.  I'm not much of a Perl programmer, so there's probably
a better way to do it.

The updated script is on my web site:
    http://www.brouhaha.com/~eric/software/lm_sensors/decode-dimms.pl

Best regards,
Eric Smith

