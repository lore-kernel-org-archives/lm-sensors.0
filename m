From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 03 Jul 2013 06:23:52 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Add detection of NCT6791D
Message-Id: <20130703082352.1c9ecefe@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110217195640.GA20934@ericsson.com>
In-Reply-To: <20110217195640.GA20934@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 2 Jul 2013 19:52:30 -0700, Guenter Roeck wrote:
> On Tue, Jul 02, 2013 at 09:10:52AM -0700, David Bartley wrote:
> > The value of CR[20]/CR[21] on my board is 0xc8/0x03, and the physical chip
> > itself has "NCT6791D" printed on it.
> 
> Hi Jean and David,
> 
> Nuvoton confirms that 0xc803 is the correct chip ID.

OK, I suppose they will fix it in the next version of the datasheet.
Meanwhile you can commit your patch.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
