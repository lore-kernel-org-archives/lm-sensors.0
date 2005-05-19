From: sascha@akv-soft.de (Sascha Volkenandt)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: Update: SAA1064
Message-Id: <200307191214.20435.sascha@akv-soft.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307162122.07079.sascha@akv-soft.de>
In-Reply-To: <200307162122.07079.sascha@akv-soft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

At Samstag, 19. Juli 2003 09:50 you wrote:
> > I'll check that again, if this is the case all could be reduced to
> > one tri-state sysctl (0=display all four digits, 1=display 1+3,
> > 2=display 2+4). What do you think?
>
> I'm not sure. I read the datasheet again, and I find a total of 7
> possibilities, not 3 as you seem to think. I even took a sheet of paper
> and a pencil to draw a nice table. Yes, really. I can scan it and send
> it to you if you want ;) In the meantime, I'll try to recap my findings
> here.
>
> [...]

I've checked this, and - well your assumptions were not quite correct (for 
static mode) - neither were mine :-). I don't know why this might have been 
implemented, here are the results:

C2C1C0  1 2 3 4
static
 0 0 0  8   8
 0 1 0  8   8
 1 0 0  8   8
 1 1 0  8   8

dynamic
 0 0 1
 0 1 1  8   8
 1 0 1    8   8
 1 1 1  8 8 8 8

The only difference is, that in static mode the digits are slighty brighter 
than in dynamic mode (even when only displaying two digits).

I think just leaving them out and using dynamic mode with all digits lit 
might be just fine, unless anyone tells me he actually needs this.

> Oh of course, it's all clear to me know. That's rather logical. Anyway I
> guess I'll end up reading the I2C specs (at least this part) to know
> more about the different modes, and what happens if one uses a mode the
> chip does not particularly like. I really would like to know that,
> because that's what I do for the SAA1064 in sensors-detect. I use the
> READ_DATA_BYTE mode while the SAA1064 want READ_BYTE mode. I wonder what
> will happen... Well, you tell me when you try ;)

I guess this chip just ignores any read-address, since all reads (with 
read-address and without) result in 0x80 if the device has just been 
powered up, 0x00 otherwise.

> The PCF8574 has a readable register, really? Could not find in in the
> datasheet. That could help me detect it in sensors-detect... (Some
> reading after) Hm, it ain't a register but the I/O value, so I can't
> assume anything about it. It can have any value and even change if it is
> in input mode (I'm not sure I really understand how input vs. output
> works though).

I think it is implemented by setting an output bit to "1" , then re-reading 
it and it will change to "0" when pulled to GND. Just an assumption from 
what I remember about that subject :-)

> Of course. You know it could increase your disk usage by up to 180%? :/
> My perl package uses 18MB. You don't need all the modules though, and I
> guess you'll remove the whole think as soon as the tests are over.

I think I'll have two installations, then I can zip the large one whenever I 
don't need it. Who knows what changes after I delete it :-)

Greetings,
Sascha
