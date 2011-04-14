From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Thu, 14 Apr 2011 09:25:52 +0000
Subject: Re: [lm-sensors] [PATCH v5 1/2] Use "request_muxed_region" in it87
Message-Id: <20110414102552.097f10b0@lxorguk.ukuu.org.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1302641290-30212-1-git-send-email-natg@google.com>
	<1302641387-30264-1-git-send-email-natg@google.com>
	<4DA547CD.60406@redhat.com>
	<BANLkTikfuvvujTi6i2MUGOHgNLZCqcouJQ@mail.gmail.com>
	<20110413103409.47638b72@endymion.delvare>
	<BANLkTimhUd9+QmLh-fSjwDO5c_vRH+kktA@mail.gmail.com>
In-Reply-To: <BANLkTimhUd9+QmLh-fSjwDO5c_vRH+kktA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Natarajan Gurumoorthy <natg@google.com>
Cc: Jean Delvare <khali@linux-fr.org>, Hans de Goede <hdegoede@redhat.com>, Guenter Roeck <guenter.roeck@ericsson.com>, Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Mike Waychison <mikew@google.com>

> Have I missed any other drivers that also need to be cleaned. Even if
> I got my boss to sign up to clean this I can only test the it8712f
> drivers and thats it.

I would just fix the it87 drivers. The rest is the problem of the
authors/users of the other drivers. Really only they can test it and
you've given them a worked reference !

Alan

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
