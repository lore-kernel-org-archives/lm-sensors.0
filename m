From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 07 Mar 2011 22:22:57 +0000
Subject: Re: [lm-sensors] [PATCH v2 01/01] hwmon: (w83627ehf) Add fan
Message-Id: <20110307222257.GA14930@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <7E56C3DF95D0439295EE35310161EE11@portable2>
In-Reply-To: <7E56C3DF95D0439295EE35310161EE11@portable2>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Mar 07, 2011 at 04:10:01PM -0500, Ian Dobson wrote:
> Hello,
> 
> Version 1
> The nct6776f and nct6775f support debouncing the fan RPM signal, this can 
> help improve the stability of th RPM signal for some fans (Arctic cooling 
> fans for example).
> This patch adds a module parameter fan_debounce, which when set to 1 enables 
> debounce for all fans that the chip supports.
> 
> Version 2
> Coding style changes based on comments from Guenter Roeck.
> Move the register setting code to w83627ehf_probe from w83627ehf_find
> 
> Signed-off-by:  Ian Dobson <i.dobson@planet-ian.com>

Excellent. 

Thanks, applied.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
