From: b-gruber@gmx.de (Berni)
Date: Thu, 19 May 2005 06:24:32 +0000
Subject: lm_sensors && bt869
Message-Id: <2149564019.20040101013639@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031228153744.49065c91.khali@linux-fr.org>
In-Reply-To: <20031228153744.49065c91.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dear Jean Delvare,

am Mittwoch, 31. Dezember 2003 um 22:15 schrieben Sie:

>> Well...I don't actually know what the difference between kernel
>> modules in 2.4 and 2.6 is.

JD> Just to make it clear, the difference we are talking about is somewhat
JD> i2c-chip-drivers specific (although one of the most important changes is
JD> that they now use sysfs instead of procfs, which is a typical 2.4 to 2.6
JD> change).

>> Does the module need to be fully rewritten or do I only have to change
>> parts?

JD> Well, somewhere in the middle. There is much more to do than just a few
JD> trivial changes. Still I don't consider it unfeasable, even for a
JD> newbie, if you can follow a guide and keep track of four files at once
JD> (see below).

>> Could you point me to those docs?

JD> See Documentation/i2c/porting clients in linux-2.6.1-rc1. I suggest that
JD> you follow that guide, with four additional files opened: the old bt869
JD> driver, the new bt869 (that you'll be writing), and the old and new
JD> version of an arbitrary driver that has already been ported (I'd suggest
JD> lm75 or lm83). This is what I did and it works well.

JD> Good luck. Feel free to ask questions as they come.

Well...I think I could manage to change almost everything according to the
guide and other ported files but there where 2 points where I ran into
problems:
1. Section "Detect", Device Creation: Do I have to use names from the
sysfs-interface-doc here? The problem is, that I couldn't find anything
useable here as the bt869 isn't a sensor chip in the traditional
way (it does neither read temperatures nor voltages or whatever...).
2. Quite the same problem is at the point where I have to define show
and set functions: I should use names from the sysfs-interface-doc but
there isn't anything according to the functions which the bt869 has...

Thanks for your help!
Bernhard Gruber
