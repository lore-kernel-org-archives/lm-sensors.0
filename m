From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 19 Nov 2013 14:43:30 +0000
Subject: Re: [lm-sensors] [PATCHv9 02/20] thermal: introduce device tree parser
Message-Id: <20131119154330.1951a978@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1384285582-16933-1-git-send-email-eduardo.valentin@ti.com>
	<1384285582-16933-3-git-send-email-eduardo.valentin@ti.com>
	<20131115090736.4f360dc8@endymion.delvare>
	<1384754650.2316.32.camel@rzhang-lenovo>
	<528A27EE.9090604@ti.com>
In-Reply-To: <528A27EE.9090604@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: Zhang Rui <rui.zhang@intel.com>, swarren@wwwdotorg.org, pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com, rob.herring@calxeda.com, linux@roeck-us.net, devicetree@vger.kernel.org, wni@nvidia.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, grant.likely@linaro.org

Eduardo, Rui,

I don't want to enter a long discussion here. I don't see get_trend()
being implemented by any currently existing hwmon driver. But if you
think future monitoring chips will be different and will be able to
implement get_trend(), well, you'll know better.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
