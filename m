From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 16 Oct 2014 21:24:15 +0000
Subject: Re: [lm-sensors] [PATCH v6 0/4] pmbus: ltc2978: add regulator support
Message-Id: <20141016212415.GA27469@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1413399310-19277-1-git-send-email-atull@opensource.altera.com>
In-Reply-To: <1413399310-19277-1-git-send-email-atull@opensource.altera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: atull@opensource.altera.com
Cc: jdelvare@suse.de, lm-sensors@lm-sensors.org, lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, delicious.quinoa@gmail.com, dinguyen@opensource.altera.com, yvanderv@opensource.altera.com

On Wed, Oct 15, 2014 at 01:55:06PM -0500, atull@opensource.altera.com wrote:
> From: Alan Tull <atull@opensource.altera.com>
> 
> Each output has individual on/off control.
> 
> New in v6:
>   * Much cleanup of the bindings document
>   * s/vout_en/vout/g
> 
> Hopefully this is getting closer.  We will still have the potential problem of
> repeated node names on boards on boards that have many regulators of the same
> kind.  If this can be handled in the regulator layer, that might be great.  
> If we handle it here, whatever we come up with will have to keep the same
> name over reboots and be predictable enough to serve as regulator node names
> in the DT.  I'm open for suggestions here.
> 
> This patchset now uses "regulator: of: Provide simplified DT parsing method"
> which are in the next-20141014 tag of linux-next.
> 
Hi Alan,

Since the problems we have seen are in the regulator core code and not
in your patches, I added the series to -next. I fixed up the 'compatible'
example in the devicetree description, so there is no need to resubmit
the patches.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
