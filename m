From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Thu, 19 Jul 2007 15:02:20 +0000
Subject: [lm-sensors] Proposal: howto handle sysfs attribute writes with
Message-Id: <469F7CFC.4040306@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi All,

Since there was some discussion about how I'm handling sysfs attr writes with 
invalid values in the f71882fg driver, and since I've seen other discussions 
about it, here is a proposal to try and create a standard way to handle this.

This is intended to become a part of Documentation/hwmon/sysfs eventually.

---

Howto check the validity of user written values to sysfs attributes:

hwmon sysfs attributes always contain numbers, so the first thing todo is to
convert the input to a number, there are 2 ways todo this depending wether
the number can be negative or not:
unsigned long u = simple_strtoul(buf, NULL, 10);
long s = simple_strtol(buf, NULL, 10);

With buf being the buffer with the user input being passed by the kernel.
Notice that we do not use the second argument of strto[u]l, and thus cannot
tell when 0 is returned, if this was really 0 or is caused by invalid input.
This is done deliberately as checking this everywhere would add a lot of
code to the kernel. We do need to document clearly that writing a non-number 
will be seen as writing 0.

Notice that it is important to always store the converted value in an unsigned 
long or long, so that no wrap around can happen before any further checking.

After conversion and storing the converted value in the right type, and 
preferably before any conversions on the value, the value should be checked if 
it its acceptable. For example if its a temperature limit being stored in an 
unsigned 8 bit register, we should have something like this:

unsigned long u = simple_strtoul(buf, NULL, 10);
if (u > 255000)
	return -EINVAL;

One could argue to clamp instead of returning EINVAL, but what todo then when 
something that is not a continues range like temp sensor type gets written? In 
the not a continues range scenario returning -EINVAL is the only thing that 
makes sense, so we do this in the continues range scenario too to be consistent.

---

So does this make sense? I know that many drivers are currently doing this 
different, some clamp, some don't check at all, thus effectively wrapping 
around in most cases, all these different ways are exactly the reason for me 
writing this proposal.

Regards,

Hans




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
