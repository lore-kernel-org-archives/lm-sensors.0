From: Henrik Rydberg <rydberg@euromail.se>
Date: Wed, 10 Nov 2010 22:33:28 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: (applesmc) Fix checkpatch errors
Message-Id: <4CDB1DB8.5070302@euromail.se>
List-Id: <lm-sensors.vger.kernel.org>
References: <1289428231-14950-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1289428231-14950-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Jean Delvare <khali@linux-fr.org>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On 11/10/2010 11:30 PM, Guenter Roeck wrote:

> This patch fixes all checkpatch errors and most of the checkpatch warnings.
> It also fixes the range check in applesmc_store_fan_speed().
> 
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
> v2:
> - Moved change in applesmc_key_at_index_store() into a previous patch
>   (Introduce a register lookup table) where a range check was added as well.
> - Updated description to indicate that a minor bug was fixed in addition
>   to the formatting changes.


Acked-by: Henrik Rydberg <rydberg@euromail.se>

Thanks,
Henrik

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
