From: r.marek@assembler.cz (Rudolf Marek)
Date: Wed, 13 Dec 2006 21:45:13 +0000
Subject: [lm-sensors] [RFC] new MSR r/w functions per CPU
Message-Id: <45807469.6040609@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: hpa@zytor.com, norsk5@xmission.com
Cc: lkml <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>, bluesmoke-devel@lists.sourceforge.net

Hello all,

For my new coretemp driver[1], I need to execute the rdmsr on particular 
processor.  There is no such "global" function for that in the kernel so far.

The per CPU msr_read and msr_write are used in following drivers:

msr.c (it is static there now)
k8-edac.c  (duplicated right now -> driver in -mm)
coretemp.c (my new Core temperature sensor -> driver [1])

Question is how make an access to that functions. Enclosed patch does simple 
EXPORT_SYMBOL_GPL for them, but then both drivers (k8-edac.c and coretemp.c) 
would depend on the MSR driver. The ultimate solution would be to move this type
of function to separate module, but perhaps this is just bit overkill?

Any ideas what would be the best solution?

I would like to make sure that module refcounting is done in module.c, so I 
don't need to handle this in my patch.

Thanks,
Rudolf

Please CC me, I'm not on all lists.

[1] http://lists.lm-sensors.org/pipermail/lm-sensors/2006-December/018420.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: merge-msr-funcs.patch
Type: text/x-patch
Size: 4094 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061213/f144eb2c/attachment.bin 
