From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Fri, 03 Jul 2009 07:07:08 +0000
Subject: Re: [lm-sensors] asm58 (Mozart-2) driver for 2.6.30
Message-Id: <4A4DAE1C.7020008@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <op.uv8cuijly4uxjo@localhost>
In-Reply-To: <op.uv8cuijly4uxjo@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On 06/28/2009 12:31 PM, Michael Lo=C3=9Fin wrote:
> Hello everyone,
>
> I understand since there is no datasheet available for the asm58
> (Mozart-2) chip,
> it won't be officially supported by lm-sensors.
>
> Anyway, I ported the old driver by Rigel Freden found at
>
> http://lists.lm-sensors.org/pipermail/lm-sensors/2006-March/015735.html
>
> to the 2.6.30 kernel. So if anyone wants to get this chip working,
> just apply the attached kernel patch and update sensors3.conf
> with the asm58 section.
>
> This is a "works-for-me" patch, but I'd be interested in any adjustments =
or
> fixes that need to be done.
>

Hi,

Are you interested in maintaining this driver as part of the mainline kerne=
l?

The fact that there is no datasheet does not mean the driver cannot go into=
 the
mainline, it just means that it is hard to write a driver. Since that part =
is
already done, it can go in to the mainline if someone is willing to actively
maintain it (as needed, will probably not be a lot of work).

If you're interested in this I'll do a full review of the driver and get ba=
ck to
you on this.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
