From: grant_lkml@dodo.com.au (Grant Coady)
Date: Tue, 31 May 2005 04:12:11 +0000
Subject: [lm-sensors] lm_sensors 2.9.1 sensord compile failure on 2.6.11.11
Message-Id: <1lhn91hj2hvhq65un08m8nae3f7fvt3ubv@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi gang,

Can't compile sensord 2.9.1 with 2.6.11.11 -- neither can my test user, 
and he's done it before.

make clean; make PROG_EXTRA:=sensord

make: *** No rule to make target `linux/i2c-proc.h', needed by 
`kernel/chips/xeontemp.d'.  Stop.

Does anyone know a fix?  Or magical incantation?

It is probably something stupid, but I cannot see it, make user; make 
user_install work fine, why not other stuff?  

Thanks,
--Grant.

