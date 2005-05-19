From: alex@alexdalton.org (Alexandre d'Alton)
Date: Thu, 19 May 2005 06:25:00 +0000
Subject: adm1031 patch for 2.6.6-bk5
Message-Id: <1086336106.40c02c6a1e312@imp6-q.free.fr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

All,

Here is the latest patch for adm1031 support on 2.6 kernel.

Jean:
      - This patch includes the modifications done in the 2.4 driver concerning
the trusted fan readings.
      - I also added a -EINVAL return when we try to set pwm = 0 when auto-mode
is selected.

Just in order to keep the 2.6 version more inline with the 2.4 version. 

-- 
-------------------------------------------------
Alexandre d'ALTON
                              alex@alexdalton.org

-------------- next part --------------
A non-text attachment was scrubbed...
Name: adm1031-linux-2.6.6-bk5.diff
Type: text/x-patch
Size: 38904 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040604/4b30dc32/adm1031-linux-2.6.6-bk5.bin
