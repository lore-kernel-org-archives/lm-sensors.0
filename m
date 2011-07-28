From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 28 Jul 2011 06:27:14 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] hwmon: (lm90) Simplify handling of
Message-Id: <20110728062714.GA22026@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110724203520.07a3f202@endymion.delvare>
In-Reply-To: <20110724203520.07a3f202@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Jul 24, 2011 at 02:35:20PM -0400, Jean Delvare wrote:
> The optional extended local temperature register can never have
> address 0, as this address is already used by another register. Thus
> we can get rid of flag LM90_HAVE_LOCAL_EXT and simply rely on
> reg_local_ext being non-zero to determine if a given chip has this
> extension or not. This makes the code more simple.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Stijn Devriendt <sdevrien@cisco.com>
> Cc: Guenter Roeck <guenter.roeck@ericsson.com>

Applied (with the max6657 fix applied to the original patch breaking it).

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
