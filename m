From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 28 Apr 2012 04:30:51 +0000
Subject: Re: [lm-sensors] sensor 3.3.1 and previous do not properly detect/show CPUTIN temperature - maximus
Message-Id: <20120428043051.GA22014@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAGqf2i+bMvvWyELKn5ApTL+XUQ_s7x-eMCSV4DdNGhpfuHy6nA@mail.gmail.com>
In-Reply-To: <CAGqf2i+bMvvWyELKn5ApTL+XUQ_s7x-eMCSV4DdNGhpfuHy6nA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Apr 20, 2012 at 11:47:47AM +0100, Martin Suchanek wrote:
> Hi,
> 
> Add info:
> I have found software called open hardware monitor. I have been testing it
> in windows for couple of days and it works properly with Nuvoton NST6776F
> chip. I have been comparing results with AI Suite software coming from ASUS
> and results are corresponding and measuring is with big precise. So , you
> can have a look to source code and compare with your driver. This software
> should work on linux as well but I did not try it yet but I will.
> 
I finally had time to look into the open hardware monitor code.

The answer is quite simple - the board get the CPU temperature using PECI,
which the w83627ehf/nct67765 driver reports is as "PECI Agent 0".
Open Hardware Monitor maps that temperature into the CPU temperature display
and ignores CPUTIN. Which makes sense, since the purpose of PECI is to report
the CPU temperature.

So all you need to do is to ignore the value of CPUTIN and use the "PECI Agent 0"
temperature instead.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
