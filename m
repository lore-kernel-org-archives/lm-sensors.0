From: "Juerg Haefliger" <juergh@gmail.com>
Date: Fri, 20 Jul 2007 20:54:44 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: fix temp fault in dme1737 driver
Message-Id: <191fb4ca0707201354p212951fct3a4aade1e16ac9b4@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0707161835x101f9a7dx51da4c275b0133bb@mail.gmail.com>
In-Reply-To: <191fb4ca0707161835x101f9a7dx51da4c275b0133bb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,


> Hi Juerg,
>
> On Mon, 16 Jul 2007 18:35:36 -0700, Juerg Haefliger wrote:
> > Fix temp?_fault attribute. The temp was incorrectly compared against
> > 0x0800 rather than 0x8000.
> >
> > Signed-off-by: Juerg Haefliger <juergh at gmail.com>
>
> Have you verified that this works as intended in practice? The
> datasheet says that "a diode fault condition forces the diode reading
> register to a value of 80h", which leaves some doubt on whether the 4
> LSBs, which live in a different register, are set to 0 as well or not.
> So I wonder if:
>
>         res = ((data->temp[ix] & 0xff00) = (s16)0x8000);
>
> wouldn't be a better test.

Yes I tested it but you have a valid point. I like your solution
better, it's safer.

...juerg




> --
> Jean Delvare
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
