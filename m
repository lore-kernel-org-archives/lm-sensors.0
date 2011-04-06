From: Andreas Herrmann <herrmann.der.user@googlemail.com>
Date: Wed, 06 Apr 2011 14:00:26 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Refactor AMD CPU sensor
Message-Id: <20110406140026.GD2177@alberich.amd.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110406151736.6c439c80@endymion.delvare>
In-Reply-To: <20110406151736.6c439c80@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Apr 06, 2011 at 03:17:36PM +0200, Jean Delvare wrote:
> Except for the Family 10h case which is more complex, AMD CPU sensor
> detection is straightforward, so we don't really need a dedicated
> function for each CPU family. By passing the expected F3 PCI device ID
> as a parameter, we can use the same function for all families.
> 
> Objection anyone? This could be seen as moving some of the detection
> code into @cpu_ids itself, but OTOH it saves quite a few lines of
> redundant code.

No objections -- of cours, it's a good idea.

BTW, detection for "AMD Family 15h thermal sensors" can also be used
for f15h_power (once the driver is accepted/integrated).


Regards,
Andreas

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
