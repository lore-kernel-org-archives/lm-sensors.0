From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 15 Apr 2011 09:31:52 +0000
Subject: Re: [lm-sensors] [PATCH v5] hwmon: Add driver for AMD family 15h
Message-Id: <20110415113152.1627c5f3@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110404160733.GA11818@alberich.amd.com>
	<20110405144536.GA5054@alberich.amd.com>
	<20110406135424.GC2177@alberich.amd.com>
	<20110408135407.GA12014@alberich.amd.com>
	<20110414192011.GB773@alberich.amd.com>
In-Reply-To: <20110414192011.GB773@alberich.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andreas Herrmann <herrmann.der.user@googlemail.com>
Cc: Guenter Roeck <guenter.roeck@ericsson.com>, Thomas Renninger <trenn@suse.de>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Clemens Ladisch <clemens@ladisch.de>

On Thu, 14 Apr 2011 21:20:11 +0200, Andreas Herrmann wrote:
> From: Andreas Herrmann <andreas.herrmann3@amd.com>
> 
> This CPU family provides NB register values to gather following
> TDP information
> 
> * ProcessorPwrWatts: Specifies in Watts the maximum amount of power
>   the processor can support.
> * CurrPwrWatts: Specifies in Watts the current amount of power being
>   consumed by the processor.
> 
> This driver provides
> 
> * power1_crit (ProcessorPwrWatts)
> * power1_input (CurrPwrWatts)
> (...)

Applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
