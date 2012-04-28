From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 28 Apr 2012 10:22:17 +0000
Subject: Re: [lm-sensors] sensor 3.3.1 and previous do not properly detect/show CPUTIN temperature - maximus
Message-Id: <20120428122217.03c213a1@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAGqf2i+bMvvWyELKn5ApTL+XUQ_s7x-eMCSV4DdNGhpfuHy6nA@mail.gmail.com>
In-Reply-To: <CAGqf2i+bMvvWyELKn5ApTL+XUQ_s7x-eMCSV4DdNGhpfuHy6nA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 28 Apr 2012 11:08:23 +0100, Martin Suchanek wrote:
> On Sat, Apr 28, 2012 at 5:30 AM, Guenter Roeck
> <guenter.roeck@ericsson.com>wrote:
> > The answer is quite simple - the board get the CPU temperature using PECI,
> > which the w83627ehf/nct67765 driver reports is as "PECI Agent 0".
> > Open Hardware Monitor maps that temperature into the CPU temperature
> > display
> > and ignores CPUTIN. Which makes sense, since the purpose of PECI is to
> > report
> > the CPU temperature.
> >
> > So all you need to do is to ignore the value of CPUTIN and use the "PECI
> > Agent 0"
> > temperature instead.
>
> I am now confused ?
> I do not know technical details but according to ASUS technical support
> CPUTIN is temperature of motherboard (not cpu socket , not cpu yourself )
> what exactly this temperature means ?

Labels are suggestions from the chip maker, unfortunately board vendors
are free to not follow these suggestions and wire the inputs
differently. Confusion ensues...

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
