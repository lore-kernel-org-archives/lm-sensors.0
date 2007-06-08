From: "Juerg Haefliger" <juergh@gmail.com>
Date: Fri, 08 Jun 2007 17:05:22 +0000
Subject: Re: [lm-sensors] [PATCH] lm-sensors: replace references to
Message-Id: <191fb4ca0706081005i5f00a3c9k3e9fc67a5fa7098c@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0706061335g3a45d590na6d4afaada3bec97@mail.gmail.com>
In-Reply-To: <191fb4ca0706061335g3a45d590na6d4afaada3bec97@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I tested it on BMC system running 2.6 and it worked fine. Didn't test
on 2.4 though.

...juerg


On 6/8/07, Jean Delvare <khali@linux-fr.org> wrote:
> On Thu, 7 Jun 2007 11:37:16 -0700, Juerg Haefliger wrote:
> > This patch replaces all references to bmcsensors and i2c-ipmi for
> > kernel 2.6 with
> > ipmisensors and ipmi-si in sensors-detect.
> >
> > Signed-off-by: Juerg Haefliger <juergh at gmail.com>
>
> Looks really good, thanks, I'll apply this.
>
> Keith, could you please test this patch and confirm that it works for
> you?
> http://lists.lm-sensors.org/pipermail/lm-sensors/2007-June/019919.html
>
> --
> Jean Delvare
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
