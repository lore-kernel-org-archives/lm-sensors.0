From: grant_nospam@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:48 +0000
Subject: RFC: sysfs naming - mixed up auto, which way to fix?
Message-Id: <njn651dvrkdssonlev7emlf122il27b9oc@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi there,

In this list for 2.6.12-rc2-mm1/drivers/i2c/chips we have two ways to 
name 'auto' accessors, which way to go?  auto_*  or *_auto_* ?

grant@peetoo:/home/public$ grep auto crossref_sysfs_driver.list|grep -v 2_|grep -v 3_
auto_fan1_channel           adm1031.c    RW
auto_fan1_min_pwm           adm1031.c    RW
auto_temp1_max              adm1031.c    RW
auto_temp1_min              adm1031.c    RW
auto_temp1_off              adm1031.c    R
fan1_auto                   gl518sm.c    WR
pwm1_auto_channels          lm85.c       RW
pwm1_auto_pwm_freq          lm85.c       RW
pwm1_auto_pwm_min           lm85.c       RW
pwm1_auto_pwm_minctl        lm85.c       RW
temp1_auto_point1_pwm       adm1026.c    RW
temp1_auto_point1_temp      adm1026.c    RW
temp1_auto_point1_temp_hyst adm1026.c    R
temp1_auto_temp_crit        lm85.c       RW
temp1_auto_temp_max         lm85.c       RW
temp1_auto_temp_min         lm85.c       RW
temp1_auto_temp_off         lm85.c       RW

Since Murphy is on a winning streak with me I shall not venture 
an opinion :)  

Cheers,
Grant.

