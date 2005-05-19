From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: [PATCH 2.6] add alternate VCORE calculations for w83627thf and
Message-Id: <200406090827.i598RvKk087247@zone3.gcu-squad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040606025430.GC10118@jupiter.solarsys.private>
In-Reply-To: <20040606025430.GC10118@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


>> (As a side note, I don't much see the interest of DEFAULT_VRM. Having
>> the same default for all chips doesn't make much sense since older chips
>> will most likely need VRM8 and newer chips will most likely need VRM9.
>> So I'd propose to get rid of that define and let every driver pick
>> whatever is relevant.)
>
>Err, why don't we just read the CPU type out of /proc and set the VRM
>accordingly during 'sensors -s'... entirely in userspace?

You seem to suggest that each CPU type can only work with one VRM
version. Are you sure?

The CPU type information is also available in kernel-space, maybe even
more easily (no parsing required), and I believe that setting the VRM
from the CPU type belongs to the driver (once, at init time). I don't
see how you are going to do that in "sensors".

>> Maybe it would also make sense to (physically) change this configuration
>> bit whenever the user changes VRM versions? We certainly want VID pins
>> and in0 reading to refer to the same VRM version.
>
>Why?  The interpretation of the VID pins has nothing to do with that of
>in0; I see the in0 calculation mode as just a driver-internal detail.

I admit these are two different things, but both are supposed to depend
on which VRM version is used. The fact that in0 calculation can be
changed is admittedly specific to these chips, but I doubt they called
the register "VRM config" without a reason. Thus my suggestion, mainly
based of the (wrong) idea that motherboard manufacturers would be
logical folks ;) Something we cannot rely upon, so you can just forget
about what I said.

>Also, to force them in sync would require that writing to VRM also updates
>the in0 min and max... not impossible of course, just not worth it.

All in all, this configuration bit is no different from fan clock
dividers. It's a range vs. resolution tradeoff, not strongly related to
VRM. It just happens that VRM9 voltages will necessarily fit in the
shortest range, while VRM8 ones don't necessarily do.

Jean Delvare
