From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sat, 04 Mar 2006 10:46:37 +0000
Subject: [lm-sensors] [PATCH] Add voltage support to W83627EHF
Message-Id: <4409700D.8010604@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello all,

I just finished adding the support for voltage channels on EHF chip. Feel free to test it.
(This implies to the mailing list members rather to you Yuan, I know you are busy ;)

Jean, If you like it, please apply (after someone did the testing in reasonable time)

This patch adds the voltage measuring support to W83627EHF. The code is based
on the patch provided by Yuan Mu from Winbond. Moreover the patch implements new
alarm files scheme for voltages.

Signed-off-by: Yuan Mu <Ymu at Winbond.com.tw>
Signed-off-by: Rudolf Marek <r.marek at sh.cvut.cz>

Thanks,
Regards
Rudolf
-------------- next part --------------
A non-text attachment was scrubbed...
Name: w83627ehf_add_voltages.patch
Type: text/x-patch
Size: 8594 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060304/b1354d92/w83627ehf_add_voltages.bin
