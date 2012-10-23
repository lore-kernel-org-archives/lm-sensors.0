From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 23 Oct 2012 14:00:37 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Fix chip feature table headers
Message-Id: <20121023140037.GA29967@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20121023113520.72087ec4@endymion.delvare>
In-Reply-To: <20121023113520.72087ec4@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Oct 23, 2012 at 11:35:20AM +0200, Jean Delvare wrote:
> From: Jean Delvare <khali@linux-fr.org>
> Subject: hwmon: Fix chip feature table headers
> 
> These got broken by recent patches fixing checkpatch warnings in these
> drivers. The trick is that the patches themselves looked good, but the
> source files after applying them do not. That's why I am not a big fan
> of using tabs inside comments.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Guenter Roeck <linux@roeck-us.net>

Looks like I wasn't careful enough ...

Acked-by: Guenter Roeck <linux@roeck-us.net>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
