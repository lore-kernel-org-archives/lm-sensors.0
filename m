From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 06 Jun 2015 04:59:02 +0000
Subject: Re: [lm-sensors] support for ITE IT8732F
Message-Id: <55727E16.20008@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CADRFTFK_xpN1sxxCG+8OH3TgOngpjLbnZjDqGFC_iTpMBCstAg@mail.gmail.com>
In-Reply-To: <CADRFTFK_xpN1sxxCG+8OH3TgOngpjLbnZjDqGFC_iTpMBCstAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 06/05/2015 06:21 PM, Wesley Pegden wrote:
> This is found on the lenovo ThinkCentre M93z all-in-one.
>
> This would be particularly nice to have because the default bios control of
> fan is very annoying (it cycles speeds constantly... people complain about
> this often on lenovo forums).  If this chip was supported that would give a
> simple fix for the problem in linux, at least.
>
> I could help with testing.
>

Unfortunately we don't have a datasheet, making it all but impossible
to add support for this chip.

You could try something like "sudo modprobe it87 force_id=0x8728",
to see if you get anything useful, but no guarantees, and it would be
on your own risk.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
