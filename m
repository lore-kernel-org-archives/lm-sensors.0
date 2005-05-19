From: marc@paracel.com (Marc Rieffel)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: RPM spec file patches for i2c and lm_sensors 2.8.1
Message-Id: <9D8C1A43309BAD4A9B46071DAF911D9E13FDA5@exch01.paracel.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I had to make these changes to be able to build i2c and lm_sensors rpms that worked.  Also, lm_sensors.init isn't included in any of the rpms.  Looks like nobody's touched these for several versions.

i2c.spec:

25c27
< %define ver 2.8.1
---
> %define ver 2.5.0
37a43,44
> Conflicts: kernel >= 2.3.38
70,72c75,77
< %dir /lib/modules/%{kversion}
< %dir /lib/modules/%{kversion}/kernel/drivers/i2c
< /lib/modules/%{kversion}/kernel/drivers/i2c/*
---
> %dir /lib/modules/%{mversion}
> %dir /lib/modules/%{mversion}/misc
> /lib/modules/%{mversion}/misc/*



And similarly for lm_sensors.spec.  Note that %{prefix}/include/linux/*.h gives conflicts with header files installed by the i2c rpm, so I had to just list the  one specific file that should be installed.




33c33
< %define kversion %(uname -r)
---
> %define kversion 2.2.14
34a35
> #Another example for the above: %define kversion 2.2.14-SMP
37c38
< %define ver 2.8.1
---
> %define ver 2.5.0
120,121d120
< #Add %{prefix}/lib to the ldconfig.
< grep "{%prefix}/lib" /etc/ld.so.conf || echo "%{prefix}/lib" >> /etc/ld.so.conf
150,155c149,150
< %dir /lib/modules/%{mversion}/kernel/drivers/i2c/
< /lib/modules/%{mversion}/kernel/drivers/i2c/*
< %dir /lib/modules/%{mversion}/kernel/drivers/i2c/busses
< /lib/modules/%{mversion}/kernel/drivers/i2c/busses/*
< %dir /lib/modules/%{mversion}/kernel/drivers/i2c/chips
< /lib/modules/%{mversion}/kernel/drivers/i2c/chips/*
---
> %dir /lib/modules/%{mversion}/misc
> /lib/modules/%{mversion}/misc/*
157c152
< %{prefix}/include/linux/sensors.h
---
> %{prefix}/include/linux/*.h

