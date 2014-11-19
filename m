From: Alexandre Courbot <gnurou@gmail.com>
Date: Wed, 19 Nov 2014 08:06:24 +0000
Subject: Re: [lm-sensors] [PATCHv4 1/1] thermal: of: improve of-thermal sensor registration API
Message-Id: <CAAVeFu+aUdpV_hj50TAZDO_5JgRmPH2RtJuP7Qozx4RNEzO-6A@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1416321575-18348-1-git-send-email-edubezval@gmail.com> <1416321575-18348-2-git-send-email-edubezval@gmail.com>
In-Reply-To: <1416321575-18348-2-git-send-email-edubezval@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, Caesar Wang <caesar.wang@rock-chips.com>, Wei Ni <wni@nvidia.com>, Lukasz Majewski <l.majewski@samsung.com>, Mikko Perttunen <mikko.perttunen@kapsi.fi>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, lm-sensors@lm-sensors.org, Rob Herring <robh+dt@kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Zhang Rui <rui.zhang@intel.com>

On Tue, Nov 18, 2014 at 11:39 PM, Eduardo Valentin <edubezval@gmail.com> wrote:
> Different drivers request API extensions in of-thermal. For this reason,
> additional callbacks are required to fit the new drivers needs.
>
> The current API implementation expects the registering sensor driver
> to provide a get_temp and get_trend callbacks as function parameters.
> As the amount of callbacks is growing, this patch changes the existing
> implementation to use a .ops field to hold all the of thermal callbacks
> to sensor drivers.
>
> This patch also changes the existing of-thermal users to fit the new
> API design. No functional change is introduced in this patch.

A good idea even if no ops were to be added!

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
