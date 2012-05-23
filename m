From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 23 May 2012 16:39:19 +0000
Subject: Re: [lm-sensors] Nuvoton NCT6776D - AsRock
Message-Id: <1337791159.478.19.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAKJpqGFq1teBVrgDw3WxCKO-mk6eTZ2jSCOdzOfF6MS-oz4hOQ@mail.gmail.com>
In-Reply-To: <CAKJpqGFq1teBVrgDw3WxCKO-mk6eTZ2jSCOdzOfF6MS-oz4hOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 2012-05-23 at 12:25 -0400, clement clem wrote:
> Hello to all,
> 
> Have a new card AsRock B75 Pro 3 M yesterday.
> 
> This card uses a new chip Nuvoton NCT6776D.
> 
> Can we have full support for Lm-Sensors ?
> 
> For now only the temperature of my i3 2100 are displayed.
> 
Hi,

that really depends on your kernel version. Try "modprobe w83627ehf".

There is an experimental driver at https://github.com/groeck/nct6775
which you can try as well. It has somewhat improved fan control support.

There is one caveat, though - AsRock uses a GPIO based multiplexer to
map multiple fans into a single fan speed input of the NCT6776F chip. As
a result, you won't be able to see (or control) the speed of all fans.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
