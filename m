From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 26 Aug 2011 18:28:10 +0000
Subject: Re: [lm-sensors] Odd warning in lm90.c (and other drivers)
Message-Id: <1314383290.2796.140.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1314377205.2796.90.camel@groeck-laptop>
In-Reply-To: <1314377205.2796.90.camel@groeck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Fri, 2011-08-26 at 14:05 -0400, Guenter Roeck wrote:
> On Fri, 2011-08-26 at 13:22 -0400, Jean Delvare wrote:
> > Hi Guenter,
> > 
> > On Fri, 26 Aug 2011 18:53:35 +0200, Jean Delvare wrote:
> > > On Fri, 26 Aug 2011 09:46:45 -0700, Guenter Roeck wrote:
> > > > Hi all,
> > > > 
> > > > I sometimes get the following warnings when trying to compile lm90.c:
> > > > 
> > > > drivers/hwmon/lm90.c: In function ‘lm90_detect’:
> > > > drivers/hwmon/lm90.c:1114: warning: ‘chip_id’ may be used uninitialized
> > > > in this function
> > > > drivers/hwmon/lm90.c:1114: warning: ‘reg_config1’ may be used
> > > > uninitialized in this function
> > > > drivers/hwmon/lm90.c:1114: warning: ‘reg_convrate’ may be used
> > > > uninitialized in this function
> > > > drivers/hwmon/lm90.c:1187: warning: ‘reg_emerg2’ may be used
> > > > uninitialized in this function
> > > > drivers/hwmon/lm90.c:1187: warning: ‘reg_status2’ may be used
> > > > uninitialized in this function
> > 
> > Can you try enabling _all_ hwmon drivers to see if any other report
> > similar warnings with your config?
> > 
> > > > This is seen with 3.0-rc3, with the attached configuration file (which
> > > 
> > > 3.0-rc3 or 3.1-rc3?
> > 
> > The latter, I should have checked the attached configuration file
> > before asking.
> > 
> > > > was generated with "make randconfig"). gcc version is 4.4.3.
> > > > 
> > > > Any idea, anyone, what might cause the warning ?
> > > 
> > > No immediate idea but I can try to reproduce it...
> > 
> > First thing I see is:
> > 
> > # make oldconfig
> > scripts/kconfig/conf --oldconfig Kconfig
> > warning: (IA32_EMULATION) selects COMPAT_BINFMT_ELF which has unmet direct dependencies (COMPAT && BINFMT_ELF)
> > warning: (IA32_EMULATION) selects COMPAT_BINFMT_ELF which has unmet direct dependencies (COMPAT && BINFMT_ELF)
> > 
> Hi Jean,
> 
> I disabled IA32_EMULATION. Above config warning goes away, but the lm90
> warning is still there. After enabling EXPERIMENTAL plus all hwmon
> drivers I see a few more warnings:
> 
> drivers/hwmon/adm1031.c: In function ‘set_fan_auto_channel’:
> drivers/hwmon/adm1031.c:287: warning: ‘reg’ may be used uninitialized in
> this function
> 
> drivers/hwmon/lm90.c: In function ‘lm90_detect’:
> drivers/hwmon/lm90.c:1114: warning: ‘chip_id’ may be used uninitialized
> in this function
> drivers/hwmon/lm90.c:1114: warning: ‘reg_config1’ may be used
> uninitialized in this function
> drivers/hwmon/lm90.c:1114: warning: ‘reg_convrate’ may be used
> uninitialized in this function
> drivers/hwmon/lm90.c:1187: warning: ‘reg_emerg2’ may be used
> uninitialized in this function
> drivers/hwmon/lm90.c:1187: warning: ‘reg_status2’ may be used
> uninitialized in this function
> 
> drivers/hwmon/smsc47b397.c: In function ‘smsc47b397_init’:
> drivers/hwmon/smsc47b397.c:379: warning: ‘address’ may be used
> uninitialized in this function
> 
> drivers/hwmon/pmbus/pmbus_core.c: In function ‘pmbus_show_boolean’:
> drivers/hwmon/pmbus/pmbus_core.c:753: warning: ‘val’ may be used
> uninitialized in this function
> 
> New config file is attached. Still no idea what causes it.

I also tried the same configuration with gcc 4.5.2. lm90 and smsc47b397
warnings are still reported, others are gone.

Specifically the code in smsc47b397.c leads me to believe that this is
just a compiler glitch, but I still would like to understand why it is
only seen with some configurations ...

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
