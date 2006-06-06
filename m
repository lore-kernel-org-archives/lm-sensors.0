From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Tue, 06 Jun 2006 18:37:46 +0000
Subject: [lm-sensors] [PATCH] W83627EHF driver update
Message-Id: <4485CB7A.9050209@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello

This patch adds long-awaited suport for automatic fan modes. Based on the work
of Yuan Mu from Winbond, I finished the support with the great help of David
Hubbard. The documenation update will follow.

Signed-Off-By: Yuan Mu <Ymu at Winbond.com.tw>
Signed-Off-By: Rudolf Marek <r.marek at sh.cvut.cz>
Signed-Off-By: David Hubbard <david.c.hubbard at gmail.com>

Some notes: The patch should be OK. It was checked/tested many times by me and
David. This patch is based on ehf_patch_rc1 and ehf_patch_fix_fan45. More than
80 columns were fixed and on 4 places mutex lock/unlock was placed.

David, please can you check/test this final patch before Jean takes it?
Please have a look to store_pwm_enable which has non-trivial locking. I belive 
it is OK and I tested briefly, but better to be sure.

Thanks,
regards
Rudolf

-------------- next part --------------
A non-text attachment was scrubbed...
Name: ehf_u.patch
Type: text/x-patch
Size: 18050 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060606/5822ece9/attachment-0001.bin 
