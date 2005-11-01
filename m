From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 01 Nov 2005 09:04:06 +0000
Subject: [lm-sensors] LM-Sensors for VT8231with 2.6.14 kernel
Message-Id: <20051101090342.21099e57.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051031232026.EE66212E9E@bluewhale.planbit.co.uk>
In-Reply-To: <20051031232026.EE66212E9E@bluewhale.planbit.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Roger,

> I am trying to get the full sensors support on my Via Eden 5000 MoBo.  I was
> running it with Debian Sarge on 2.6.8 and had the vt8231 driver running OK.
> For various reasons I want to upgrade to the latest kernel (2.6.14) and so I
> have compiled this from the kernel source and am trying to get the sensors
> running again.  There is no vt8231 driver in the kernel source release, so I
> have done some digging to try and work out what is going on.
> 
> The whole API situation seems confusing.  Looking at the code provided with
> the kernel for drivers such as the vt686a, there seems to be a lot of
> differences in the API between this code and the code in the latest daily
> snapshot on the lm-sensors site.

This ain't exactly a surprise. The drivers in lm_sensors are meant for
Linux 2.4, not Linux 2.6.

>                                   There is documentation with the kernel
> source "Documentation/i2c/porting-clients" that seems to describe these
> changes, so there is information to work with, but before I start writing
> some C code to port the vt8231 driver to the new API, I would like to make
> sure that I am heading in the right direction and that nobody else is
> already working on this.

This document explains how to port a driver from lm_sensors (Linux 2.4)
to Linux 2.6.14. If you had a the vt8231 driver working OK with Linux
2.6.8, it means that the port from lm_sensors to Linux 2.6 was already
done, and actually I remember that someone (Aaron M. Marsh) posted such
a port to this mailing-list some times ago. Unfortunately it was not
incorporated into the main kernel tree due to a lack of time to review
the proposed code, nothing else. I was expecting Mark D. Studebaler to
do so, as he wrote the original driver and has the hardware to test the
code, but he did not. The driver is still available as patches here:
  http://www.stanford.edu/~amarsh/vt8231/

So it should be much easier to start from there if you want a driver
for Linux 2.6.14. If you do so, feel free to ask questions here about
the interface changes which happened between 2.6.8 and 2.6.14. Looking
at the differences similar drivers (via686a, sis5595) have undergone
during the same period of time should give you good hints to start with.

> Can anyone give me a quick update on what is happening with the vt8231 hwmon
> driver (and even if it is still required and not replaced by something else)
> ?

Nothing replaced it. The patch is simply pending due to a lack of human
resources to review it and push it upwards. If you port the patch to
Linux 2.6.14, please let us know and share your work with us, so that
your work is not duplicated.

Thanks,
-- 
Jean Delvare
