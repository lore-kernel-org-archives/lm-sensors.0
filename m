From: "P.B. V" <oh.pooky@gmail.com>
Date: Sat, 28 Apr 2012 06:43:53 +0000
Subject: Re: [lm-sensors] sensor 3.3.1 and previous do not properly detect/show CPUTIN temperature - maximus
Message-Id: <CAMWokRj4n_Lns4pfdJbGC5RYTU2S7GM00nYmqGdwQRNFv4asYw@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAGqf2i+bMvvWyELKn5ApTL+XUQ_s7x-eMCSV4DdNGhpfuHy6nA@mail.gmail.com>
In-Reply-To: <CAGqf2i+bMvvWyELKn5ApTL+XUQ_s7x-eMCSV4DdNGhpfuHy6nA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> On Fri, Apr 20, 2012 at 11:47:47AM +0100, Martin Suchanek wrote:
> > Hi,
> >
> > Add info:
> > I have found software called open hardware monitor. I have been testing it
> > in windows for couple of days and it works properly with Nuvoton NST6776F
> > chip. I have been comparing results with AI Suite software coming from ASUS
> > and results are corresponding and measuring is with big precise. So , you
> > can have a look to source code and compare with your driver. This software
> > should work on linux as well but I did not try it yet but I will.
> >
> I finally had time to look into the open hardware monitor code.
>
> The answer is quite simple - the board get the CPU temperature using PECI,
> which the w83627ehf/nct67765 driver reports is as "PECI Agent 0".
> Open Hardware Monitor maps that temperature into the CPU temperature display
> and ignores CPUTIN. Which makes sense, since the purpose of PECI is to report
> the CPU temperature.
>
> So all you need to do is to ignore the value of CPUTIN and use the "PECI Agent 0"
> temperature instead.
>
> Guenter

This is a bad idea! I was about to report this.

w83627ehf and nct6775 (Apr 27, 2012) driver modules both show a
seemingly incorrect value for PECI. I am running a Maximus IV Extreme
Revision 1.0 motherboard (NCT6776F), with an i5-2550K CPU, on kernel
3.3.

The coretemp module and my BIOS reports my idle temperatures at around
33-35C, while PECI in Linux reports in at 23-25. It looks to be 10
degrees off. Under load it scales with coretemp, always staying 10
degrees under the average coretemp values.

Unless I'm not understanding something correctly, PECI should not be
used and doing so may lead to hardware damage.

coretemp:
 Physical id 0:  +36.0 C  (high = +80.0 C, crit = +101.0 C)
 Core 0:         +36.0 C  (high = +80.0 C, crit = +101.0 C)
 Core 1:         +32.0 C  (high = +80.0 C, crit = +101.0 C)
 Core 2:         +34.0 C  (high = +80.0 C, crit = +101.0 C)
 Core 3:         +30.0 C  (high = +80.0 C, crit = +101.0 C)

w83627ehf: (nct6775 values are identical)
 PECI Agent 0:  +24.0 C


Also, I attempted to change the sensor type for CPUTIN using the
nct6775 module with no effect. All that changed was -60 went to -62.5
when changed to 'thermistor'.

- P.K.Y.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
