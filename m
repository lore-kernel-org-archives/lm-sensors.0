From: Wei Ni <wni@nvidia.com>
Date: Tue, 10 Sep 2013 11:29:40 +0000
Subject: Re: [lm-sensors] [PATCH v3 1/2] hwmon: (lm90) Add power control
Message-Id: <522F02A4.7060702@nvidia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20130909111242.GW29403@sirena.org.uk> <522DB253.6000707@roeck-us.net> <20130909135022.GZ29403@sirena.org.uk> <20130909155043.GA18975@roeck-us.net> <20130909160237.GR29403@sirena.org.uk> <20130909161735.GC18975@roeck-us.net> <20130909203910.GV29403@sirena.org.uk> <522E9A85.9050803@nvidia.com> <522EA51C.90706@roeck-us.net> <522EB0AF.9030708@nvidia.com> <20130910101359.GX29403@sirena.org.uk>
In-Reply-To: <20130910101359.GX29403@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, "khali@linux-fr.org" <khali@linux-fr.org>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 09/10/2013 06:13 PM, Mark Brown wrote:
> * PGP Signed by an unknown key
> 
> On Tue, Sep 10, 2013 at 01:39:59PM +0800, Wei Ni wrote:
> 
>> I think the device need time to wait stable after power on, but it's
>> difficult to get an exact delay value, and this delay may also relate
>> with platform design, so how about to add a optional property in the DT
>> node, such as "power-on-delay-ms" ?
> 
> This is something you should *really* be able to get from the datasheet
> for the part - this sort of stuff has to be documented for hardware to
> be used robustly.  It seems entirely possible that you are working
> around an issue with the regulator driver you are using not correctly
> providing its ramp time here.

On my platform, it use palmas-regulator.c, ldo6 for this lm90 power
rail. I checked this driver, it will handle ramp_delay except LDOx.
Since I'm not familiar with this palmas device and driver, so do you
mean I can set regulator-ramp-delay property in the DT for ldo6, but I
really don't know what value should I set :(

Thanks.
Wei.

> 
> * Unknown Key
> * 0x7EA229BD
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
