From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:20 +0000
Subject: Iwill MPX2 - LM83/LM90 confusion
Message-Id: <1065536622.3f82cc6ee9ab5@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I believe there is some confusion about what chips are on the Iwill
> MPX2. I obviously own one, and I'm guilty of looking at it to try and
> see what chips are on it (it's already installed in the case!) but
> I've done a bit of research, and I strongly believe that the MPX2 has
> a LM90, not LM83 on board. 

I wouldn't be surprised. The confusion comes from two different facts:
1* The LM83 data sheet is missing the device ID.
2* Both chips are partly compatible.

> The best evidence is the Motherboard Monitor, MBM
> (http://mbm.livewiredev.com/) site (undoubtedly you've heard of it);

Sure I have, we are sometimes working together with Alex van Kaam, MBM's
author, and share our views and experiences.

> it lists the MPX2 as having a LM90.

This is no proof. Both chips being partly compatible, one can use a lm90
driver on a LM83 and get reasonable results. I remember Alex told me he
wasn't really interested in having a separate lm83 driver.

> Furthermore, I have installed the MBM and it does show temperatures
> for both CPUs.

More interesting. Incidentally, Alex and I were discussing about that
some days ago. He uses special tricks to handle that (and kindly shared
that information with me). I had some difficulties understanding it at
first, because I had never seen systems requiring the trick, maybe
you'll make me change my mind.

> On the other hand, only temp1 and temp3 on lm_sensors LM83 show
> temperatures for the MPX2; temp 2 and temp4 both report 0C.

This is definitely the sign that this isn't a LM83 - unless the
motherboard designer was crazy enough to solder a 4-temp sensor where a
2-temp one would suffice.

> I am willing to test whatever LM90 software you may have.
> (...) I currently have 2.8.0, i2c and lm_sensors, installed.

To the good news now...

LM Sensors 2.8.1, which was released yesterday, has full support for the
LM90 :) Please give it a try, and tell me how it works for you.

If Alex's trick is required for the MPX2, you'll see only the
temperature for one CPU. In that case, I'll think of a way to use the
trick in lm_sensors so that you can access both. (Don't know how at all
for now, we'll see that later.)

Thanks a lot for your feedback. Comments about how the detection works,
how the driver works, how accurate/useful the docs are, are always
welcome :)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

-------------------------------------------------
This mail sent through IMP: http://horde.org/imp/
