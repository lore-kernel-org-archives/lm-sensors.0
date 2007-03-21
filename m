From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 21 Mar 2007 17:32:19 +0000
Subject: [lm-sensors] Fintek F71805F on Jetway 627FWE1G
Message-Id: <20070321183219.0b1287c1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070321155103.GD19205@storm.local.network>
In-Reply-To: <20070321155103.GD19205@storm.local.network>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Forest,

On Wed, 21 Mar 2007 12:58:21 -0400, Forest Bond wrote:
> On Wed, Mar 21, 2007 at 05:21:04PM +0100, Jean Delvare wrote:
> > Another possibility is that this is a labelling issue, and one of the
> > other two temperatures is actually the CPU temperature. You said that
> > "the other two temperatures appear to be reasonable" but you didn't
> > give us the actual numbers. Please copy the output of "sensors" so that
> > we get an idea. You also did not tell us what CPU model it was.
> 
> Well, the other two temperatures happen to be giving me room-temperature
> readings (the mainboard is not in a case), and this is the one that rises
> quickly when I unplug the CPU fan :)
> 
> sensors output and /proc/cpuinfo are attached.

> CPU Temp:     +0 C  (high =  +255 C, hyst =    +0 C)         [diode]
< Sys Temp:    +35 C  (high =  +255 C, hyst =    +0 C)         [thermistor]
> Aux Temp:    +35 C  (high =  +255 C, hyst =    +0 C)         [thermistor]

Hmm, 35 degrees C in your room? Where do you live? :) Do temp2 and
temp3 change at all?

So this "0 degree C" for CPU is raising on load / fan unplug? Up to
what value?

> > If you could know for sure which temperature channel is connected to
> > what, it would help. You might get a first idea by checking in the
> > BIOS, and comparing the hardware monitoring information there with what
> > "sensors" displays.
> 
> This BIOS does display temperature and voltage information at boot time.  Is
> your intent simply for me to match up the readings with those read by sensors?
> I am confident that the reading in question is, in fact, the CPU temperature.
> Or do I misunderstand?

If you think the labels are correct, alright. However, you still want
to compare temperature values themselves. How many temperatures does
the BIOS display? What are the values?

> > You can also dump the contents of the F71805F chip to find out if
> > temperature offsets have been set by the BIOS. Assuming that the
> > F71805F lives at the standard address 0x290, you would run:
> > 
> > isadump 0x295 0x296
> > 
> > And look at the values of registers 0x90, 0x91 and 0x92.
> 
> Output of "isadump 0x295 0x296" is attached.  I am not quite sure how to
> interpret that, but I belive it is indicating that an offset of 0x5d is being
> applied to temp1, while temp2 and temp3 are being read as-is.  (Assuming the
> chip is indeed at that address).

Yes, the chip is at that address, as can be seen in the first line of
sensors' output.

You are correct, an offset is applied to temp1. This is a 7 bit value
in 2's complement format, so 0x5d translates to... -33 degrees C. What
an offset, no surprise that you get really low values.

You can reset the offset using the following command if you want:

isaset 0x295 0x296 0x90 0x00

Now the question is, why is Jetway setting this offset? A question you
want to ask to your technical contact. This indeed looks like a BIOS
issue.

-- 
Jean Delvare

