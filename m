From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 26 Aug 2015 15:26:25 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: The Code Crashes
Message-Id: <55DDDAA1.6010502@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1440567719-27643-2-git-send-email-corone.il.han@gmail.com>
In-Reply-To: <1440567719-27643-2-git-send-email-corone.il.han@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 08/26/2015 07:56 AM, Il Han wrote:
> 2015-08-26 23:06 GMT+09:00 Guenter Roeck <linux@roeck-us.net <mailto:linux@roeck-us.net>>:
>
>     On 08/25/2015 10:41 PM, Il Han wrote:
>
>         The code crashes, since dev is not an i2c client device.
>
>         Signed-off-by: Il Han <corone.il.han@gmail.com <mailto:corone.il.han@gmail.com>>
>
>
>     You lost me a bit here. Why did you make this a separate patch ?
>
>     Also, please version your patches and provide a change log.
>     I am sure I asked for that before.
>
>     Thanks,
>     Guenter
>
>
> Sorry.
> Because I'm not accustomed to commit them with git, I made the mistake.
> confused about making a patch version such as [PATCH v2], providing a change log, etc.
> I am going to look up about git commit.

You might be looking for
	git format-patch --subject-prefix="PATCH v2"

Providing a change log doesn't mean to provide separate patches. It means
to tag the patch with a version number ("PATCH v2" instead of "PATCH"),
and to describe the changes below the '---' line in the patch.
This is described in detail in Documentation/SubmittingPatches.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
