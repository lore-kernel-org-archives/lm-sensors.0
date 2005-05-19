From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: [PATCH 2.6] add alternate VCORE calculations for w83627thf and
Message-Id: <20040610022839.GB2596@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040606025430.GC10118@jupiter.solarsys.private>
In-Reply-To: <20040606025430.GC10118@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Jean Delvare <khali@linux-fr.org> [2004-06-09 10:27:57 +0200]:
> >> (As a side note, I don't much see the interest of DEFAULT_VRM. Having
> >> the same default for all chips doesn't make much sense since older chips
> >> will most likely need VRM8 and newer chips will most likely need VRM9.
> >> So I'd propose to get rid of that define and let every driver pick
> >> whatever is relevant.)
> >
> >Err, why don't we just read the CPU type out of /proc and set the VRM
> >accordingly during 'sensors -s'... entirely in userspace?
> 
> You seem to suggest that each CPU type can only work with one VRM
> version. Are you sure?

Well, I wasn't sure at first. But later, I looked at some Intel docs which
say that the VID signals come right from the processor package itself (1).
So now I'm sure.

> The CPU type information is also available in kernel-space, maybe even
> more easily (no parsing required), and I believe that setting the VRM
> from the CPU type belongs to the driver (once, at init time). I don't
> see how you are going to do that in "sensors".

Actually, "sensors -s".  It wouldn't be hard - I mean, it already sets the
VRM based on /etc/sensors.conf.  But you're probably right that it belongs
in the driver; perhaps another shared function of the i2c-sensors module.

Does anyone know how to read CPU id info from kernel space?

(1) http://www.intel.com/design/Pentium4/guides/24920504.pdf (page 8)

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
