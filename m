From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 14 Sep 2010 07:54:52 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon/emc1403: remove unnecessary
Message-Id: <20100914095452.0d28a221@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100914023351.GA27145@ywang-moblin2.bj.intel.com>
	<20100914032211.GA3497@ericsson.com>
In-Reply-To: <20100914032211.GA3497@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Yong Wang <yong.y.wang@linux.intel.com>, Alan Cox <alan@linux.intel.com>, Kalhan Trisal <kalhan.trisal@intel.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Mon, 13 Sep 2010 20:22:11 -0700, Guenter Roeck wrote:
> On Mon, Sep 13, 2010 at 10:33:51PM -0400, Yong Wang wrote:
> > It is unnecessary to call hwmon_device_unregister in error handling
> > before hwmon_device_register is called.
> > 
> Not only unnecessary but wrong. Good catch.
> 
> > Signed-off-by: Yong Wang <yong.y.wang@intel.com>
> 
> Reviewed-by: Guenter Roeck <guenter.roeck@ericsson.com>

Applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
