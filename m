From: atull <atull@opensource.altera.com>
Date: Tue, 07 Oct 2014 14:38:10 +0000
Subject: Re: [lm-sensors] [PATCH v5 3/4] pmbus: add regulator support
Message-Id: <alpine.DEB.2.02.1410070937540.9610@atx-linux-37>
List-Id: <lm-sensors.vger.kernel.org>
References: <1412275071-6417-1-git-send-email-atull@opensource.altera.com> <1412275071-6417-4-git-send-email-atull@opensource.altera.com> <20141003142746.GA24441@sirena.org.uk>
In-Reply-To: <20141003142746.GA24441@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>
Cc: linux@roeck-us.net, jdelvare@suse.de, lm-sensors@lm-sensors.org, lgirdwood@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, delicious.quinoa@gmail.com, dinguyen@opensource.altera.com, yvanderv@opensource.altera.com

On Fri, 3 Oct 2014, Mark Brown wrote:

> On Thu, Oct 02, 2014 at 01:37:50PM -0500, atull@opensource.altera.com wrote:
> > From: Alan Tull <atull@opensource.altera.com>
> > 
> > Add support for simple on/off control of each channel.
> > 
> > To add regulator support, the pmbus part driver needs to add
> > regulator_desc information and number of regulators to its
> > pmbus_driver_info struct.
> 
> Reviewed-by: Mark Brown <broonie@kernel.org>
>

Thanks!

Alan

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
