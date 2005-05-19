From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: SAA1064 sensors chip driver
Message-Id: <20030718083122.4249864a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307131153.24333.sascha@akv-soft.de>
In-Reply-To: <200307131153.24333.sascha@akv-soft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> That's what I tried to explain - there's only one read register, and
> only one bit matters there :-)

Yeah but you know, I'm kinda stupid, so you have to repeat the things
over and over again before I finally catch it ;)

> Exactly - on first readout (_before_ loading the driver the first
> time, that's why I didn't notice) it says 0x80 in the first byte.

I guess it's a matter of powering the device up, not of loading the
driver.

> > So, the way to detect it now seems clearer:
> >
> > 1* The most basic way is to read the whole range and say it is a
> > saa1064 if all bytes are 0x00 or 0x80 (that is, (a & 0x7F)=0).
> 
> Well - why all bytes? Only the very first read ever returns 0x80.

I was writing about the detection in sensors-detect. The detection
method in the driver and in sensors-detect are of different natures. In
your driver, you just want to know if whan you have *can be* what your
driver supports. So reading, say, 4 times, and expect either "0x80 0x00
0x00 0x00" or "0x00 0x00 0x00 0x00" is just fine. In sensors-detect, we
want to know if what we have is more likely to be one chip that any
other that can possibly exist at the same address. So the fact that the
saa1064 ignores the read address is very interesting. No other chip is
likely to do the same (or at least none that I know of) so either if
reading all bytes makes no sense for the saa1064, it would make sense
for other chips, and these other chips are unlilely to have 0x00 bytes
everywhere. So the saa1064 detection should be rather good.
> 
> > 2* We can give it a greater confidence if the first read returns
> > 0x80 and the later ones return 0x00. I do something similar for the
> > lm75
> 
> Yup that's what I thought, too - 0x80 followed by 0x00

Again, this is for sensors-detect. You don't have any confidence idea in
the drivers.

> The PCF8574A uses the range 0x38 to 0x3f, and detects a saa1064 as a 
> pcf8574a when loaded first.

I didn't know that. I just checked sensors-detect and the pcf8574a isn't
supported. I think I will take a look at the datasheet and add detection
to sensors-detect. I'll also see if I can enhance the detection for the
pcf8591. The more devices we detect in sensors-detect, the better, even
if they are not sensors, and even if we wouldn't have drivers for them.
It lowers the risk of misdetection for the other chips.

> I'll put the two-byte-sequence (0x80 followed by 0x00) into the
> module.

No, don't do that. You have to load the module even if the device wasn't
freshly powered up. The method I suggest is reading four times, and
accept to load if the first read returns either 0x80 or 0x00 (that is,
(a & 0x7f)=0), and the three other reads return 0x00. As said earlier,
you don't have to load if and only if it is a saa1064. You have to load
if it *behaves like* a saa1064.

Of course, if the force parameter is used (kind>=0), you have to skip
the detection.

> Maybe you'll do something for sensors-detect?

Yeah, no problem. I'll let you know when it's done.

> I hope this weekend I'll find time to finish "the rest" (in-module 
> detection, doc, and finally a complete patchset).

OK.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
