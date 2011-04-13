From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Wed, 13 Apr 2011 09:29:47 +0000
Subject: Re: [lm-sensors] [PATCH v5 1/2] Use "request_muxed_region" in it87
Message-Id: <20110413102947.3bf1cc88@lxorguk.ukuu.org.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1302641290-30212-1-git-send-email-natg@google.com>
	<1302641387-30264-1-git-send-email-natg@google.com>
	<20110413070259.GE4070@infomag.iguana.be>
In-Reply-To: <20110413070259.GE4070@infomag.iguana.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Nat Gurumoorthy <natg@google.com>, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <guenter.roeck@ericsson.com>, Mike Waychison <mikew@google.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org

On Wed, 13 Apr 2011 09:03:00 +0200
Wim Van Sebroeck <wim@iguana.be> wrote:

> Hi Nat,
> 
> > +	(void) request_muxed_region(REG, 2, NAME);
> 
> Why do we need to typecast this? Can't we just use 
> +	request_muxed_region(REG, 2, NAME);

We really ought to use

	if ()

in theory the request can fail if someone has hogged the resource and not
muxed it. I'm not clear what the right thing to do in that case is -
given it should never happen I guess log an error and bail out but that's
a rather bigger change and perhaps should be a follow up patch ?

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
