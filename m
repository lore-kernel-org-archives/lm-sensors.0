From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:59 +0000
Subject: [lm-sensors] [PATCH 2.6.12-rc4 15/15]
Message-Id: <lqrk81degqp2id4sf1f4rjsnithljnibhb@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2538186705051703479bd0c29@mail.gmail.com> <e9iUj0EZ.1116327879.1515720.khali@localhost> <2538186705051704181a70dbbf@mail.gmail.com> <0pik81hjboqvbf2jhgdut861cfpgl7sata@4ax.com> <2538186705051713565d07e66b@mail.gmail.com>
In-Reply-To: <2538186705051713565d07e66b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yani Ioannou <yani.ioannou@gmail.com>
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>

Hi Yani,

On Tue, 17 May 2005 16:56:04 -0400, Yani Ioannou <yani.ioannou@gmail.com> wrote:
>Those are the sysfs names? If so something looks wrong with the

Not the final ones, just from first macro expansion of driver 
source, that's why I'd like to see changes on w83627hf driver 
as I can test it right through.  

I haven't looked at your patched source yet to see about applying 
it to other drivers, 'cos I'm happy to do that part for you if I 
can follow the changes :)

>SENSOR_ ones..maybe an unintended effect of the new
>sensor_device_attribute macro. I can't seem to find anything like that
>in "gcc -I ../../../include/ -E adm1026.c" though, would you mind
>sending me your script? Also make sure you are including the new
>i2c-sysfs.h header file.

No, I'm not doing a proper compile, I'm intentionally doing partial 
compile of driver.c and _not_ including headers, ignoring errors due 
to missing headers. 

This technique seems valid for the type of testing I'm doing, which 
is simply to pull out the first level macro expansion.

Script is work in progress, updated to current version up at:

  http://scatter.mine.nu/hwmon/sysfs-names/

>The group of attributes you've highlighted below don't use
>sensor_device_attribute on purpose because they don't benefit from the
>dynamic sysfs callbacks, mainly because they are singletons. Well its

Not singletons, 3 of each (from an intermediate file):

adm1026.c       temp1_crit_enable       S_IRUGO S_IWUSR
adm1026.c       temp2_crit_enable       S_IRUGO S_IWUSR
adm1026.c       temp3_crit_enable       S_IRUGO S_IWUSR
adm1026.c       pwm1    S_IRUGO S_IWUSR
adm1026.c       pwm2    S_IRUGO S_IWUSR
adm1026.c       pwm3    S_IRUGO S_IWUSR
adm1026.c       temp1_auto_point1_pwm   S_IRUGO S_IWUSR
adm1026.c       temp2_auto_point1_pwm   S_IRUGO S_IWUSR
adm1026.c       temp3_auto_point1_pwm   S_IRUGO S_IWUSR
adm1026.c       temp1_auto_point2_pwm   S_IRUGO
adm1026.c       temp2_auto_point2_pwm   S_IRUGO
adm1026.c       temp3_auto_point2_pwm   S_IRUGO

Yet, in related groups of three you have:

adm1026.c       SENSOR_temp1_crit       S_IRUGO S_IWUSR
adm1026.c       SENSOR_temp2_crit       S_IRUGO S_IWUSR
adm1026.c       SENSOR_temp3_crit       S_IRUGO S_IWUSR

>BTW looks like a useful script :-), I'm always worried when doing
>these changes I might accidently change a sysfs attribute permission.

Thank you, what I will do is remove the "SENSOR_" and flag attribute 
column with an asterisk to indicate dynamic attribute, something 
like that.  And flag singletons too.

Thanks,
--Grant.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
