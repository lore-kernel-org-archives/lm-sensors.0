From: r.marek@assembler.cz (Rudolf Marek)
Date: Tue, 17 Oct 2006 21:31:58 +0000
Subject: [lm-sensors] [PATCH 2/3] coretemp driver
Message-Id: <45354BCE.1020704@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <45329AC7.3040008@assembler.cz>
In-Reply-To: <45329AC7.3040008@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello all,

I fixed the missing header include and also this version of driver uses msr_read 
  intead of do_rdmsr. So the new driver coretemp should now hopefully compile 
without problems.

This version along with the msr patch should now compile cleanly on the x68_64, 
but I dont know if on i386. Anyone with 32bit gcc around?

Thanks,
Regards
Rudolf
-------------- next part --------------
A non-text attachment was scrubbed...
Name: add-coretemp-driver.patch
Type: text/x-patch
Size: 11854 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061017/759c6d1b/attachment-0001.bin 
