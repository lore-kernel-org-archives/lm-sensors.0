From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 29 Jul 2013 10:22:42 +0000
Subject: Re: [lm-sensors] HM65 chipset fan control
Message-Id: <51F64272.8010503@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CABeCqAFg+BMZrB=eJFMwSFJEkeLOhmUMFgTi2r0cBYOjaNhoiA@mail.gmail.com>
In-Reply-To: <CABeCqAFg+BMZrB=eJFMwSFJEkeLOhmUMFgTi2r0cBYOjaNhoiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On 07/29/2013 02:16 AM, Hakan T=DCR=DCT wrote:
> Hello,
> I have a laptop with i5 cpu and hm65 chipset.There is a problem with fan
> control.I asked to manufacture  of my laptop what chipset is used in
> this pc for control the fan ? They said "Your southbridge controlling
> it(HM65 chipset)."lm-sensors auto detect does not detect any fan or
> voltage.Is there any path or something ?
>
Most likely it is through the Intel Management Engine (MEI).
Unfortunately there is no Linux driver available yet to support MEI fan
control.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
