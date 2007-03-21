From: forest@alittletooquiet.net (Forest Bond)
Date: Wed, 21 Mar 2007 16:58:21 +0000
Subject: [lm-sensors] Fintek F71805F on Jetway 627FWE1G
Message-Id: <20070321165821.GE19205@storm.local.network>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070321155103.GD19205@storm.local.network>
In-Reply-To: <20070321155103.GD19205@storm.local.network>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Wed, Mar 21, 2007 at 05:21:04PM +0100, Jean Delvare wrote:
> I am the author of the f71805f driver.

First off, thanks for your time spent on this driver, and thanks for your quick
response.

> On Wed, 21 Mar 2007 11:51:03 -0400, Forest Bond wrote:
> > Is it possible that the diode is not characterized correctly?
> 
> Yes, this is possible. Hardware monitoring chips are typically meant to
> be used with one given type of thermal diode, and where a different
> type is used, the measurements have to be corrected. If the correction
> is a simple offset, it can be done by the F71805F itself, otherwise it
> must be done in software.

> Another possibility is that this is a labelling issue, and one of the
> other two temperatures is actually the CPU temperature. You said that
> "the other two temperatures appear to be reasonable" but you didn't
> give us the actual numbers. Please copy the output of "sensors" so that
> we get an idea. You also did not tell us what CPU model it was.

Well, the other two temperatures happen to be giving me room-temperature
readings (the mainboard is not in a case), and this is the one that rises
quickly when I unplug the CPU fan :)

sensors output and /proc/cpuinfo are attached.

> > I have a technical contact at Jetway that may be able to assist.  Should I
> > pursue this as a BIOS issue, or ought I seek information with regard to how
> > the circuit is physically wired?
> 
> If you could know for sure which temperature channel is connected to
> what, it would help. You might get a first idea by checking in the
> BIOS, and comparing the hardware monitoring information there with what
> "sensors" displays.

This BIOS does display temperature and voltage information at boot time.  Is
your intent simply for me to match up the readings with those read by sensors?
I am confident that the reading in question is, in fact, the CPU temperature.
Or do I misunderstand?

> You can also dump the contents of the F71805F chip to find out if
> temperature offsets have been set by the BIOS. Assuming that the
> F71805F lives at the standard address 0x290, you would run:
> 
> isadump 0x295 0x296
> 
> And look at the values of registers 0x90, 0x91 and 0x92.

Output of "isadump 0x295 0x296" is attached.  I am not quite sure how to
interpret that, but I belive it is indicating that an offset of 0x5d is being
applied to temp1, while temp2 and temp3 are being read as-is.  (Assuming the
chip is indeed at that address).

Thanks again,
Forest
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: Digital signature
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070321/78f49085/attachment.bin 
