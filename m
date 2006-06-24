From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sat, 24 Jun 2006 16:42:45 +0000
Subject: [lm-sensors] [PATCH] W83627EHF driver update
Message-Id: <449D6B85.70908@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <4485CB7A.9050209@sh.cvut.cz>
In-Reply-To: <4485CB7A.9050209@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Here comes fixed patch, I left the macro there because it will be used in future
update. Rest was fixed.

I'm attaching the documentation patch too. David, please can you read it and
check it? (I will sign that off when we know that there are no mistakes)

This patch adds long-awaited support for automatic fan modes. Based on the work
of Yuan Mu from Winbond, I finished the support with the great help of David
Hubbard. The documentation update will follow.

Signed-Off-By: Yuan Mu <Ymu at Winbond.com.tw>
Signed-Off-By: Rudolf Marek <r.marek at sh.cvut.cz>
Signed-Off-By: David Hubbard <david.c.hubbard at gmail.com>

Regards
Rudolf
-------------- next part --------------
A non-text attachment was scrubbed...
Name: ehf_docs.patch
Type: text/x-patch
Size: 3393 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060624/922b5044/attachment.bin 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: ehf_next_try7.patch
Type: text/x-patch
Size: 16868 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060624/922b5044/attachment-0001.bin 
