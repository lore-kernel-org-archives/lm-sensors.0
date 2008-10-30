From: Trent Piepho <tpiepho@freescale.com>
Date: Thu, 30 Oct 2008 01:45:36 +0000
Subject: Re: [lm-sensors] Using hwmon in-kernel
Message-Id: <Pine.LNX.4.64.0810291811210.25957@t2.domain.actdsltmp>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081008003041.GA20169@srcf.ucam.org>
In-Reply-To: <20081008003041.GA20169@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 30 Oct 2008, Matthew Garrett wrote:
> On Wed, Oct 29, 2008 at 04:33:19PM -0700, Trent Piepho wrote:
>> On Wed, 22 Oct 2008, Matthew Garrett wrote:
>>> Mnf. I'm not convinced general kernel upstream would be enthusiastic.
>>
>> Any reason for that?
>
> Because any interface that basically enforces integer->string->integer
> conversion is an indication that you're already doing it wrong.

Many if not most users of the sysfs interface from userspace are doing
int->string->int.  Yeah, 'cat' and 'echo' aren't, but most apps more
sophisticated than that do.  So it's no more wrong than sysfs already is.

For what it used for, the sysfs int->string->int cost isn't very significant. 
It's less than the kernel to userspace cost of sysfs.

If the overhead of the sysfs interface to userspace is not enough to be a
problem, and a kernel interface to sysfs has less overhead than from
userspace, then how can the kernel based overhead be too much?

Though maybe sysfs or hwmon could provide int<->string wrappers.  Virtually
every hwmon store does a sprintf and virtually every show does a strtol.  It
could quite possibly be more efficient to move all that code to common
set/show wrappers.

Then the hwmon driver would provide set/show methods use/produce ints instead
of strings.  The wrappers would take care of converting those to/from strings.

From this:

static SENSOR_DEVICE_ATTR(foo, S_IWUSR|S_IRUGO, show_foo, set_foo, 1);

static ssize_t show_foo(..., char *buf)
{	return sprintf(buf, "%d\n", value); }

static ssize_t set_foo(..., const char *buf, size_t count)
{	unsigned long val = simple_strtol(buf, NULL, 10); }

To this:

static SENSOR_DEVICE_ATTR_INT(foo, S_IWUSR | S_IRUGO, show_foo, set_foo, 1);

static ssize_t show_foo(..., signed long *output)
{	*output = value; return 0; }

static ssize_t set_foo(..., signed long val)
{	... }

The actual sysfs store and set would be a wrapper that calls the methods
registered with SENSOR_DEVICE_ATTR_INT and does the int<->string stuff.

hwmon could then provide this function, which would call show_foo() directly.

int hwmon_show_attribute_int(const struct device *dev, const char *attr, long *out)

Instead of hwmon providing this stuff, sysfs could always do it.  There are a
lot of non-hwmon attributes that could make use of it.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
