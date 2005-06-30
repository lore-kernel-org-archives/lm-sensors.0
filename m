From: ericb@aspsys.com (Eric J. Bowersox)
Date: Thu, 30 Jun 2005 23:37:53 +0000
Subject: [lm-sensors] W83792D & Overtemperature LED on Supermicro
Message-Id: <1120167411.32695.31.camel@wiz.dev.aspsys.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greetings to all.

We've got some compute nodes here that are using Supermicro X6DHR
motherboards (for the Intel Nocona processors), which use the Winbond
W83792D hardware monitor chip.  Since the OS installed on these is SuSE
Linux Enterprise Server 9 (kernel 2.6.5), I had to upgrade lm_sensors to
2.9.1 and apply a kernel patch (the one recently posted to this list) to
get the right chip driver into the system.  I'm able to get temperature,
fan, and voltage readings out of the chip, so it's all good there.

However, another strange issue has cropped up: during the system boot
process, as soon as the "sensors" service loads, the "overtemperature"
LED on the front panel begins flashing.  I've tried mucking around with
the "set tempN_over" and "set tempN_hyst" lines in sensors.conf, but to
no avail; the last settings I tried were 70 for over and 30 for hyst,
and the light still blinks.  Naturally, if we ship the nodes like this,
the customer might get worried, seeing all those blinking red lights.

So, anybody have any ideas, short of taking a pair of diagonal cutters
to the leads for the temperature light?  Is that light somehow connected
to one of the outputs of the W83792D, and if so, is there some kind of
"magic poke" I can make to the chip registers to get it to quit
flashing?  (Maybe this is a driver issue?)  Or have I just not been
aggressive enough in how I changed the temperature bounds in
sensors.conf?

Thanks in advance.

-- 
Eric J. Bowersox, Software Engineer     Aspen Systems, Inc.
<ericb@aspsys.com>                      3900 Youngfield Street
Tel: +01 303 431 4606 x113              Wheat Ridge, CO  80033, USA
Fax: +01 303 431 7196                   <http://www.aspsys.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: This is a digitally signed message part
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050630/c7ff3157/attachment.bin
