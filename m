From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 08 Jun 2005 16:16:31 +0000
Subject: [lm-sensors] w83627ehf driver development
Message-Id: <P7YICdhs.1118239607.6044070.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <797de5c30506080513d85ee5e@mail.gmail.com>
In-Reply-To: <797de5c30506080513d85ee5e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Cadu,

> Sorry for my delay... In the last weeks I was very busy, but I've
> worked in the driver on free time, and I have some questions:
>
> 1) Should the chip driver calculate the real voltage values or just
> put the values read from the device in the data struct?

The theory is that the driver should reflect the voltage values at the
pins on the chip.

Where voltages are scaled externally, the driver should expose the raw
register reading (multiplied by the MSB value, of course). Where the
voltages are scalled internally, the theory is that the driver should
scale them and expose the final value. This is the case of VCC and VSB
for the W83627EHF, both of which are divided by 2 internally. However,
this wasn't done in the other Winbond chip drivers so far (VCC is
handled as if it were scaled externally), so you are relatively free to
do it either way. This might be a good opportunity to finally do it
right though.

> 2) How can I add the voltage values in the lm_sensors w83627ehf lib?
> I've looked at the code, but it has some defines with some numbers
> that I can't see any logic. What do those numbers mean?

Admittedly, this code isn't too readable, especially since one part is
only meant for Linux 2.4 and not used for Linux 2.6-only drivers (which
is the case of the W83627EHF). There is a bit of comments at the top of
lib/chips.c, which may help you figure out what each field is for.

The easiest approach would be to start from what I already did for the
W83627EHF temperatures and fans.

First, add arbitrary IDs for the new features in lib/chips.h. Any value
between 1 and 255 is OK, but you cannot use the same twice for a given
chip. It is also a convenient trick to pick contiguous values for
similar features (in0 to in7 for example), this allows some code
optimization.

Then in lib/chips.c, add one block per new feature in
w83627ehf_features[] (using the ID symbol you just defined), set the
correct label (e.g. "in0", "in0_min", ...). The two mapping fields
define the relations between features, both from a numerical point of
view and a logical point of view. See the values set for the other chips
and you should figure out what to put in there. Then you have the
permission, either R for read only or RW for read/write. Make sure it
matches the driver's sysfs file modes. Next field is unused for
2.6-only drivers, put NOSYSCTL. Next one is for Linux 2.4 too, you can
just put VALUE(1) everywhere for now. Last comes the magnitude (or
number of decimal places). Set it to 3 for voltages.

Taking a look at what was done for the W83781D chip may provide good
hints.

For example, here are the lines I would add for in0 in w83627ehf:

    { SENSORS_W83627EHF_IN0, "in0", NOMAP, NOMAP,
                        R, NOSYSCTL, VALUE(3), 3 },
    { SENSORS_W83627EHF_IN0_MIN, "in0_min", SENSORS_W83627EHF_IN0,
                        SENSORS_W83627EHF_IN0, RW,
                        NOSYSCTL, VALUE(1), 3 },
    { SENSORS_W83627EHF_IN0_MAX, "in0_max", SENSORS_W83627EHF_IN0,
                        SENSORS_W83627EHF_IN0, RW,
                        NOSYSCTL, VALUE(2), 3 },

I hope it helps.
--
Jean Delvare
