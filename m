From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 21 Dec 2005 22:13:56 +0000
Subject: [lm-sensors] RFC: Backport of lm77.c to kernel 2.4.x
Message-Id: <20051221231356.2fea483c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1715.84.58.133.46.1135201553.squirrel@webmail.otaku42.de>
In-Reply-To: <1715.84.58.133.46.1135201553.squirrel@webmail.otaku42.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Michael,

> The driver is available via Subversion at
> http://projects.otaku42.de/svn/lm77/trunk but you can also view the source
> with your browser at http://projects.otaku42.de/viewcvs/lm77/trunk/ .
> 
> If you want to compile the driver, copy lm77.[ch] to the kernel/chips
> subdirectory of your local lm_sensors-2.9.2 copy. Then edit
> kernel/chips/Module.mk and add the line:
> 
> KERNELCHIPSTARGETS += $(MODULE_DIR)/lm77.o
> 
> right after
> 
> KERNELCHIPSTARGETS += $(MODULE_DIR)/smbus-arp.o
> 
> Now (re)compile as usual.

It would be much easier for everyone if you could just provide a patch
against lm_sensors CVS. This is what you will have to provide in the
end if you want your driver to be merged in our CVS repository anyway.

Thanks,
-- 
Jean Delvare

