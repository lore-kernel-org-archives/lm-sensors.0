From: gtj.devel@peakin.com (George T. Joseph (development))
Date: Wed, 06 Dec 2006 03:41:43 +0000
Subject: [lm-sensors] Problem loading coretemp...
Message-Id: <22E26940476D1E48AA6F292B5316C9C33752@bes1.peakin.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On a Core 2 Duo E6600 running 2.6.19, when I load the module, I get...
 
[   25.231019] BUG: using smp_processor_id() in preemptible [00000001]
code: modprobe/2279
[   25.234481] caller is coretemp_init+0x13/0x129 [coretemp]
[   25.238029]  [<c0104f0c>] dump_trace+0x64/0x1d0
[   25.241603]  [<c0105092>] show_trace_log_lvl+0x1a/0x2f
[   25.245176]  [<c01056d1>] show_trace+0x12/0x14
[   25.248706]  [<c0105798>] dump_stack+0x19/0x1b
[   25.252186]  [<c01d690d>] debug_smp_processor_id+0x8d/0xa0
[   25.255660]  [<f8de1013>] coretemp_init+0x13/0x129 [coretemp]
[   25.259181]  [<c013f018>] sys_init_module+0x98/0x1dc
[   25.262696]  [<c0103fed>] sysenter_past_esp+0x56/0x79
[   25.266201]  [<b7f8f410>] 0xb7f8f410
[   25.269693]  ===========
I think the problem is...
 
static int __init coretemp_init(void)
{
 int i, err = -ENODEV;
 struct pdev_entry *p, *n;
/***/
 if (current_cpu_data.x86_vendor != X86_VENDOR_INTEL)
/***/
  goto exit;


george
 
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061205/eadab1f9/attachment.html 
