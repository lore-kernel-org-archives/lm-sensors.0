From: Robert Coulson <rob.coulson@gmail.com>
Date: Thu, 04 Dec 2014 23:49:54 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm75) Strengthen detect function
Message-Id: <CAEZKy8LZHWfkfDN3+1iqB4_C2g0E=F2CTcHthApd6k+OaTa9Ow@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1417716250-14598-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1417716250-14598-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Dec 4, 2014 at 1:08 PM, Guenter Roeck <linux@roeck-us.net> wrote:

> On Thu, Dec 04, 2014 at 12:16:29PM -0800, Robert Coulson wrote:
> > Hello Guenter,
> >
> > does it also make sense to include a check for the conf != 0 here (it
> > should be set to 0 for POR from the datasheet)? Other than this
> > quesiton/comment, the code looks fine to me.
> >
> Hi Rob,
>
> the configuration register could be set to a non-zero value,
> for example by the BIOS or rommon. Sure, that is in theory possible
> for the hysteresis and limit registers as well, but that would be
> both unlikely and unreasonable.
>
> Thanks,
> Guenter
>

 Good points. Without explicit values for chip detection, it will never be
guaranteed.

I appreciate your feedback,

*** Rob.

Reviewed-by: <rob.coulson@gmail.com>
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
