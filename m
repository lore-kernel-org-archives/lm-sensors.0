From: "David Hubbard" <david.c.hubbard@gmail.com>
Date: Tue, 10 Apr 2007 13:56:28 +0000
Subject: Re: [lm-sensors] Hardware monitoring subsystem maintainer position
Message-Id: <4dfa50520704100656n2b8382c5md48f433e460bf582@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070410150227.1bac05b5@hyperion.delvare>
In-Reply-To: <20070410150227.1bac05b5@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: LM Sensors <lm-sensors@lm-sensors.org>, LKML <linux-kernel@vger.kernel.org>, "Mark M. Hoffman" <mhoffman@lightlink.com>, Hans de Goede <j.w.r.degoede@hhs.nl>

Jean,

I for one will greatly miss your knowledge and helpful hints when I
work on hardware monitoring drivers. I hope you find success in all
the things you do!

I understand the difficult position you're in, and if there's any way
I could convince you to stay, I would. Maybe you would be willing to
answer a few low-bandwidth questions from time to time? Or jump on to
#linux-sensors every once in a while?

Either way, thanks for everything!

Cheers,
David

On 4/10/07, Jean Delvare <khali@linux-fr.org> wrote:
> Hi all,
>
> I am resigning from my role as hardware monitoring subsystem
> (drivers/hwmon) maintainer. This is too much work for me, I do not have
> the necessary bandwidth to review all the incoming patches, in
> particular new drivers, in a timely manner. Patch authors have been
> complaining about this repeatedly. This is no fun for them, and even
> less for me, so I'd rather let someone else with more spare time take
> care of it. If there are volunteers, this is the right time to speak up.
>
> I will still be maintaining the individual hardware monitoring drivers
> I am listed for in file MAINTAINERS (adm1025, f71805f, lm83 and lm90)
> as well as the I2C subsystem. No change here.
>
> I will continue to feed -mm with pending hwmon patches until 2.6.21
> final is released, then I'll send everything I have to Linus for
> 2.6.22-rc1, the last of which will be:
>
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
>  MAINTAINERS |    5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> --- linux-2.6.21-rc6.orig/MAINTAINERS   2007-04-10 13:49:09.000000000 +0200
> +++ linux-2.6.21-rc6/MAINTAINERS        2007-04-10 14:28:31.000000000 +0200
> @@ -1467,12 +1467,9 @@ W:       http://gigaset307x.sourceforge.net/
>  S:     Maintained
>
>  HARDWARE MONITORING
> -P:     Jean Delvare
> -M:     khali@linux-fr.org
>  L:     lm-sensors@lm-sensors.org
>  W:     http://www.lm-sensors.org/
> -T:     quilt http://khali.linux-fr.org/devel/linux-2.6/jdelvare-hwmon/
> -S:     Maintained
> +S:     Orphan
>
>  HARDWARE RANDOM NUMBER GENERATOR CORE
>  P:     Michael Buesch
>
> Then I'll probably keep an eye on hwmon in Linus' tree until 2.6.22
> final is released, and after that I'm done with it.
>
> --
> Jean Delvare
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
