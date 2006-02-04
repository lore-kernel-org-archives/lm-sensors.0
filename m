From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Sat, 04 Feb 2006 09:44:44 +0000
Subject: [lm-sensors] some remarks over platform_device use in f71805f.c
Message-Id: <43E4778C.6000103@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

After reading the discussion about the usage of platform_device in 
f71805f.c, I've been busy converting the Abit uGuru driver to a 
platform_driver.

I've taken the f71805f.c file as an example and see some room for 
improvements there:

-f71805f_device_add can effectively be removed by using
  platform_device_register_simple, which does all this in 1 step except
  for filling the resource struct.

-Also you pass in the base address as the id, this will lead to a dir
  name in sysfs of f71805f<baseaddr> where base addr will be decimal.

  Since you clearly plan on supporting only one device for now, you
  should / could pass -1 as id, which will get you a sysfs dir entry of
  just f71805f.

-You've made the resource struct a static global, but it can be
  a normal local variable since the platform_device copy allocs its own
  copy, see the lifetime is not an issue.


Regards,

Hans


