From: r.marek@assembler.cz (Rudolf Marek)
Date: Sun, 10 Dec 2006 17:50:19 +0000
Subject: [lm-sensors] [PATCH 2/3] coretemp driver
Message-Id: <457C48DB.9040806@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <45329AC7.3040008@assembler.cz>
In-Reply-To: <45329AC7.3040008@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello all,

I fixed the issue reported by George (BUG: using smp_processor_id() in
preemptible [00000001] code: modprobe/2279)

I'm attaching fixed version, it is just compile tested but I believe it will work.

if (current_cpu_data.x86_vendor != X86_VENDOR_INTEL)

Changed to:
     if (cpu_data[0].x86_vendor != X86_VENDOR_INTEL)

I need to check any CPU here, so I  got rid of the smp_processor_id which is
hidden in current_cpu_data.

Signed-off-by: Rudolf Marek <r.marek at assembler.cz>

This patch adds support for the temperature sensor found in recent Intel Core
processors.

Rudolf
-------------- next part --------------
A non-text attachment was scrubbed...
Name: add-coretemp-driver.patch
Type: text/x-diff
Size: 11913 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061210/6babb53d/attachment.bin 
