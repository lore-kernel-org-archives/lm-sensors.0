From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Tue, 25 Jul 2006 22:08:08 +0000
Subject: [lm-sensors] [PATCH] AMD K8 digital sensor
Message-Id: <44C69648.9060808@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello all,

This patch adds support for the temperature sensor(s) found in AMD K8 CPUs.

Signed-off-by: Rudolf Marek <r.marek at sh.cvut.cz>

Info for Jean:

This patch has only one bigger change compared to older version - the access 
width to register is now whole 32bits. This is neccessary for future 
enhancements because addtional reserved bits might be used for temperature, 
gaining more precision. Trust me ;)

The dependency is set to X86 because of usage of cpuid funcs. No need to check 
for specific procesor because it is in fact PCI driver. The latest version
works on dual core - dual procesor AMD server and it works fine on my single 
core Opteron too.

I'm leaving for next week and something -> on thursday. I would like to get this 
patch into 2.6.19, so if you have some minor comments please fix the patch as 
you like.

And info for users:
The userspace patch is still in here 
http://assembler.cz/download/amd_digital_temp.tar.gz
the patch itself is for 2.6.18rc-2 but should work on any post 2.6.15 kernel. If 
you need standalone version, use that one in the archive.

I will check into the SVN the userspace code once Jean or Mark says it is OK ;)

Thanks,
Regards
Rudolf
-------------- next part --------------
A non-text attachment was scrubbed...
Name: k8temp.patch
Type: text/x-patch
Size: 9921 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060726/bfb27574/attachment.bin 
