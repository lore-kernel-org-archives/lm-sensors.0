From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:20 +0000
Subject: Unresolved Symbols question lm_sensors 2.8.0/i2c 2.8.0/linux
Message-Id: <20031003213630.GE23731@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F7B83FF.2060409@yml.com>
In-Reply-To: <3F7B83FF.2060409@yml.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Yermo M. Lamers <yml@yml.com> [2003-10-03 15:46:52 -0400]:

<snip>

> Here's what I get:
> 
> [root@nbi_master lm_sensors-2.8.0]# make kernel/busses/dmi_scan.o
> grep: /lib/modules/2.4.20-8smp/build/.config: No such file or directory

<snip>

This is the (RedHat specific) problem.  You need to copy the matching
config from /usr/src/linux-2.4/configs/<blah> to /usr/src/linux-2.4/.config
The missing file above is actually a link to...  ^^^^^^^^^^^^^^^^^^^^^^^^^^

Then start over.  Be sure to "make clean" in i2c and lm_sensors2 first.

Everyone else: why don't we simply fail compilation without this file?

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
