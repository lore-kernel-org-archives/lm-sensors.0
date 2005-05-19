From: happycactus@vene.ws (HappyCactus)
Date: Thu, 19 May 2005 06:24:04 +0000
Subject: lm_sensors and 2.4.21 kernel patches
Message-Id: <20030709152306.690e38f1.happycactus@vene.ws>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I think that for this issue I should write you directly, if not, I
apologize.

I downloaded the kernel source patches for the 2.4.20 kernel, and tryed
to patch my 2.4.21, obviously did not work correctly.
Only 3 files did not patched automagically:

wiseowl:/home/happycactus/temp/linux-2.4.21# find ./ -name *.rej
./include/linux/i2c-id.h.rej
./include/linux/i2c.h.rej
./drivers/i2c/Config.in.rej

So I patched those files by hand.
the result was the patch I attached.
Alas, my chipset is not supported, so I cannot verify the correctness
of this patch, but the kernel and the i2c modules compiles correctly.
It is a Sis chipset, identified by sensors-detect as sis5595... 
If you think those files useless, feel free to forget it.

thank you very much and hope that helps in some way...

Regards

HappyCactus@vene.ws


-------------- next part --------------
A non-text attachment was scrubbed...
Name: 2.4.21-lm-patches
Type: application/octet-stream
Size: 13071 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030709/77bfe00e/2.4.obj
