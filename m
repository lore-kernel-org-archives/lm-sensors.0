From: r.marek@assembler.cz (Rudolf Marek)
Date: Tue, 17 Oct 2006 21:29:28 +0000
Subject: [lm-sensors] [PATCH 1/3] export the do_rdmsr/do_wrmsr function
Message-Id: <45354B38.7060501@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <453299F8.8020503@assembler.cz>
In-Reply-To: <453299F8.8020503@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

Here comes an updated patch. The functions are exported as msr_read and 
msr_write. I think I fixed the compilation isssues.

Regards
Rudolf
-------------- next part --------------
A non-text attachment was scrubbed...
Name: merge-msr-funcs.patch
Type: text/x-patch
Size: 4094 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061017/3c6f20db/attachment.bin 
