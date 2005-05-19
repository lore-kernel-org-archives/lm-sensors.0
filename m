From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:31 +0000
Subject: adding support for new 2.6 chips in (lib)sensors
Message-Id: <20031230230453.1a972e50.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031230214411.6eb029e7.khali@linux-fr.org>
In-Reply-To: <20031230214411.6eb029e7.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> let me try again.
> They already have 2.4 support, right?

Ja ja ;)

> In that case, for every sysfs entry that is "non-standard"
> (i.e. not covered by the conversion routine getsysname() in
> lib/proc.c), add the name of the sysfs entry at the end of the entry
> in lib/chips.c. If the magnitude is non-standard, add it as well.

The amazing thing is that all entries *have* standard names:

alarms
temp_crit1
temp_crit2
temp_input1
temp_input2
temp_max1
temp_max2
temp_min1
temp_min2

So I would have expected everyting to work out of the box - but it
doesn't. Any clue where I should start digging?

A few random notes BTW:

* I think there's a typo at lib/proc.h:438.

* What's the reason for doing:
  if(sscanf(name, "temp%d_ove%c%c", &num, &last, &check) = 2
     && last ='r')
instead of
  if(sscanf(name, "temp%d_over%c", &num, &check) = 2)
? I understand that you want to make sure that there's nothing after
"other" with the &check trick, but I don't see why you would also need
the &last trick for this. Anything obvious I'm missing?

* I'm seeing a strange behavior with the eeprom module for on my Vaio
(i.e. non-memory) eeprom. Usually sensors will say "Memory type:
Unavailable" (it's obviously not noticing this isn't a regular memory
eeprom). But it sometimes will succeed and print the expected,
vaio-specific data. I didn't investigate any further, but there must be
a bug hiding somewhere.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
