From: Alan Cox <alan@linux.intel.com>
Date: Tue, 04 May 2010 22:53:35 +0000
Subject: Re: [lm-sensors] [PATCH 4/4] emc1403: thermal sensor support
Message-Id: <20100504235335.0f236d76@linux.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100414125205.23181.15562.stgit@localhost.localdomain>
In-Reply-To: <20100414125205.23181.15562.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I am just realizing that my indent may have been misinterpreted. All I
> was saying was that it wasn't up to the hwmon subsystem to
> _standardize_ on power up/down sysfs attributes. 

Ah - that makes more sense

I'll worry about that later - I have to work out how to fit it all into
the mrst platform power management code which uses it for thermal
management. I'm not sure being able to turn off the sensor doing board
power/thermal management except via the power manager in such cases is
a good idea 8)

Alan

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
