From: jlanger@zigweb.de (Julien Langer)
Date: Thu, 19 May 2005 06:25:02 +0000
Subject: Ticket 1700: lm99 on nvidia board doesn't work
Message-Id: <1087846585.2369.85.camel@moeff>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

> First of all, know that neither rivatv 0.8.5 nor CVS will work properly with
> Linux 2.6.7 as far as hardware monitoring is concerned. The author missed a
> define names change, and as a consequence, hardware monitoring chips will not
> recognize the nVidia busses as usable. I will send a patch to the author.

I applied your patch to rivatv and recompiled it, but it still doesn't work.

> Second, not only no LM99 chip is detected by sensors-detect, but the script
> doesn?t even see a chip at a possible address (0x4C or 0x4D). This can mean
> either of two things:
> 1* You simply don?t have a LM99 on that board. I guess that there are several
> different brands and models of GeForce FX cards out there, not all may have
> hardware monitoring features. Are you sure yours do?

http://www.hothardware.com/viewarticle.cfm?articleidB1&catid=2
This page says "Advanced thermal management and thermal monitoring" so I suppose it has one.


> 2* The bus errors you are experiencing (sendbytes: error - bailout.) are
> preventing the chip from being detected (simply as being there, not even as
> being a LM99).
> 
> Nothing wrong with the client on bus 2 that cannot be probed though. It simply
> means that an i2c client driver (most likely saa7108e) is already loaded for
> this device.
> 
> At any rate, the problem here is with the i2c bus, not the LM99 (if it exists).
> You should contact the maintainer of the rivatv module (as an i2c bus driver),
> maybe he?ll have ideas about how you can investigate the problem.
> 
> You could also try sensors-detect as found in lm_sensors 2.8.6. Detection method
> slightly changed since. New method is believed to be better, of course, and was
> successfully tested, but your system might be special for some reason.
> 
> You can contact us on the mailing-list if you have further questions or want to
> tell us the end of the story.



