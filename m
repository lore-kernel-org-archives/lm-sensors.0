From: forest@alittletooquiet.net (Forest Bond)
Date: Wed, 21 Mar 2007 18:05:03 +0000
Subject: [lm-sensors] Fintek F71805F on Jetway 627FWE1G
Message-Id: <20070321180503.GH19205@storm.local.network>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070321155103.GD19205@storm.local.network>
In-Reply-To: <20070321155103.GD19205@storm.local.network>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Mar 21, 2007 at 06:32:19PM +0100, Jean Delvare wrote:
> Forest,
> 
> On Wed, 21 Mar 2007 12:58:21 -0400, Forest Bond wrote:
> > On Wed, Mar 21, 2007 at 05:21:04PM +0100, Jean Delvare wrote:
> > > Another possibility is that this is a labelling issue, and one of the
> > > other two temperatures is actually the CPU temperature. You said that
> > > "the other two temperatures appear to be reasonable" but you didn't
> > > give us the actual numbers. Please copy the output of "sensors" so that
> > > we get an idea. You also did not tell us what CPU model it was.
> > 
> > Well, the other two temperatures happen to be giving me room-temperature
> > readings (the mainboard is not in a case), and this is the one that rises
> > quickly when I unplug the CPU fan :)
> > 
> > sensors output and /proc/cpuinfo are attached.
> 
> > CPU Temp:     +0 C  (high =  +255 C, hyst =    +0 C)         [diode]
> < Sys Temp:    +35 C  (high =  +255 C, hyst =    +0 C)         [thermistor]
> > Aux Temp:    +35 C  (high =  +255 C, hyst =    +0 C)         [thermistor]
> 
> Hmm, 35 degrees C in your room? Where do you live? :) Do temp2 and
> temp3 change at all?

Sorry, I live in a non-Celsius country, and didn't realize how hot that is. :)

Those temperatures do fluctuate, however, and the readings from them are
approximately the same temperatures I was getting from a laser temperature gun
on the surface of the mainboard.

> So this "0 degree C" for CPU is raising on load / fan unplug? Up to
> what value?

Yes, it does climb up to the 30-40 C range, at least, when I run my CPU burn
utility and unplug the CPU fan momentarily.  I don't recall the exact value, but
it did seem to be a typical fluctuation (under the circumstances).

I imagine that value gets chopped at zero rather than going negative.  When I
grabbed the data, the CPU burn utility was not running, and the CPU fan was on.
I didn't realize until after that that the CPU temperature was being reported as
0C.

> > > If you could know for sure which temperature channel is connected to
> > > what, it would help. You might get a first idea by checking in the
> > > BIOS, and comparing the hardware monitoring information there with what
> > > "sensors" displays.
> > 
> > This BIOS does display temperature and voltage information at boot time.  Is
> > your intent simply for me to match up the readings with those read by
> > sensors?  I am confident that the reading in question is, in fact, the CPU
> > temperature.  Or do I misunderstand?
> 
> If you think the labels are correct, alright. However, you still want
> to compare temperature values themselves. How many temperatures does
> the BIOS display? What are the values?

The BIOS displays two temperatures:

CPU Temp: 12 C
System Temp: 37 C

What do you suppose is the third temperature I see from sensors?  Could it be a
duplicate reading of the system temperature?  Or is the BIOS just ignoring a
temperature sensors for some reason?

> > > You can also dump the contents of the F71805F chip to find out if
> > > temperature offsets have been set by the BIOS. Assuming that the
> > > F71805F lives at the standard address 0x290, you would run:
> > > 
> > > isadump 0x295 0x296
> > > 
> > > And look at the values of registers 0x90, 0x91 and 0x92.
> > 
> > Output of "isadump 0x295 0x296" is attached.  I am not quite sure how to
> > interpret that, but I belive it is indicating that an offset of 0x5d is being
> > applied to temp1, while temp2 and temp3 are being read as-is.  (Assuming the
> > chip is indeed at that address).
> 
> Yes, the chip is at that address, as can be seen in the first line of
> sensors' output.
> 
> You are correct, an offset is applied to temp1. This is a 7 bit value
> in 2's complement format, so 0x5d translates to... -33 degrees C. What
> an offset, no surprise that you get really low values.
> 
> You can reset the offset using the following command if you want:
> 
> isaset 0x295 0x296 0x90 0x00
> 
> Now the question is, why is Jetway setting this offset? A question you
> want to ask to your technical contact. This indeed looks like a BIOS
> issue.

Agreed.  I will pose this question to my contact at Jetway, and perhaps we can
get to the bottom of this.

Thanks again for your time, Jean.

-Forest
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: Digital signature
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070321/4e910bc2/attachment.bin 
