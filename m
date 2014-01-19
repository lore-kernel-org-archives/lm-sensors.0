From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 19 Jan 2014 16:58:23 +0000
Subject: Re: [lm-sensors] [PATCH] Do not order services after syslog.target
Message-Id: <20140119175823.412ac644@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1390141945-3610-1-git-send-email-ville.skytta@iki.fi>
In-Reply-To: <1390141945-3610-1-git-send-email-ville.skytta@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sun, 19 Jan 2014 16:32:25 +0200, Ville Skytt=E4 wrote:
> http://www.freedesktop.org/wiki/Software/systemd/syslog/
> https://fedorahosted.org/fpc/ticket/177#comment:2
> http://lists.opensuse.org/archive/opensuse-packaging/2013-05/msg00102.html

Next time, please provide a proper commit message. References are good
as an addition to the commit message, not as a replacement thereof.

> ---
>  prog/init/lm_sensors.service | 1 -
>  prog/init/sensord.service    | 1 -
>  2 files changed, 2 deletions(-)
> (...)

Patch applied, thanks.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
