From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 12 Nov 2013 07:04:37 +0000
Subject: Re: [lm-sensors] Nuvoton NCT6791D support
Message-Id: <20131112080437.1fb213cc@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CADkjvt_edGO-+NKbsUbNwN=DXod10WTUYmfjRTrQfYq_2no2uw@mail.gmail.com>
In-Reply-To: <CADkjvt_edGO-+NKbsUbNwN=DXod10WTUYmfjRTrQfYq_2no2uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 11 Nov 2013 18:37:37 -0800, Guenter Roeck wrote:
> On 11/11/2013 04:57 PM, p. stephen w wrote:
> > Please see attached.
> > _____________________________________________________________________________________________
> > I noticed the fancontrol file is using hwmon2, instead of hwmon3, so I ran
> > that command using hwmon2 and it has a lot more output.  I've attached it
> > in case  its of interest.
> > Can I set INTERVAL to less than a minute; 0.25, or 0.5?
>
> No idea.

Interval is expressed in seconds, not minutes. The default is 10
seconds, which some may find too much if the low fan speeds are very
low and temperatures can raise quickly. Lowering it is OK, but there's
no point in going below 1 second because most hwmon drivers won't
refresh their values faster than every second anyway.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
