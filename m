From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: Call for 2.8.1
Message-Id: <20030815233532.3e147cce.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


No, it ain't a joke.

First, the change list for lm_sensors is already quite long. Two new
drivers, and two drivers almost rewritten, and loads of fixes.

Second, we want i2c integrated into the linux 2.4.23 kernel. And I don't
think we want it to be "the CVS at day 2003-X-Y". It's far better if a
known, numbered version is integrated, because this makes fixes
backports far easier then. I think Greg will confirm the integration
will be more easily accepted this way.

So I'd like us to setup a checklist for the 2.8.1 release. Three things
come to my mind now:

1* Eeprom driver's Vaio issue. Greg has suggested a change there and I
want to give it a try. So this one is for me.

2* Makefile cleanups. There are at least two reports of incorrectnesses
in lm_sensors' Makefile, I want this fixed before the next release. If
nobody does it, I'll do (but I think MDS knows it better than I do.)

3* MMH, what about your ASB100 driver? How far is it from completion?

Feel free to add things here.

So the plan is:

1* Wait for linux-2.4.23 to be released. (the easy part)

2* Release i2c & lm_sensors 2.8.1. (Phil's job (note that I *already*
bumped the lib version, so don't bump it again))

3* Rebuild the patches. (My job)

4* Submit them for inclusion (Greg and me on this)

Any objection?

One final note. I'll be off tomorrow for a not-yet-known duration.
Probably one week, but could be more. Hopefully MDS and I will be back
at about the same time, and we'll be able to help enough to make
everything ready in time. In the meantime, I'll have very, very limited
Internet access, so you'll just have to do without me.

See you later, all.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
