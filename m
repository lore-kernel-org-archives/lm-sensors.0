From: gtj.devel@peakin.com (George T. Joseph (development))
Date: Sun, 24 Dec 2006 00:44:49 +0000
Subject: [lm-sensors] Andigilog aSC7621 & Intel D975XBX2 Motherboard
Message-Id: <22E26940476D1E48AA6F292B5316C9C33768@bes1.peakin.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20061223234012.GA5410@seahunt.dyndns.org>
In-Reply-To: <20061223234012.GA5410@seahunt.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>So... is someone working on a driver for this chip...

Yep.  I am.  Here's the patch for the kernel.  I was waiting for Jean to
review it before doing the lm_sensors bit but since the Bad Axe 2 is
becoming more popular maybe I'll just do the lm_sensors now and update
it after the review.

Anyway, apply the patch to a 2.6.18 or greater kernel.  Sensors-detect
won't find the driver but you can add a MODULE line to
/etc/sysconfig/lm_sensors manually.

george

-----Original Message-----
From: lm-sensors-bounces@lm-sensors.org
[mailto:lm-sensors-bounces at lm-sensors.org] On Behalf Of Michael Nelson
Sent: Saturday, December 23, 2006 4:40 PM
To: lm-sensors at lm-sensors.org
Subject: [lm-sensors] Andigilog aSC7621 & Intel D975XBX2 Motherboard

Hi...

I've managed to do it again... bought another motherboard that seems to
have hardware monitoring stuff on it that is not yet supported by
lm-sensors.

The board I have is an Intel D975XBX2KR.  Nice board, but I can't find
anywhere in the documentation on the Intel site or that came with the
board what kind of hw monitoring chip it has.  The monitoring does work
(I can see it in the BIOS setup screens), but running sensors-detect
from lm-sensors 2.10.1 just recommends loading eeprom and i2c-i801.
Naturally, sensors doesn't work.

I grabbed the nightly lm-sensors-r4270-20061223.tar.bz2 and it will
compile "make user" and run sensors-detect.

It says: 

	Probing for `Andigilog aSC7621'...  Success!
          (confidence 5, driver `to-be-written')

So... is someone working on a driver for this chip, or is it a
mis-detection, or?

Thanks
Michael

-- 
If a kid asks where rain comes from, I think a cute thing to tell him is
"God is crying." And if he asks why God is crying, another cute thing to
tell him is "Probably because of something you did."

San Francisco, CA

_______________________________________________
lm-sensors mailing list
lm-sensors at lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
-------------- next part --------------
A non-text attachment was scrubbed...
Name: asc7xxx.patch
Type: text/x-patch
Size: 52327 bytes
Desc: asc7xxx.patch
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061223/470fd6fc/attachment-0001.bin 
