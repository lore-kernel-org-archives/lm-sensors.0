From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 13 Aug 2008 14:13:31 +0000
Subject: Re: [lm-sensors] New style driver for w83781d?
Message-Id: <20080813161331.2780a2c2@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4899A4F7.70201@grandegger.com>
In-Reply-To: <4899A4F7.70201@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 13 Aug 2008 15:48:14 +0200, Wolfgang Grandegger wrote:
> Jean Delvare wrote:
> > Your patch breaks the build with CONFIG_ISA=y:
> > 
> >   CC [M]  drivers/hwmon/w83781d.o
> > drivers/hwmon/w83781d.c: In function `w83781d_read_value_i2c_isa':
> > drivers/hwmon/w83781d.c:1668: error: `client' undeclared (first use in this function)
> > drivers/hwmon/w83781d.c:1668: error: (Each undeclared identifier is reported only once
> > drivers/hwmon/w83781d.c:1668: error: for each function it appears in.)
> > drivers/hwmon/w83781d.c:1660: warning: unused variable `bank'
> > drivers/hwmon/w83781d.c: In function `w83781d_write_value_i2c_isa':
> > drivers/hwmon/w83781d.c:1694: warning: unused variable `bank'
> > drivers/hwmon/w83781d.c:1695: warning: unused variable `cl'
> > drivers/hwmon/w83781d.c: In function `w83781d_isa_add_driver':
> > drivers/hwmon/w83781d.c:1967: error: `w83781d_read_value_isa' undeclared (first use in this function)
> > drivers/hwmon/w83781d.c:1968: error: `w83781d_write_value_isa' undeclared (first use in this function)
> > drivers/hwmon/w83781d.c: At top level:
> > drivers/hwmon/w83781d.c:1659: warning: 'w83781d_read_value_i2c_isa' defined but not used
> > drivers/hwmon/w83781d.c:1692: warning: 'w83781d_write_value_i2c_isa' defined but not used
> > make[2]: *** [drivers/hwmon/w83781d.o] Error 1
> > make[1]: *** [drivers/hwmon] Error 2
> > make: *** [drivers] Error 2
> 
> > Apparently you didn't test that case - you really have to.
> 
> I thought I did but... Anyway, I cannot really test the ISA interface 
> because I just have an embedded PowerPC board with a w83782.

I can do the testing, no problem with that. Please just make sure that
it builds OK.

> > (...)
> > I don't think that going to this level of optimization is needed. Or,
> > if you insist on doing it, that would be a separate patch. The first
> > patch should really only move things around to group them inside the
> > #ifdef/#endif, and skip the detection of the ISA device and
> > registration of the platform driver. You shouldn't have to modify the
> > actual driver code.
> 
> I did not do any optimization saving code.

I was referring to the split of the register access functions.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
