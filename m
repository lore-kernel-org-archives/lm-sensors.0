From: delvare@ensicaen.ismra.fr (Jean Delvare)
Date: Thu, 19 May 2005 06:23:29 +0000
Subject: eeprom driver
Message-Id: <Pine.GSO.4.40.0202020143550.19539-100000@e450.ensicaen.ismra.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020201105452.C1871@Stimpy.netroedge.com>
In-Reply-To: <20020201105452.C1871@Stimpy.netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> You can read the contents of the eeproms more directly my looking in
> the directories /proc/sys/dev/sensors/*eeprom*.

Didn't know that (well, I read it in the eeprom module docs but forgot it
one minute later.)  I just had a look at the files.  I compared the data
before and after switching the two memory modules, and it is completely
different.  It didn't helped me a bit understanding what could be wrong.
Where may I find docs to know which values are important?

I noticed an extra file: /proc/sys/dev/sensors/chips
It contains:

256       eeprom-i2c-0-50
257       eeprom-i2c-0-57

Needless to say I am very suprised by the value '257'.  I think this may
be a clue for you, even if it won't help me for now.

I think that another interesting clue would be to understand why the
confidence for this slot was 1 instead of 8.  I'll have a look at it,
although I guess you already have the answer (a wild guess from me would
be: "reading it doesn't give a usual memory size value, but it should
consiedring the address, so we set a confidence of 1 instead of 8".)

> It is possible that that slot is having issues.  Although your
> computer sounds like it is running correctly??  If the eeprom(s) were
> unreadable, then at least that DIMM would not be used for RAM for the
> system since the DIMM contains the timings and such.

Indeed, the memory is perfectly detected and working.

As said before, I will try to have a look at the detection code and maybe
the sensors code itself, but probably won't find anything unless you tell
me where to look at and what to look for.

Thanks.

-- 
       /~~       Jean "Khali" Delvare
  -----\_                        mail: delvare@ensicaen.ismra.fr
 --------\                http://www.ensicaen.ismra.fr/~delvare/
---=ISMRA/- ____________________________________________________
