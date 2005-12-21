From: mgreer@mvista.com (Mark A. Greer)
Date: Wed, 21 Dec 2005 21:25:44 +0000
Subject: [lm-sensors] [RFC] i2c: Combined ST m41txx i2c rtc chip driver
Message-Id: <20051221212544.GA4958@mag.az.mvista.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4378960F.8030800@varma-el.com> <20051115215226.4e6494e0.khali@linux-fr.org> <20051116025714.GK5546@mag.az.mvista.com> <20051219210325.GA21696@mag.az.mvista.com> <43A7D76E.5050008@varma-el.com>
In-Reply-To: <43A7D76E.5050008@varma-el.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrey Volkov <avolkov@varma-el.com>
Cc: "Mark A. Greer" <mgreer@mvista.com>, Jean Delvare <khali@linux-fr.org>, adi@hexapodia.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

Hi Andrey,

On Tue, Dec 20, 2005 at 01:05:34PM +0300, Andrey Volkov wrote:
> Hello Mark
> 
> Big Thanks, I check it on my board today-tomorrow.
> But check some comments below.
> 
> Mark A. Greer wrote:
> > On Tue, Nov 15, 2005 at 07:57:14PM -0700, Mark A. Greer wrote:
<snip>
> > +	down(&m41txx_mutex);
> > +	do {
> > +		retries = M41TXX_MAX_RETRIES;
> > +
> > +		do {
> > +			if (((sec = i2c_smbus_read_byte_data(save_client,
> > +						m41txx_chip->sec)) >= 0)
> > +				&& ((min = i2c_smbus_read_byte_data(save_client,
> > +						m41txx_chip->min)) >= 0)
> > +				&& ((hour= i2c_smbus_read_byte_data(save_client,
> > +						m41txx_chip->hour)) >= 0)
> > +				&& ((day = i2c_smbus_read_byte_data(save_client,
> > +						m41txx_chip->day)) >= 0)
> > +				&& ((mon = i2c_smbus_read_byte_data(save_client,
> > +						m41txx_chip->mon)) >= 0)
> > +				&& ((year= i2c_smbus_read_byte_data(save_client,
> > +						m41txx_chip->year)) >= 0))
> > +				break;
> > +		} while (--retries > 0);
> > +
> > +		if ((retries = 0) || ((sec = sec1) && (min = min1)
> > +				&& (hour = hour1) && (day = day1)
> > +				&& (mon = mon1) && (year = year1)))
> > +			break;
> 
> I think this code is overburdened (I forgot to point on it last time,
> sorry) and may be wrong for m41t8x, since when you send i2c stop
> condition (in read_byte_data), you release time registers of m41t8x,
> and as a consequence, in the worst case, you must compare/read it an
> undetermined number of times, but not 3 times (however, for m41t00 this
> code is correct).

The 3 tries isn't to make sure that the registers didn't change, its to
make sure we actually successfully read all of the registers.  There are
10 tries to make sure the registers didn't change.  I doubt it will ever
take more than 2 or 3 so I don't see a problem with a limit of 10.

I *think* I understand you point, though.  You would prefer I not use
the smbus calls, correct?  If so, I disagree.  I think its better to use
the smbus calls b/c they're the most generic (read: will work with the
most i2c host ctlr drivers).  Perhaps Jean or someone else can make an
executive decision on this.

> I think i2c_master_recv here and i2c_master_send above in m41txx_set
> will be more appropriate, since for m41t00 it will have no meaning when
> you send STOP (250ms stall), but for m41t8x you could drop this
> while-loop completely.

I understand but its an issue of being more generic.

<snip>

> Also, please, change _obsoleted_ BCD_TO_BIN to BCD2BIN
> (see include/linux/bcd.h)

I figured one of those was deprecated but didn't know which one.  I'll
change them.

Mark

