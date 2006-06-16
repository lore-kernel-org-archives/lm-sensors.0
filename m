From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Fri, 16 Jun 2006 21:33:12 +0000
Subject: [lm-sensors] [PATCH] W83627EHF driver update
Message-Id: <44932398.2080603@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <4485CB7A.9050209@sh.cvut.cz>
In-Reply-To: <4485CB7A.9050209@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Here comes the updated patch

This patch adds long-awaited suport for automatic fan modes. Based on the work
of Yuan Mu from Winbond, I finished the support with the great help of David
Hubbard. The documenation update will follow.

Signed-Off-By: Yuan Mu <Ymu at Winbond.com.tw>
Signed-Off-By: Rudolf Marek <r.marek at sh.cvut.cz>
Signed-Off-By: David Hubbard <david.c.hubbard at gmail.com>

David, I fix the comment you had, thanks! Also I ripped out two more register
exports (sf3 fan_max and fan_step). This will be neccessary to put back next round.

Regards
Rudolf
-------------- next part --------------
A non-text attachment was scrubbed...
Name: ehf_next_try5.patch
Type: text/x-patch
Size: 16043 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060616/f0e6212b/attachment.bin 
