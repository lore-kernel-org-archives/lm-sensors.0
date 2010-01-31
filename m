From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 31 Jan 2010 13:26:27 +0000
Subject: Re: [lm-sensors] "No sensors found!" on Intel Entry Storage System
Message-Id: <20100131142627.6a11495e@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1251523453.13079.32.camel@Ubuntu>
In-Reply-To: <1251523453.13079.32.camel@Ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Lou,

On Sun, 31 Jan 2010 14:05:24 +0100, Jean Delvare wrote:
> On Sat, 30 Jan 2010 15:27:21 -0500, Lou Gosselin wrote:
> > The email didn't specify the range to dump, but thanks for the advice.
> > I'm attaching the output for 0x2e.
> > Let me know if you'd like anything else.
> 
> I've looked at the dump, and the device ID is 0x69 as expected by the
> driver. So this wasn't the problem.
> 
> Then I've read the thread again, and I see you're running kernel
> 2.6.26. Our wiki improperly claims that support for the SCH5027 was
> added in kernel 2.6.26, but looking at the code, this isn't true.
> Support for your chip was added in kernel 2.6.27. So this is no
> surprise that the dme1737 kernel driver on your system did not
> recognize your chip: it doesn't support it (yet).
> 
> I've fixed the wiki. If you want support for your chip, you'll have to
> either upgrade your kernel to >= 2.6.27, or backport the dme1737 driver
> to your kernel. The version in kernel 2.6.27 should do just fine on
> 2.6.26:
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob_plain;f=drivers/hwmon/dme1737.c;hbT9edb83327f2a5027a22d65b10603b01dc40175

And here you go...
http://khali.linux-fr.org/devel/misc/dme1737/

Put the files in a temporary directory, install package linux-headers,
type "make" to build the driver, and then, as root:
# rmmod dme1737
# insmod ./dme1737.ko

That should do it.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
