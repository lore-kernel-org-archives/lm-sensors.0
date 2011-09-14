From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 14 Sep 2011 11:15:36 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (coretemp) Initialize tmin
Message-Id: <20110914111536.GA7250@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110914104307.637e5391@endymion.delvare>
In-Reply-To: <20110914104307.637e5391@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Sep 14, 2011 at 04:43:07AM -0400, Jean Delvare wrote:
> ttarget is initialized when the driver is loaded, but tmin is not.
> As a result, tempX_max_hyst attributes read 0. Fix this.
> 
> Also use THERM_*_THRESHOLD* constants in these initializations instead
> of hard-coding the constants.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: "R, Durgadoss" <durgadoss.r@intel.com>
> Cc: Guenter Roeck <guenter.roeck@ericsson.com>
> Cc: Fenghua Yu <fenghua.yu@intel.com>

Works nicely. Applied.

Thanks a lot for looking into this.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
