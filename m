From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:48 +0000
Subject: We will port w83792d.c to linux-2.6
Message-Id: <Pine.LNX.4.58.0504061823330.21101@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello all,

How could this EVER worked????!!!!

outb_p(inb_p(SMB_HST_CNTL2) | (size << 3), SMB_HST_CNTL2);
MASK is missing !!!!

Please can you add to your driver this?

#define HST_CNTL2_SIZEMASK 0x38

outb_p( (inb_p(SMB_HST_CNTL2)&~HST_CNTL2_SIZEMASK) | (size << 3), SMB_HST_CNTL2);

I think then it should work.

i2cdump 0 0x50
i2cdump 0 0x50 c
i2cdump 0 0x50

and also

modprobe eeprom
sensors


Regards

Rudolf
