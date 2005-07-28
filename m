From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Thu, 28 Jul 2005 18:37:56 +0000
Subject: [lm-sensors] Re: [patch] pc87360 de-macro and code shrink
Message-Id: <253818670507280936e890d52@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <42E87A0F.8060709@divsol.com>
In-Reply-To: <42E87A0F.8060709@divsol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 7/28/05, Jean Delvare <khali@linux-fr.org> wrote:
> 
> Hi Jim,
> 
> On 2005-07-28, Jim Cromie wrote:
> > attached is a patch which:
> >
> > 1. adds an __ATTR_N macro to device.h,
> > which takes an extra _index arg, and initializes device_attibute's new
> > .index member.
> 
> This seems to be duplicating the SENSOR_DEVICE_ATTR macro as defined in
> include/linux/hwmon-sysfs.h.

Just as a further to Jean's point, I'd like to highlight that
device_attribute doesn't need new members, rather it now passes an
extra parameter (a device_attribute *) to it's callbacks. What that
extra parameter does allow you to do is to embed a device_attribute in
another type (e.g. sensor_device_attribute) and access anything
defined in that new type (e.g. index). This is exactly what is defined
in include/hwmon-sysfs.h. See any of Jean's or my patches to various
sensor drivers that show how to use them.

With that said I'm glad you are trying to clean these things up :-),
you might want to look through the archives for "dynamic sysfs
callbacks" and the ensuing discussions if you are interested. At one
point early on adding a .index attribute to the device_attribute was
considered a possibility, but I feel what we ended up with is much,
much better.

> > 2. replaces lots of nested-macro-uses of these:
> >
> > static DEVICE_ATTR(temp##offset##_input, S_IRUGO, \
> >     show_temp##offset##_input, NULL); \
> >
> > with array initializers. like these:
> >
> > static struct device_attribute dev_attr_temp_input[] > >   {
> >     __ATTR_N(temp1_input, S_IRUGO, show_temp_input, NULL, 0),
> >     __ATTR_N(temp2_input, S_IRUGO, show_temp_input, NULL, 1),
> >     __ATTR_N(temp3_input, S_IRUGO, show_temp_input, NULL, 2),
> >     __ATTR_N(temp4_input, S_IRUGO, show_temp_input, NULL, 3),
> >     __ATTR_N(temp5_input, S_IRUGO, show_temp_input, NULL, 4),
> >     __ATTR_N(temp6_input, S_IRUGO, show_temp_input, NULL, 5),
> >   };
> 
> This is a different cleanup. Getting rid of macros is one thing, using
> arrays of attributes is another. As I said before, I'd like a separate
> patch (or even several) for each step. This makes reviewing much easier.
> Macro killing should be easy and unquestionable, while attribute arrays
> is something that still needs discussing.

Its a hard thing to see how to do nicely. We need to send Greg more
rough patches so we can pique his interest in solving the problem
again ;-).

Yani
