From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:26 +0000
Subject: Call for 2.9.0
Message-Id: <mKaZ7VtI.1102586654.1079040.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041208224836.7794b56c.khali@linux-fr.org>
In-Reply-To: <20041208224836.7794b56c.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


On 2004-12-09, Mark Studebaker wrote:

> 1) are you working on sensors README/QUICKSTART/INSTALL updates or are you
> looking for volunteers?

You're right, the documentation needs updates. Volunteers are of course
very welcome.

One thing we would need to discuss is whether we want to go on pretending
that we support kernels down to 2.4.9. Last time I checked, anything
before 2.4.17 would simply not compile. Given that kernels 2.4.11 and
2.4.15 were not even usable, I see little benefit in supporting any
kernel before 2.4.16, and even this one doesn't seem to be much used
anyone (thanks god). Thus I think it'd be more simple to simply say we
support kernels 2.4.17+.

If anyone were really interested in restoring support for the
2.4.9-2.4.16, i guess we would have received patches to do that. We
simply don't have the "internal" resources needed to check and/or
restore compatibility with older kernels ourselves, it seems.

> 2) i2c-virtual and pca954x are checked in but not in the Makefiles,
> pending i2c-core changes required.

Strange order, huh?

> I can do the core changes before or after 2.9.0. Attached is the i2c-core
> patch, slimmed down from that received from Brian Kuschak.
> It's really only two changes:
>  - creating xxx_nolock versions of some calls
>  - working up the bus tree for busy checks, using i2c_virt_parent()

Irk! How exactly is i2c-core supposed to know i2c_virt_parent when it's
defined by lm_sensors? How is it even supposed to know about
CONFIG_I2C_VIRTUAL (and what is CONFIG_I2C_VIRTUAL_MODULE?)? Looks like
a circular dependency issue to me.

Also, i2c-core should NOT export nolock functions. These functions (much
like
__i2c_check_addr) are meant for internal use only (thus the leading
underscores in the name, which should be used for the new functions as
well). Locks are implementation details not supposed to be even known by
the external users.

> Not sure I like the i2c_virt_parent() hack (see
> kernel/include/i2c-virtual.h in sensors for the definition) and trying
> to think of a better way to do it.

How exactly is it a hack?

> Anyway, comments on the patch and on the timing (before or after 2.9.0)
> welcome.

Definitely after. Doesn't sound correct to me at all, to say the truth.
It looks like things that would need to belong to the i2c-core were
added in lm_sensors instead.

Could you please summarize the approach that you are following, or point
me to an up-to-date document covering this if such a document exists? I
would like to understand how it would be implemented at the i2c-core
level, what interface it would expose to the other kernel drivers, and
if possible a real-world use case (an equivalent of i2c-amd756-s4882
using i2c-virtual would be great, for example.)

I'm suspicious about how this approach is better than what I did for the
S4882 motherboard, which didn't require any change to the i2c-core. As
I understand it, even with Brian's virtual busses, one would still have
to write a pseudo bus driver for each specific multiplexing design
(since such designs cannot be easily guessed and multiplexer chips are
hard to detect anyway). The only drawback of my approach is that I had
to export the original bus driver's i2c_adapter structure. Even that
might be worked around by simply providing a search-adapter-by-id
function in i2c-core (although with a slight loss of performance.)

Remember that bus multiplexing is only needed for a very limited number
of motherboards and a couple proprietary designs. This accounts for a
very limited total number of users and as such isn't worth breaking
working concepts or compatibility. I'm sorry to insist but I fear that
what you (and Brian) are trying to implement would belong to Linux 2.6,
not 2.4.

Thanks,
--
Jean Delvare
