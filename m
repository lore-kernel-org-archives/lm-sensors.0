From: rddunlap@osdl.org (Randy.Dunlap)
Date: Thu, 19 May 2005 06:24:46 +0000
Subject: [PATCH] i2c-prosavage.c section usage
Message-Id: <20040308091739.1bff78a0.rddunlap@osdl.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040307194701.0cf1ec47.rddunlap@osdl.org>
In-Reply-To: <20040307194701.0cf1ec47.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon,  8 Mar 2004 16:02:28 +0100 Jean Delvare wrote:

| Quoting "Randy.Dunlap" <rddunlap@osdl.org>:
| 
| > prosavage_remove() is called during init, so it shouldn't be
| > marked as exit code.  (It matters when CONFIG_HOTPLUG=n.)
| > (...)
| > // Linux 2.6.4-rc2
| > // prosavage_remove() shouldn't be marked as __devexit;
| 
| Wouldn't a more correct fix be that prosavage_remove would not be called
| during init? Looks to me like this function will do almost nothing when
| called at this point (because the driver hasn't fully intialized yet).

You could be right about that, I didn't look at the details very much.
However, it's not unusual or incorrect for an init failure to need
to cleanup in much the same way that exit needs to cleanup.
I have seen other drivers that do this.

| I took a look at the other drivers and no other one does handle this
| particular point the way i2c-prosavage does. This makes me think that
| it isn't the prefered way to do it. For example, i2c-savage4 could be
| used as a template to modify i2c-prosavage.
| 
| On the opposite side, i2c-ixp42x and i2c-keywest do not use __devexit_p
| for their .remove callback functions, while I would tend to think that
| they should do so, since their aren't called explicitely like it is
| done in i2c-prosavage.
| 
| (BTW, I don't much see how this is related to CONFIG_HOTPLUG, if you
| could explain this to me...)

Sure.  In include/linux/init.h, there are these lines:

#ifdef CONFIG_HOTPLUG
#define __devinit
#define __devinitdata
#define __devexit
#define __devexitdata
#else
#define __devinit __init
#define __devinitdata __initdata
#define __devexit __exit
#define __devexitdata __exitdata
#endif

so if CONFIG_HOTPLUG is enabled, the __dev* defines are "empty",
and if CONFIG_HOTPLUG is not enabled, the __dev* defines allow those
code and data sections to be discarded (not always present).

The reasoning is that for HOTPLUG=y, init and exit code can be needed
at any time, not only at module init/loading e.g.
But for the HOTPLUG=n, the init and exit code/data can be discarded,
it doesn't need to stay available.

Does that help?

--
~Randy
