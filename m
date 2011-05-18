From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Wed, 18 May 2011 16:58:49 +0000
Subject: Re: [lm-sensors] [PATCHv8 1/1] Hwmon: Merge Pkgtemp with Coretemp
Message-Id: <D6D887BA8C9DFF48B5233887EF046541095ADA9DB9@bgsmsx502.gar.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1305729702-11126-1-git-send-email-durgadoss.r@intel.com>
In-Reply-To: <1305729702-11126-1-git-send-email-durgadoss.r@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

> Strictly speaking, the rule would be to not have any ifdefs in the code in the
> first place.
> Might be worth exploring if we can get rid of the ifdefs by using a single set
> of defines
> at the top, such as
> 
> #ifdef CONFIG_SMP
> #define phys_proc_id(cpu)	cpu_data(cpu)->phys_proc_id
> #define cpu_core_id(cpu)	cpu_data(cpu)->cpu_core_id
> #else
> #define phys_proc_id(cpu)	(cpu)
> #define cpu_core_id(cpu)	(cpu)
> #endif
> 
> If you also unconditionally declare phys_proc_id and cpu_core_id in struct
> pdev_entry,
> that should enable us to get rid of pretty much all the ifdefs in the code.
> 
> Would be great if you could do that now, or we can do it in a subsequent patch.

I am not thinking about a new patch for this :)
Shall do this change in the next version itself..

Thanks,
Durga

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
