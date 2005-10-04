From: xanni@glasswings.com.au (Andrew Pam)
Date: Tue, 04 Oct 2005 14:56:40 +0000
Subject: [lm-sensors] Myson MTP008 driver ported to 2.6 kernel
Message-Id: <20051004125511.GI7154@kira.glasswings.com.au>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I got sick of waiting for someone else to do it, and ported the Myson
MTP008 chip driver to the Linux 2.6 kernel.  I have successfully compiled
and loaded the module on a Tyan Thunder LE ServerWorks dual P3 motherboard
with two of these chips.

The module source code is here:  http://www.sericyb.com.au/mtp008.c

Here are patches against Linux 2.6.12 and 2.6.13:

http://www.sericyb.com.au/linux-2.6.12-mtp008.patch.bz2
http://www.sericyb.com.au/linux-2.6.13-mtp008.patch.bz2

Please feel free to test and submit this for mainstream kernel inclusion,
or let me know where to send it.

Share and enjoy,
		Andrew
-- 
mailto:xanni@xanadu.net                         Andrew Pam
http://www.xanadu.com.au/                       Chief Scientist, Xanadu
http://www.glasswings.com.au/                   Partner, Glass Wings
http://www.sericyb.com.au/                      Manager, Serious Cybernetics
