From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 06 Jul 2013 19:22:21 +0000
Subject: Re: [lm-sensors] [RFC PATCH 1/5] driver core: Introduce device_create_groups
Message-Id: <20130706192221.GB15066@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1373131495-13465-1-git-send-email-linux@roeck-us.net>
 <1373131495-13465-2-git-send-email-linux@roeck-us.net>
 <20130706174758.GA8122@kroah.com>
In-Reply-To: <20130706174758.GA8122@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jean Delvare <khali@linux-fr.org>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Sat, Jul 06, 2013 at 10:47:58AM -0700, Greg Kroah-Hartman wrote:
> On Sat, Jul 06, 2013 at 10:24:51AM -0700, Guenter Roeck wrote:
> > device_create_groups lets callers create devices as well as associated
> > sysfs attributes with a single call. This avoids race conditions seen
> > if sysfs attributes on new devices are created later.
> > 
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  drivers/base/core.c    |   60 +++++++++++++++++++++++++++++++++++++++++++++---
> >  include/linux/device.h |    4 ++++
> >  2 files changed, 61 insertions(+), 3 deletions(-)
> 
> Ok, in reading the code, it makes more sense to me now.  That looks
> good, but the name is a bit rough.  How many device_create() calls do we
> have in the kernel today?
> 
> $ git grep -w device_create | wc -l
> 127
> 
> That's really not that many, I wonder how many of those should be using
> something like this as well?  A quick look showed that the sound core
> should be using this, but maybe not all that many others...
> 
Pretty much all hwmon devices. Given that, another option would be to not use
device_create in the hwmon core code, but more or less re-write it there.
I don't think that would be such a good idea, but it is my fallback option.

> My objection to the name is at first glance, it sounds like you are
> creating "groups", not a device + groups.
> "device_create_with_groups()"?
> 
No problem. You pick the name ...

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
