From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Tue, 06 Jun 2006 16:30:04 +0000
Subject: [lm-sensors] [PATCH] Fix the AMD756 SMBus Controller hang
Message-Id: <4485AD8C.5010906@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello

This patch seems to fix the hang of AMD756 SMBus controller. After certain 
ammount of bus transactions the controller refused to start new transactions
and abort was not working. This patch is based on mine and Dieter Jurzitza's 
investigations.

Please apply.

Signed-Off-By: Rudolf Marek <r.marek at sh.cvut.cz>

Regards
Rudolf
-------------- next part --------------
A non-text attachment was scrubbed...
Name: i2c-amd756.patch
Type: text/x-patch
Size: 424 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060606/29039c24/attachment-0001.bin 
