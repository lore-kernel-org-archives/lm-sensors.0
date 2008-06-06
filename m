From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 06 Jun 2008 14:27:40 +0000
Subject: Re: [lm-sensors] [PATCH 2.6.25.4] hwmon: HP Mobile Data Protection
Message-Id: <20080606102636.ZZRA012@mailhub.coreip.homeip.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1212235533.3815.5.camel@localhost> <4846EBF5.2030406@tremplin-utc.net>
In-Reply-To: <4846EBF5.2030406@tremplin-utc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ??ric Piel <Eric.Piel@tremplin-utc.net>
Cc: Andrew Morton <akpm@osdl.org>, pavel@ucw.cz, Arjan van de Ven <arjan@infradead.org>, "Mark M. Hoffman" <mhoffman@lightlink.com>, Yan Burman <burman.yan@gmail.com>, LKML <linux-kernel@vger.kernel.org>, HWMON <lm-sensors@lm-sensors.org>

Hi,

On Wed, Jun 04, 2008 at 09:24:37PM +0200, ??ric Piel wrote:
> Hello,
> We haven't received any review for this driver since last week's post by
> Yan :-( That's why I'm adding explicitly as receivers of this email all
> the people who have reviewed the first two previous takes. Apologies for
> the possible multiple receptions.
> 
> It would be _really really kind_ if some of you could take some time and
> comment (or simply ACK ;-) ) this code. It adds support for hardware
> which can be found in mostly every HP Compaq laptop less than three
> years old. It's quite worthy.
> 

I would recommend converting the input piece to input_polled_device
instead of managing the polling thread by yourselves.

-- 
Dmitry

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
