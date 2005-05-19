From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:13 +0000
Subject: Eeprom driver optimization
Message-Id: <20030823205918.51e747fa.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030816141351.76899190.khali@linux-fr.org>
In-Reply-To: <20030816141351.76899190.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I would suggest that the chance of eeprom contents changing during
> normal running is *very* small.
> 
> Therefore, you could set the refresh time to be *very* long by default
> (and make it configurable if the VAIO BIOS is changing the eeprom
> underneath us. Gosh I hope not...)  Say 10 minutes or more.  Then read
> the contents once, and cache the results.

That solves the further reads, agreed. But that's not my concern here.
What I'm trying to enhance here is the initial read time. It may sound
pointless because it's only the first time, but I believe it's important
because that's how much the users have to wait the first time they run
sensors. We *know* that it's longer than further calls, but the user
doesn't. 

> An alternative would be to just divide the eeprom into 16-byte subsets
> and assign a refresh timer to each.  This matches the /proc
> organization pretty well. (16 bytes per file)

Great, that's almost the solution I went to. Since I was offline while
working on the problem, I took some notes. Here they are:

****************

Here are the rows that are accessed by sensors (I start counting with
row 1):
sensors::vaio   : 9-10, 13-14
sensors::*      : 1
sensors::edid   : 1
sensors::dimm   : 1-2

Here are the rows that are accessed by our various scripts:
decode-edid.pl  : 1 (failure) 1-8 (success)
decode-vaio.pl  : 2-3, 9-11, 13-16
decode-dimms.pl : 1-4 (failure) 1-8 (success)
decode-xeon.pl  : 1-6, 8

5 strategies
------------

1* No partitioning (as it was before).
   Module size: 3616 bytes (before optimization 1).
   Sensors time (dimm): 2.58s.
   Sensors time (vaio): 2.58s.

2* Smart partitioning (2-2-4-8).
   Per-eeprom memory overhead: 12 bytes.
   Module size: 3456 bytes (before optimization 2).
   Sensors time (dimm): 0.34s.
   Sensors time (vaio): 1.30s.

3* Sensors-oriented partitioning.
   Zone 1 = row 1
   Zone 2 = row 2
   Zone 3 = rows 9-10
   Zone 4 = rows 13-14
   Zone 0 = everything
   Per-eeprom memory overhead: 16 bytes.
   Not tested.

4* Raw partitioning, 1-row slices.
   No zones, sub-partitioning of solution #5 (and therefore of #2).
   Per-eeprom memory overhead: 61 bytes.
   Doesn't significantly speed sensors up (compared with solution #5).
   Not tested.

5* Raw partitioning, 2-row slices.
   No zones, sub-partitioning of solution #2.
   Per-eeprom memory overhead: 28 bytes.
   Module size: 3424 bytes.
   Sensors time (dimm): 0.34s.
   Sensors time (vaio): 0.67s.

Notes about optimizations:
Optimization 1 is removing the big switch/case in the callback function,
and use the sysctl value instead. Faster, cleaner.
Optimization 2 is seeing valid as a bit vector instead of an array.

****************

The version I'll commit to the CVS repository is solution #5. It seems
to be the best speed/memory tradeoff, doesn't depend on a specific use
of eeproms, and is rather straightforward to understand.

The speed improvement is simply amazing, so I guess everyone will like
the change. It would make it possible to lower the buffering time (5
minutes for now), which will be interesting if we want to support write
to eeproms.

(OT: It looks like my I2C bus is working at 2 kHz. Isn't it too slow?
Most chips I've read the datasheets of don't accept running below 10
kHz.)

> But since sysfs is coming soon and Greg KH's proposal is a single
> binary file for eeprom's, I think my first suggestion is better for
> the future...

This raises two questions:

1* Is a monoblock file the best idea? It prevents any speed
optimisation. However, it makes handling easier for sure. Also, what
will be the file size? For now, we don't detect the eeprom size, and I
don't think we can really detect it. Module parameter?

2* Should eeproms be supported by sensors? Eeproms are not sensors. If
we opt for a monoblock file, they will be slow displaying (at least the
first time) as before. And people don't care about them (at least when
running sensors). So I'd suggest we remove eeprom from sensors, and/or
remove it from sensors-detect (so that people get it only if they really
want it). I'd prefer removing eeprom from sensors, so that people can
still load the modules and use the various scripts to get the values
from the eeproms in a much better form than when using sensors. We would
maintain support into libsensors, so that people needing to access the
eeproms have an easy way to do so.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
