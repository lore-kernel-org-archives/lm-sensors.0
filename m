From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 13 Nov 2013 03:40:57 +0000
Subject: Re: [lm-sensors] Nuvoton NCT6791D support
Message-Id: <20131113034057.GA30601@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CADkjvt_edGO-+NKbsUbNwN=DXod10WTUYmfjRTrQfYq_2no2uw@mail.gmail.com>
In-Reply-To: <CADkjvt_edGO-+NKbsUbNwN=DXod10WTUYmfjRTrQfYq_2no2uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Nov 11, 2013 at 11:27:03PM -0800, p. stephen w wrote:
> Please see attached.
> ___________________________________________________-
> The output is attached and matches the order...
> 
> isadump -k 0x55,0x55 0x295 0x296
> isadump -k 0x55,0x55 0x295 0x296 1
> ....
> isadump -k 0x55,0x55 0x295 0x296 8
> 
> 
> 
> 
> On Mon, Nov 11, 2013 at 9:22 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> 
> > On Mon, Nov 11, 2013 at 08:05:46PM -0800, Guenter Roeck wrote:
> >
> > [ ... ]
> >
> > > No, it won't. I'll dig out other commands for you to run to give me some
> > chip
> > > register output.
> > >
> > Following up on this. It would be great if you can do the following.
> >
> > When executing the the sensors command, you see something like
> >
> > nct6791-isa-0a00
> >
> > for the NCT chip. Take the hex number at the end; based on it, run the
> > following sequence of commands:
> >
> > sudo isadump -k 0x55,0x55 0xa05 0xa06
> > sudo isadump -k 0x55,0x55 0xa05 0xa06 1
> > sudo isadump -k 0x55,0x55 0xa05 0xa06 2
> > sudo isadump -k 0x55,0x55 0xa05 0xa06 3
> > sudo isadump -k 0x55,0x55 0xa05 0xa06 4
> > sudo isadump -k 0x55,0x55 0xa05 0xa06 5
> > sudo isadump -k 0x55,0x55 0xa05 0xa06 6
> > sudo isadump -k 0x55,0x55 0xa05 0xa06 7
> > sudo isadump -k 0x55,0x55 0xa05 0xa06 8
> >
> > In other words, add 5 and 6 to the hex number and pass it as parameter to
> > the
> > isadump commands.
> >
> > This should create a dump of chip registers, which would hopefully help me
> > track
> > down the problem with pwmX_temp_sel.
> >

Hi,

I think I fixed the problem. It would be great if you can update the repository
from github and try again.

Please provide output from the sensors command as well as from
"grep . /sys/class/hwmon/hwmon2/device/*".

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
