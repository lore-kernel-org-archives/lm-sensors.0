From: grant_nospam@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:48 +0000
Subject: RFC: sysfs accesors: vid + vrm
Message-Id: <s4o651hg8v88ano2c6k9k3sifb4ucqusd9@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi there,

adm1026 needs trivial namechange to match the rest.

pc87360.c is odd as it does not use "i2c_which_vrm()" to preload 
vrm.  

I finally 'see' what Khali telling me for days, I did miss the 
i2c_which_vrm() call in setting up driver, going around in circles 
trying to make sense of vrm + vid.

Cheers,
Grant.

grant@peetoo:/home/public$ egrep "vid|vrm" crossref_sysfs_driver.list
cpu0_vid                    asb100.c     R
cpu0_vid                    gl520sm.c    R <<= no matching accessor[1]
cpu0_vid                    it87.c       R
cpu0_vid                    lm78.c       R
cpu0_vid                    lm85.c       R
cpu0_vid                    lm87.c       R
cpu0_vid                    pc87360.c    R
cpu0_vid                    w83627hf.c   R
cpu0_vid                    w83781d.c    R
vid                         adm1026.c    R <<= odd one out for name
vrm                         adm1025.c    RW [2]
vrm                         adm1026.c    RW [2]
vrm                         asb100.c     RW [2]
vrm                         it87.c       RW [2] 
vrm                         lm85.c       RW [2]
vrm                         lm87.c       RW [2]
vrm                         pc87360.c    RW [3]
vrm                         w83627hf.c   RW [4]
vrm                         w83781d.c    RW [2]

[1] should it have sysfs writer?

[2] has "data->vrm = i2c_which_vrm();" to load vrm as well as sysfs

[3] has "data->vrm = 90;" or sysfs, no fallback to [2]

[4] more complex, with [2] as default after trying sensor chip
