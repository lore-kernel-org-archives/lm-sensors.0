From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 23 Nov 2013 18:38:08 +0000
Subject: Re: [lm-sensors] [PATCHv5 06/20] hwmon: lm75: expose to thermal fw via DT nodes
Message-Id: <20131123193808.46f303a8@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1384285582-16933-1-git-send-email-eduardo.valentin@ti.com>
	<1384285582-16933-7-git-send-email-eduardo.valentin@ti.com>
	<20131115084354.656452b9@endymion.delvare>
	<528A23DD.2070406@ti.com>
	<20131119103948.0ec9daba@endymion.delvare>
	<528F6C10.5050704@ti.com>
In-Reply-To: <528F6C10.5050704@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: swarren@wwwdotorg.org, pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com, rob.herring@calxeda.com, linux@roeck-us.net, rui.zhang@intel.com, wni@nvidia.com, grant.likely@linaro.org, durgadoss.r@intel.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Fri, 22 Nov 2013 10:37:04 -0400, Eduardo Valentin wrote:
> Yeah, but I see your point. You probably want to have first code changes
> done properly so that if we have code duplication, it does not spread
> like a disease, like usually does. It is unavoidable to base new drivers
> on existing ones. So better to get first converted drivers to be done
> properly. I like this approach.

Not only that, but also getting things right (as much as we are able
to) at first avoids having to touch 20 already converted drivers when
you attempt to convert the 21st one and it doesn't fit in the API.

> (...)
> OK. So I assume you are proposing something like:
> 	.get_temp(struct device *dev, int id, long *temp);
> 
> right?

Yes.

> (...)
> In the end of the day, the APIs and driver support will be really well
> defined when we convert most of the drivers. But I would like to this in
> a separated patch series.
> 
> What is your view? Are you OK if we integrate this series as a first
> step of the complete process?

Yes we are.

> (...)
> Thanks for the good feedback.

You're welcome.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
