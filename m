From: roy@karlsbakk.net (Roy Sigurd Karlsbakk)
Date: Sun, 16 Apr 2006 18:29:38 +0000
Subject: [lm-sensors] ridicolous sensors output?
Message-Id: <F05CFA5D-9080-4A98-A0B3-B3790A65FD1F@karlsbakk.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <F2CFFC9F-4DC4-4DBA-BDEB-C195DBCAD479@karlsbakk.net>
In-Reply-To: <F2CFFC9F-4DC4-4DBA-BDEB-C195DBCAD479@karlsbakk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>> ERROR: Can't get FAN6 data!
>
> Some pins of the W83792D chip can be used for different purposes. In
> your case, the fan6 pin is indeed used for something different so the
> w83792d kernel driver did not create an interface for that fan.
> "sensors" should ignore missing interface files in this case, but the
> version you have did not. This was fixed in CVS recently.
>
> You may try to add an "ignore fan6" statement in your configuration
> file.

didn't help. it still seems to probe it.

>> Fan7:     9246 RPM  (min =    0 RPM, div = 2)
>> Temp1:     +40.0 C  (high = +127.0 C, hyst =  +0.0 C)
>> Temp2:     +36.5 C  (high = +80.0 C, hyst = +75.0 C)   ALARM
>
> Looks like a known bug, fixed in lm_sensors 2.9.2.

indeed. cvs version works well here.

>> Temp3:     -48.5 C  (high = +80.0 C, hyst = +75.0 C)   ALARM
>
> -48 degrees C is a typical value for unconnected thermal sensors. You
> can probably just ignore that input ("ignore temp3").

just did that, so that's ok as well.

thanks

roy

--
Roy Sigurd Karlsbakk
roy at karlsbakk.net
---
In space, loud sounds, like explosions, are even louder because there  
is no air to get in the way.



