From: Jean Delvare <jdelvare@suse.de>
Date: Mon, 03 Feb 2014 15:05:31 +0000
Subject: Re: [lm-sensors] [PATCH v2 2/4] hwmon: (lm63) Introduce 'dev' variable to point to client->dev
Message-Id: <20140203160531.423c168d@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1391390510-19238-3-git-send-email-linux@roeck-us.net>
In-Reply-To: <1391390510-19238-3-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Sun,  2 Feb 2014 17:21:48 -0800, Guenter Roeck wrote:
> client->dev is used multiple times in several functions.
> Introduce dev variable pointing to it to simplify the code.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/lm63.c |   32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> (...)

Retrospectively, this patch should have been last in the series, it
would have been much smaller then. But I'm sure you have better things
to do that respin this patch series again, so I have applied it as is.

-- 
Jean Delvare
Suse L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
