From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 24 Jul 2009 07:21:42 +0000
Subject: Re: [lm-sensors] What do I log if I'm not sure about the compute
Message-Id: <20090724092142.108f9feb@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.64.0906220138120.9018@birdbird.example.com>
In-Reply-To: <Pine.LNX.4.64.0906220138120.9018@birdbird.example.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Matt,

On Thu, 23 Jul 2009 23:04:17 -0500 (CDT), Matt Roberds wrote:
> On Tue, 21 Jul 2009, Jean Delvare wrote:
> > Out of curiosity, which monitoring chip is it? Not all chips require
> > compute statements.
> 
> sensors-detect says "Winbond W83627EHF/EHG Super IO Sensors" at 0x290,
> driver w83627ehf .  (Note that this is lm-sensors 2.x; I have to use
> the packaged version that is already on the machine.)  I haven't
> opened up the case to see what chip is actually there, but this
> driver provides plausible results so far.

The Winbond W83627EHF/EHG Super-I/O detection is fairly reliable, so if
sensors-detect says this is what you have, I'd trust that.

This chip has no internal voltage scalers and thus indeed needs
external resistors and matching compute statements in your
configuration file. That being said, many voltages are taken from the
chip's own power supplies rather than dedicated pins, so these are
always correct:

    label in2 "AVCC"
    label in3 "VCC"
    label in7 "3VSB"
    label in8 "Vbat"

    set in2_min  3.3 * 0.90
    set in2_max  3.3 * 1.10
    set in3_min  3.3 * 0.90
    set in3_max  3.3 * 1.10
    set in7_min  3.3 * 0.90
    set in7_max  3.3 * 1.10
    set in8_min  3.0 * 0.90
    set in8_max  3.0 * 1.10

And in all cases I've seen in0 is used for the CPU Vcore. This only
leaves you with in1, in4, in5, in6 and in9 to discover the mapping and
scaling factors thereof, and odds are that these include at least +5V
and +12V, and possibly 5VSB and Vdimm that need scaling. The rest (e.g.
Vagp) wouldn't need scaling. If your BIOS displays voltage values it
shouldn't be too hard to find out +5V and +12V.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
