From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: LM83 test results
Message-Id: <20030806213010.73890fc1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030806122107.6d678b30.khali@linux-fr.org>
In-Reply-To: <20030806122107.6d678b30.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



> > There are many devices. 0x50 to 0x57 are eeproms (real or fake, that
> > I can't tell).
> 
> How can you tell that they are EEPROM:s.?

I can't be sure, but chips found at this address are usually EEPROMs
(and that's what sensors-detect think it is). The only other device
known to be possibly found at this address are EDID data, but it is only
found on video card i2c busses. And the four first ones seem to be real
SPD EEPROMs found on your memory modules, although the checksums are
bad. You may want to give a try to decode-dimms in prog/eeprom.

I don't know about the four other EEPROMS, and I wouldn't play with them
for safety reasons. It's unlikely you'll find anything useful there
anyway, so it's not worth the risk.

> 
> > are really mysterious. If you are curious, you could run "i2cdump 0
> > 0x20" and see if it returns anything interesting. 
> # dump/i2cdump 0 0x20

Nothing useful there, it doesn't seem to be a real device. I've never
seen such a thing before.

Maybe you could try 0x21, 0x22 and 0x23 too, but they are likely to
behave the very same.

> > > I have been told that "Sensor D1 reads the CPU die temperature,
> > > the local sensor reads the LM83's own temperature. Sensors D2 and
> > > D3 measure nothing." 
> > 
> > Who told you that? 
>
> I got that from an e-mail originating from the manufacturer.

You managed to buy a product from a company with a real support?
Congratulations ;) Who are they? I couldn't find any reference using
Google.

> > Am I right guessing you have always seen temp2=temp3=temp4?
> 
> No that was just a lucky shot in my original e-mail!

OK.

> > Do you have any
> > reason to believe you must have a real LM83, apart from the fact
> > that sensors-detect told you so?
> 
> Yes from the manufacturer e-mail and now from the fact that I get 
> different readings.

You convinced me :)

> > Don't you have the possibility to open the box and check? (You could
> > check what your sensor chip really is BTW.)
> 
> No I can't (at least not easily). The machine is in a lab at work to 
> which I dont have (physical) access to.

OK, no problem.

> # sensors/sensors -A lm83-i2c-0-19
> lm83-i2c-0-19
> temp1: +36?C (limit = +80?C) 
> temp2: +35?C (limit = +90?C) 
> temp3: +41?C (limit = +100?C) 
> temp4: +50?C (limit = +110?C) 

OK, it has to be a LM83 then. But I'd say the support guy was wrong, D1
can't be the CPU temp, it has to be D2 or D3. And all channels are used.
Maybe D1 and D2 are for the north and south bridges? Just guessing. If
you can figure out, let us know.

> 
> # dump/i2cdump 0 0x19 b
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f   
> 00: 24 26 00 00 00 50 50 64 64 64 64 64 64 64 64 64   
> 10: 64 64 64 64 64 64 64 64 64 64 64 64 64 64 64 64  
> 20: 64 64 64 64 64 64 64 64 64 64 64 64 64 64 64 64   
> 30: 21 22 22 22 22 00 00 00 5a 5a 6e 6e 6e 6e 6e 6e  
> 40: 6e 6e 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f   
> 50: 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f  
> 60: 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f   
> 70: 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f  
> 80: 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f   
> 90: 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f  
> a0: 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f   
> b0: 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 
> c0: 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f   
> d0: 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f  
> e0: 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f   
> f0: 00 85 18 35 26 26 26 00 38 25 24 24 24 24 01 03  

That's very interesting. See how the limits appear not only in one, but
many registers. I had never seen this behavior. Could be used for
detection purpose (although we already have a reliable detection
mechanism now, thanks to you).

The last byte, 0x03, has to be the device ID for the LM83. I have been
asking National Semiconductors for this value, because it is missing
from the LM83 datasheet. They were *unable* to tell me. They designed
and produced the chip, and couldn't tell the ID. Wonderful, isn't it?
And there you come, and you succeed where they failed. My messiah ;)

> Ahh! I was looking for 35 not 0x23

And this was an easy one. Sometimes conversions are much more complex
than that!


> Probing for `National Semiconductor LM83'... Success!
>     (confidence 7, driver `lm83')

I'll now be able to raise the confidence level to 8, now that I know the
device ID :)

Thanks a lot.

Next steps:

1* I'll update the detection procedure for the LM83.

2* You can checkout lm_sensors CVS and give it a try. I've improved the
lm83 driver there (smaller and faster).

3* I'll add the missing functionalities to the driver within a few days.
When it's ready, I'll commit it to CVS and ask you to test it.

Thanks a lot for your great help!

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
