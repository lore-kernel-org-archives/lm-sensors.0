From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:16 +0000
Subject: vt8231 support in 686a
Message-Id: <Pine.LNX.4.58.0409221055250.6322@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi all,

on the http://secure.netroedge.com/~lm78/supported.html
is written that vt8231 is supported by via686a which is wrong
I think because:
http://archives.andrew.net.au/lm-sensors/msg18590.html

A user with epia v10000 board tried
modprobe i2c-isa
modprobe via686a
and it was not working ( no driver has been registered)
nothing in logs, sysfs mounted.

Please fix the table or tell me what I missed thanks :)

Rudolf
