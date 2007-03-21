From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 21 Mar 2007 16:21:04 +0000
Subject: [lm-sensors] Fintek F71805F on Jetway 627FWE1G
Message-Id: <20070321172104.0c2a8141.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070321155103.GD19205@storm.local.network>
In-Reply-To: <20070321155103.GD19205@storm.local.network>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Forest,

I am the author of the f71805f driver.

On Wed, 21 Mar 2007 11:51:03 -0400, Forest Bond wrote:
> I am getting what appear to be incorrect temperature readings for the CPU on a
> 627FWE1G mainboard, which has an F71805F.  The other two temperatures appear to
> be reasonable, but the CPU temperature appears to be low (although it does seem
> to scale appropriately in response to CPU burn-in, momentarily disconnecting the
> fan, etc.).
> 
> From the documentation:
> 
> --------------------------------------------------------------------------------
> All temperature channels are external, there is no embedded temperature
> sensor. Each channel can be used for connecting either a thermal diode
> or a thermistor. The driver reports the currently selected mode, but
> doesn't allow changing it. In theory, the BIOS should have configured
> everything properly.
> --------------------------------------------------------------------------------
> 
> I'm wondering if the BIOS did not configure the sensor properly, although
> the sensors program reports that the sensor is configured as a diode (which, I
> believe, is correct).

If the type was improperly selected, you wouldn't see the reading
scaling properly as you report. So chances are good that this is indeed
a thermal diode that is connected.

> Is it possible that the diode is not characterized correctly?

Yes, this is possible. Hardware monitoring chips are typically meant to
be used with one given type of thermal diode, and where a different
type is used, the measurements have to be corrected. If the correction
is a simple offset, it can be done by the F71805F itself, otherwise it
must be done in software.

Another possibility is that this is a labelling issue, and one of the
other two temperatures is actually the CPU temperature. You said that
"the other two temperatures appear to be reasonable" but you didn't
give us the actual numbers. Please copy the output of "sensors" so that
we get an idea. You also did not tell us what CPU model it was.

> I have a technical contact at Jetway that may be able to assist.  Should I
> pursue this as a BIOS issue, or ought I seek information with regard to how the
> circuit is physically wired?

If you could know for sure which temperature channel is connected to
what, it would help. You might get a first idea by checking in the
BIOS, and comparing the hardware monitoring information there with what
"sensors" displays.

You can also dump the contents of the F71805F chip to find out if
temperature offsets have been set by the BIOS. Assuming that the
F71805F lives at the standard address 0x290, you would run:

isadump 0x295 0x296

And look at the values of registers 0x90, 0x91 and 0x92.

-- 
Jean Delvare

