From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 16 Jun 2012 16:55:33 +0000
Subject: Re: [lm-sensors] [PATCH 45/95] hwmon: (lm77) Convert to use devm_ functions
Message-Id: <20120616185533.55a0f0cf@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1339773856-3443-46-git-send-email-linux@roeck-us.net>
In-Reply-To: <1339773856-3443-46-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 15 Jun 2012 08:23:26 -0700, Guenter Roeck wrote:
> Convert to use devm_ functions to reduce code size and simplify the code.
> 
> Also rename new_client variable, and define new variable for client->dev, to
> improve code readability.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/lm77.c |   73 +++++++++++++++++++++++---------------------------
>  1 file changed, 33 insertions(+), 40 deletions(-)

Acked-by: Jean Delvare <khali@linux-fr.org>

Although ideally this would have been done as two separate patches.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
