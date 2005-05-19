From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:13 +0000
Subject: Ticket 1372:
Message-Id: <20030820213616.GA28515@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <1061061579.6212.1.camel@campgrounds>
In-Reply-To: <1061061579.6212.1.camel@campgrounds>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* schiebe <t7thguest@gmx.de> [2003-08-16 21:19:40 +0200]:
> Hi, sorry but i use lm_sensors 2.8
> 
> [root@campgrounds sbin]# rpm -q lm_sensors
> lm_sensors-2.8.0-1_14.rh9.at

Did you get these from Axel Thimm?  It looks like his lm_sensors package
includes userspace tools only.  You probably need to use his custom
kernel for the 2.8.0 version of I2C and sensors kernel modules.

> dmesg:
> i2c-core.o: i2c core module
> i2c-viapro.o version 2.6.5 (20020915)
                       ^^^^^
Yes this is definitely an old kernel module.

> i2c-viapro.o: Can't detect vt82c596 or compatible device, module not
> insert
> 
> maybe i should use the tarballs :-)

They're pretty easy to build and install; make sure that you remove any
old versions first, and follow the READMEs.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
