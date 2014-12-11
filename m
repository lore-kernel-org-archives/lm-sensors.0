From: Jean Delvare <jdelvare@suse.de>
Date: Thu, 11 Dec 2014 12:54:50 +0000
Subject: Re: [lm-sensors] [PATCH v3] sensors-detect: Add code to detect TMP400 and TMP435
Message-Id: <20141211135450.2218bd14@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1418096560-28548-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1418096560-28548-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Tue, 09 Dec 2014 06:46:46 -0800, Guenter Roeck wrote:
> On 12/09/2014 02:45 AM, Jean Delvare wrote:
> > On Mon,  8 Dec 2014 19:42:40 -0800, Guenter Roeck wrote:
> >> +	if ($chip = 8) {			  # TMP451
> >> +		my $filter = i2c_smbus_read_byte_data($file, 0x24);
> >> +
> >> +		return if $cid != 0x00;
> >>   		return if $rate > 0x09;
> >> -		return if $mid != 0x55;		# Texas Instruments
> >> -		return 4 if ($cid = 0x00);	# TMP451
> >> +		return if $filter & 0xfc;
> >
> > If you want to improve reliability further, you could check for 4
> > unused bits in limit registers 0x12 and 0x15.
>
> Not sure if that would improve much. I would rather test for some
> non-zeros. I am going to get one of those chips and check if
> the consecutive alert register (0x22) has bit 0 set or not
> (the datasheet contradicts itself, and the bit is set in the
> register dump I have available).

Of course, testing for a non-zero bit is more valuable than testing for
a zero bit. But non-zero bits are rare.

> We could also check if (some of) the limit registers are non-zero.
> Would that make sense ?

Yes it would. For all chips without a reasonable chip ID register
value, every trick is welcome. You can also check that the low limit is
strictly lower than the high temperature limit, for example.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
