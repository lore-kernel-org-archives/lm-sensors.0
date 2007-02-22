From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 22 Feb 2007 16:47:43 +0000
Subject: [lm-sensors] [PATCH] hwmon: Request the I/O regions in platform
Message-Id: <20070222174743.3a58af3c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070221201208.0420dc7d.khali@linux-fr.org>
In-Reply-To: <20070221201208.0420dc7d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

On Thu, 22 Feb 2007 08:14:53 -0800, Juerg Haefliger wrote:
> I get
> Trying to free nonexistent resource <0000000000006000-000000000000607f>
> when unloading the module.
> 
> After module load, the resources are properly allocated (cat /proc/ioports):
> 6000-607f : vt1211
>   6000-607f : vt1211
> 
> I ran into this very same problem in the past where I get this warning
> after releasing a previously requested io region. Never figured out
> what's going on...

See this thread on LKML:
http://marc.theaimsgroup.com/?l=linux-kernel&m7183073419531&w=2

I posted a proposed fix, Dmitry Torokhov doesn't appear to like it. I'm
waiting for Greg KH's arbitration.

You can get my patch here if you want to give it a try:
http://lkml.org/lkml/diff/2007/2/20/310/1

Thanks,
-- 
Jean Delvare

