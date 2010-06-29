From: Randy Dunlap <randy.dunlap@oracle.com>
Date: Tue, 29 Jun 2010 15:02:57 +0000
Subject: Re: [lm-sensors] linux-next: Tree for June 29 (hwmon/coretemp)
Message-Id: <20100629080257.43b365dd.randy.dunlap@oracle.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100629151938.6981044d.sfr@canb.auug.org.au>
In-Reply-To: <20100629151938.6981044d.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Rothwell <sfr@canb.auug.org.au>, Rudolf Marek <r.marek@assembler.cz>
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org, Huaxu Wan <huaxu.wan@intel.com>

On Tue, 29 Jun 2010 15:19:38 +1000 Stephen Rothwell wrote:

> Hi all,
> 
> Changes since 20100628:
> 
> My fixes tree is now empty.


when CONFIG_SMP is not enabled:

drivers/hwmon/coretemp.c:308: error: 'struct cpuinfo_x86' has no member named 'cpu_core_id'
drivers/hwmon/coretemp.c:428: error: 'struct cpuinfo_x86' has no member named 'phys_proc_id'
drivers/hwmon/coretemp.c:429: error: 'struct cpuinfo_x86' has no member named 'cpu_core_id'
drivers/hwmon/coretemp.c:457: error: 'struct cpuinfo_x86' has no member named 'phys_proc_id'
drivers/hwmon/coretemp.c:458: error: 'struct cpuinfo_x86' has no member named 'cpu_core_id'

---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
