From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 13 Jan 2006 20:22:08 +0000
Subject: [lm-sensors] Oops in kernel 2.6.14.5
Message-Id: <20060113212208.40fb66b3.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

I see nothing in these logs accusing the i2c subsystem nor any hardware
monitoring driver. The message "w83781d-isa 9191-0290: Starting device
update" happens several seconds after the oops, I don't think it is
related, it simply suggests that the submitter has some application
polling the hardware monitoring device.

Providing that the stack trace is correct, I would rather suspect the
ext3 filesystem driver:

> Jan  2 17:51:03 conquest3 kernel: [get_new_inode_fast+31/304] get_new_inode_fast+0x1f/0x130
> Jan  2 17:51:03 conquest3 kernel: [iget_locked+172/240] iget_locked+0xac/0xf0
> Jan  2 17:51:03 conquest3 kernel: [ext3_lookup+107/208] ext3_lookup+0x6b/0xd0

Thanks,
-- 
Jean Delvare

