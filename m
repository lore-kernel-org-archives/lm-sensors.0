From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Thu, 14 Apr 2011 20:41:16 +0000
Subject: Re: [lm-sensors] [PATCH v5 1/2] Use "request_muxed_region" in it87
Message-Id: <20110414214116.159f702e@lxorguk.ukuu.org.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1302641290-30212-1-git-send-email-natg@google.com>
	<1302641387-30264-1-git-send-email-natg@google.com>
	<20110413070259.GE4070@infomag.iguana.be>
	<20110413102947.3bf1cc88@lxorguk.ukuu.org.uk>
	<BANLkTinR53LO7HWMWoquKY5D+Aprs2OEWw@mail.gmail.com>
In-Reply-To: <BANLkTinR53LO7HWMWoquKY5D+Aprs2OEWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Waychison <mikew@google.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, Nat Gurumoorthy <natg@google.com>, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <guenter.roeck@ericsson.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org

> request_muxed_region() is sorta gross:  it's essentially acting like a
> lock, meant to be used for short periods of time, but it can fail if
> someone else decides it should.

Which is exactly how the hardware situation works. If some other driver
comes along and is rude then the only safe thing to do is to moan a bit.

> Would it make more sense to have drivers that need to use the current
> request_muxed_region() be able to force a region into a mux-only state
> at driver init?  That would lead to much less contorted code to handle
> the off-chance that the request_muxed_region() fails.

Send patches

> I realize the above example re-uses the 'request_muxed_region()' name,
> but at least this would be much more consistent with how
> request_region is used in other drivers.

I guess you'd need some kind of

	r = add_muxed_resource()
	removed_muxed_resource(r)

that inserted/removed them from the resource tree ?

I think the basic resource tree code could be extended this way IFF
someone does the work, if not the current code actually should work just
fine.

Alan

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
