From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Tue, 12 Apr 2011 11:41:55 +0000
Subject: Re: [lm-sensors] [PATCH v4 1/2] Use "request_muxed_region" in it87
Message-Id: <20110412124155.36787390@lxorguk.ukuu.org.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1302565858-23849-1-git-send-email-natg@google.com>
	<1302565974-23906-1-git-send-email-natg@google.com>
In-Reply-To: <1302565974-23906-1-git-send-email-natg@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nat Gurumoorthy <natg@google.com>
Cc: Jean Delvare <khali@linux-fr.org>, Guenter Roeck <guenter.roeck@ericsson.com>, Wim Van Sebroeck <wim@iguana.be>, Mike Waychison <mikew@google.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org

> +	while (!request_muxed_region(REG, 2, NAME))
> +		continue;
> +

This shouldn't need the loop ? - is it only working with the loop
present ?


Otherwise this looks good - I'd just like to understand if the loop was
needed (indicating a bug has crept into the muxed alloc code somewhere
perhaps) or not

Alan

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
