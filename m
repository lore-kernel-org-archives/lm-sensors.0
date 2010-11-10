From: Henrik Rydberg <rydberg@euromail.se>
Date: Wed, 10 Nov 2010 22:48:40 +0000
Subject: Re: [lm-sensors] [PATCH v4] hwmon: (applesmc) Introduce a register
Message-Id: <4CDB2148.8080404@euromail.se>
List-Id: <lm-sensors.vger.kernel.org>
References: <1289429274-30289-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1289429274-30289-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Jean Delvare <khali@linux-fr.org>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On 11/10/2010 11:47 PM, Guenter Roeck wrote:

> From: Henrik Rydberg <rydberg@euromail.se>
> 
> One main problem with the current driver is the inability to quickly
> search for supported keys, resulting in detailed feature maps per
> machine model which are cumbersome to maintain.
> 
> This patch adds a register lookup table, which enables binary search
> for supported keys. The lookup also reduces the io frequency, so the
> original mutex is replaced by locks around the actual io.
> 
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> [guenter.roeck@ericsson.com: Added value range check to key_at_index_store()]
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
> Patch as applied, with added value range check to applesmc_key_at_index_store().


Works nicely, much obliged. It's a wrap. :-)

Thanks,
Henrik

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
