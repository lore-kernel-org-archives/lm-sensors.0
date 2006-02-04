From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 04 Feb 2006 10:19:00 +0000
Subject: [lm-sensors] some remarks over platform_device use in f71805f.c
Message-Id: <20060204111900.155ef126.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <43E4778C.6000103@hhs.nl>
In-Reply-To: <43E4778C.6000103@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

> After reading the discussion about the usage of platform_device in 
> f71805f.c, I've been busy converting the Abit uGuru driver to a 
> platform_driver.
> 
> I've taken the f71805f.c file as an example and see some room for 
> improvements there:

Thanks for the review and comments, these are always welcome.

> -f71805f_device_add can effectively be removed by using
>   platform_device_register_simple, which does all this in 1 step except
>   for filling the resource struct.

Except that platform_device_register_simple is planned for removal soon:
  http://marc.theaimsgroup.com/?l=linux-kernel&m3696287624649&w=2

> -Also you pass in the base address as the id, this will lead to a dir
>   name in sysfs of f71805f<baseaddr> where base addr will be decimal.
> 
>   Since you clearly plan on supporting only one device for now, you
>   should / could pass -1 as id, which will get you a sysfs dir entry of
>   just f71805f.

The problem is that we need the address in userspace (for libsensors).
This was the most simple way to pass it, with the added benefit that it
also guarantees the uniqueness if we ever have two similar ISA hardware
monitoring chips in a system (very unlikely, I admit.)

I could have gone with no ID but then we would have had to add an
address sysfs attribute, and then add code to libsensors to grab its
value.

I'm not particularly happy with the current implementation (the decimal
address is not very elegant) but it works and was very simple to setup.
If anyone wants it to be implemented differently, please speak up now
and provide patches (both to the f71805f drivers and to libsensors) for
the alternative implementation.

> -You've made the resource struct a static global, but it can be
>   a normal local variable since the platform_device copy allocs its own
>   copy, see the lifetime is not an issue.

It is tagged __initdata so it will be freed after initialization anyway
(at least as I understand the __init tags.) However, it now seems to me
that using a global that way is not correct, because it prevents
f71805f_device_add twice in parallel. We don't do it anyway, but the
driver design shouldn't prevent it.

Usually I don't much like structures on the stack, but struct resource
isn't too large, so it should be acceptable. Can you please propose a
patch?

Thanks,
-- 
Jean Delvare

