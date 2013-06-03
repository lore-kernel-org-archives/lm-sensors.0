From: Jason Cooper <jason@lakedaemon.net>
Date: Mon, 03 Jun 2013 14:15:22 +0000
Subject: Re: [lm-sensors] [PATCHv3 0/3] Add G762/G763 PWM fan controller
Message-Id: <20130603141522.GE3803@titan.lakedaemon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <cover.1370202835.git.arno@natisbad.org>
 <20130603023053.GA11723@roeck-us.net>
In-Reply-To: <20130603023053.GA11723-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Olivier Mouchet <olivier.mouchet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Simon Guinot <simon.guinot-jKBdWWKqtFpg9hUCZPvPmw@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Arnaud Ebalard <arno-LkuqDEemtHBg9hUCZPvPmw@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>

On Sun, Jun 02, 2013 at 07:30:53PM -0700, Guenter Roeck wrote:
> On Sun, Jun 02, 2013 at 10:14:05PM +0200, Arnaud Ebalard wrote:
...
> > note: this should not be an issue but this v3 is based on
> >       jcooper/mvebu/fixes branch. 
> > 
> I don't know about this branch/repository. If there are hwmon fixes in it,
> they should be submitted to the lm-sensors mailing list.

Yes, please, unless you *need* a patch to build/boot that isn't in
mainline yet, always base off of one of Linus' tags, eg v3.10-rc4.  Then,
if asked, rebase as needed.

thx,

Jason.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
