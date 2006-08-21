From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 21 Aug 2006 12:34:17 +0000
Subject: [lm-sensors] PATCH: hwmon-abituguru-suspend-resume.patch
Message-Id: <20060821143417.cec8280a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <44DB2470.3050507@hhs.nl>
In-Reply-To: <44DB2470.3050507@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

> This patch contains rudimentary suspend / resume support for the uguru,
> this protects the uguru and the driver against suspend / resume cycles,
> so there is no reason to unload the driver in your suspend / resume scripts.
> 
> I'm not sure if this is needed, does the sysfs code itself guarantee
> that no sysfs attr read/write calls are in progress before starting a
> resume, if it does then this patch most likely isn't needed.

Good question, I really don't know. If sysfs doesn't guarantee it, then
we should do something similar for all hardware monitoring drivers,
it's simple enough.

Maybe you can raise the question on LKML, or maybe linux-pm-devel
(doesn't seem too active though) or otherwise ask anyone with more
power management knowledge than I do?

> Except for
> protecting against this, it also checks the uguru is still in ready
> status after a resume, but that seems to be unnescesarry (as it seems
> that the uguru always is still ready after the resume).

Well this patch shouldn't harm, even if it doesn't do anything
useful ;) so I guess I can take it.

> @@ -1336,6 +1380,8 @@
>  	},
>  	.probe	= abituguru_probe,
>  	.remove	= __devexit_p(abituguru_remove),
> +	.suspend = abituguru_suspend,
> +	.resume = abituguru_resume
>  };

This makes the alignment a bit shaky, tabs and spaces mixed... I'll fix
it.

Thanks,
-- 
Jean Delvare

