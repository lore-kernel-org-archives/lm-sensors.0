From: Michal Marek <mmarek@suse.cz>
Date: Wed, 28 Oct 2015 11:15:16 +0000
Subject: Re: [lm-sensors] Duplicate htu21 drivers
Message-Id: <5630AE44.3040803@suse.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <56309D5C.30008@suse.cz> <20151028105128.770BF1E93@relay1.suse.de>
In-Reply-To: <20151028105128.770BF1E93@relay1.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "ludovic.tancerel@maplehightech.com" <ludovic.tancerel@maplehightech.com>
Cc: William Markezana <william.markezana@meas-spec.com>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Jonathan Cameron <jic23@kernel.org>, lm-sensors@lm-sensors.org, linux-iio@vger.kernel.org

Dne 28.10.2015 v 11:52 ludovic.tancerel@maplehightech.com napsal(a):
> Hello Michal,
> 
> the plan discussed with Jonathan and Guenter was to remove the driver
> in hwmon once the iio one was introduced.
> 
> Should I  provide a patch in Kconfig to make them conflict as of now
> ?

Then you can either execute your plan :), or make the hwmon driver
depend on HTU21=n.

Michal

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
