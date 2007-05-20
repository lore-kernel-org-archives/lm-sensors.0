From: "Juerg Haefliger" <juergh@gmail.com>
Date: Sun, 20 May 2007 18:12:22 +0000
Subject: Re: [lm-sensors] [PATCH 1/2 RESEND] hwmon: new driver for SMSC
Message-Id: <191fb4ca0705201112g769b0117sb723043fffcd02ee@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0703220946p1f1e750i4b285111bfc23318@mail.gmail.com>
In-Reply-To: <191fb4ca0703220946p1f1e750i4b285111bfc23318@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Yippie, somebody bring out the champagne :-)
Thanks a lot for your patience, it's greatly appreciated!

...juerg


On 5/20/07, Jean Delvare <khali@linux-fr.org> wrote:
> Hi Juerg,
>
> On Sat, 19 May 2007 14:14:09 -0700, Juerg Haefliger wrote:
> > Fixed remaining issues from Jean's latest review.
> >
> > ---
> > This patch adds support for the hardware monitoring and fan control
> > capabilities of the SMSC DME1737 and Asus A8000 Super-I/O chips.
> >
> > The hardware monitoring logic of this chip is similar to the LM85 but
> > has some additional features that this driver supports. Even though
> > it's a Super-I/O chip, the hardware monitoring logic can only be
> > accessed via SMBus.
> >
> > Signed-off-by: Juerg Haefliger <juergh at gmail.com>
>
> It took quite some time and efforts but we're finally there: patch
> applied, thanks :)
>
> --
> Jean Delvare
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
