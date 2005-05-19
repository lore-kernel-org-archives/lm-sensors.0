From: elricofgrans@yahoo.com (=?iso-8859-1?q?Matthew?=)
Date: Thu, 19 May 2005 06:23:53 +0000
Subject: Not able to get it working...
Message-Id: <20030412012942.50109.qmail@web13807.mail.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

G'Day,

I've tried installing lm_sensors a few times, but
always had one problem or another. I found a source
RPM for RH8 today though, so took the easy option: I
used that, and things installed just fine. My kernel
version is 2.4, and I believe I have a new enough
version of I2C (however, I'm not sure how to check).

I have attached the dmesg output; lsmod does not
appear to exist. I have attached the output of
sensors-detect as I reran it just before.

My motherboard is a GA-8PE667 Ultra/Pro; there are
chips with sensors, but I'm not sure where to look to
get their numbers.

As one note, I have not run `modprobe -a': I tried,
but there does not seem to be a modprobe.

(I hope that's everything on your list - I don't think
I missed anything)

Anywho, I think I've done things more or less right (I
hope so!), but whenever I try to use a program that
uses lm_sensors, they act as if it is not there:
clearly I've done *something* wrong, somewhere along
the way. Do you have any thoughts or suggestions?

Thanks!

http://mobile.yahoo.com.au - Yahoo! Mobile
- Check & compose your email via SMS on your Telstra or Vodafone mobile.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: dmesg.output
Type: application/octet-stream
Size: 7397 bytes
Desc: dmesg.output
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030412/644c211b/dmesg.obj
-------------- next part --------------
A non-text attachment was scrubbed...
Name: sensors.output
Type: application/octet-stream
Size: 2247 bytes
Desc: sensors.output
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030412/644c211b/sensors.obj
