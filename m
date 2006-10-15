From: r.marek@assembler.cz (Rudolf Marek)
Date: Sun, 15 Oct 2006 20:28:40 +0000
Subject: [lm-sensors] [PATCH 1/3] export the do_rdmsr/do_wrmsr function
Message-Id: <453299F8.8020503@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello

Following patch exports the do_rdmsr/do_wrmsr functions from msr.c driver
because I need them. I think I need to rename them a bit and I'm not sure if I
need the #ifdef KERNEL stuff in header files. This functions could be used also
by k8edac driver (currently in -mm).

I'm open to the suggestion how to name them. Is there any policy for this?

Thanks,
Regards
Rudolf
-------------- next part --------------
A non-text attachment was scrubbed...
Name: merge-msr-funcs.patch
Type: text/x-patch
Size: 2489 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061015/4ac1dbe3/attachment.bin 
