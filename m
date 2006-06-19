From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 19 Jun 2006 09:54:45 +0000
Subject: [lm-sensors] CPU Temp on ECS NFORCE3-A939
Message-Id: <20060619115445.55524ba3.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <000f01c69295$f481af80$7001a8c0@parisi02>
In-Reply-To: <000f01c69295$f481af80$7001a8c0@parisi02>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Lou,

> Regarding the kernel version - I have a fresh install of CentOS 4 and have
> updated all packages using yum.  Lm_sensors is actually the first thing I am
> trying to get running on this new box before I put it off into a closet.
> The output from uname -r is below:
> # uname -r
> 2.6.9-34.0.1.EL
> 
> The only other thing that is possible is I first had lm_sensors 2.8
> installed from yum and then when I was having the problem with the cpu temps
> removed using yum and then downloaded the source and compiled and installed.
> 
> Do you think there could be something left over from this? The version from
> sensors shows 2.10
> # sensors -v
> sensors version 2.10.0 with libsensors version 2.10.0

No, for Linux 2.6 kernels, the lm_sensors package only brings the user
space support, so it can't explain the observed inconsistencies on the
kernel front. It seems that you have an older version of the it87
driver than your kernel version suggests. I can't explain it, we would
need to know how exactly CentOS built their kernel.

Anyway, it doesn't matter that much, you can live without vid readings
- we aren't even sure if your boards support that.

> The only other thing I can think of is I am running amd64 version of linux
> which can sometimes cause some strange behaviors in applications.

It can't explain the observed inconsistencies either, and I doubt it
will cause any kind of problem on the lm_sensors side in general.

-- 
Jean Delvare

