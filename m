From: Luca Tettamanti <kronos.it@gmail.com>
Date: Wed, 06 Jul 2011 08:48:43 +0000
Subject: Re: [lm-sensors] Where are all the sensors?
Message-Id: <CAKPcRGoiJdJ7JcBDRjhzmfLsu-Xhk3RaPpHHJtUMExzDuXmSSQ@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4E0B52A6.1070402@yahoo.co.uk>
In-Reply-To: <4E0B52A6.1070402@yahoo.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jul 6, 2011 at 2:34 AM, Jeff Rickman <jrickman@myamigos.us> wrote:
> Luca, would that modified F71882FG driver (from ~June last year) be
> useful/helpful here? In my case it was a F71862FG chip where ACPI claimed
> the ports but DSDT suggested something to you. I guess it really depends on
> the DSDT code. BTW, I still use that modified driver on that Jetway NC92-330
> board and it still works fine even with Fedora Core 15.

It was an ugly hack :) I modified the driver to access the hwmon chip
using the methods exposed by the firmware instead of letting the
driver touch the chip directly. Unfortunately the hack is very board
specific...

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
