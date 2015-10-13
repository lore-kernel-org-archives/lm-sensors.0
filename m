From: "Odzioba, Lukasz" <lukasz.odzioba@intel.com>
Date: Tue, 13 Oct 2015 22:45:16 +0000
Subject: Re: [lm-sensors] [PATCH 1/1] Bumps limit of maximum core ID from 32 to 128.
Message-Id: <D6EDEBF1F91015459DB866AC4EE162CC023173BF@IRSMSX103.ger.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1444650812-17398-1-git-send-email-lukasz.odzioba@intel.com>
 <20151013203134.GA28106@roeck-us.net>
 <D6EDEBF1F91015459DB866AC4EE162CC0231739E@IRSMSX103.ger.corp.intel.com>
 <561D8514.2040503@roeck-us.net>
In-Reply-To: <561D8514.2040503@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: "Yu, Fenghua" <fenghua.yu@intel.com>, "jdelvare@suse.de" <jdelvare@suse.de>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Phil Pokorny <ppokorny@penguincomputing.com>

On Wednesday, October 14, 2015 at 12:26 AM, Guenter Roeck wrote:
> Pardon my ignorance ... those are Xeon Phi processors, and support up to
> 244 threads (for Knights Corner). Programming datasheet isn't easily available,
> so I have to guess a bit. Following the processor numbering scheme of "ordinary"
> processors, the CPU ID can therefore be up to 244 (at least) already today,
> meaning the limit would have to be 256 (assuming that the processor does support
> per-core temperature sensors). On the other side, the public datasheet suggests
> that there are only three temperature sensors.

> What am I missing here ?

Knights Corner can have up to 61 cores with 4 threads per core, so up to 244 threads.
All HT siblings reads temperature from the same core and coretemp driver is aware of it.
That's it needs just one temp_data structure for all threads on given core.
I tested 128 on real HW myself.

Thanks,
Lukas

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
