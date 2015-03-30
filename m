From: Paul Bolle <pebolle@tiscali.nl>
Date: Mon, 30 Mar 2015 08:01:41 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: Allow to compile dell-smm-hwmon driver without /proc/i8k
Message-Id: <1427702501.2408.21.camel@x220>
List-Id: <lm-sensors.vger.kernel.org>
References: <1427538255-10860-1-git-send-email-pali.rohar@gmail.com>
		 <1427540660.2334.14.camel@x220>
		 <CABz95_BkAvPoBAm_tRLH6OhCk_pDfJQ8UuwfhuEYuPNt3P-PGw@mail.gmail.com>
		 <201503282300.48749@pali> <55172939.4070100@roeck-us.net>
	 <1427582640.3377.0.camel@tiscali.nl> <55174D7B.8070401@roeck-us.net>
In-Reply-To: <55174D7B.8070401@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Steven Honeyman <stevenhoneyman@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jean Delvare <jdelvare@suse.de>, Valdis Kletnieks <Valdis.Kletnieks@vt.edu>, Jochen Eisinger <jochen@penguin-breeder.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Sat, 2015-03-28 at 17:55 -0700, Guenter Roeck wrote:
> On 03/28/2015 03:44 PM, Paul Bolle wrote:
> > I haven't actually looked into this part of the patch, since as far as
> > I'm concerned this patch is broken.
> 
> You mean beyond the "ON" and the above problem ? Can you elaborate ?

No, I was talking about the ON typo. Because a patch that mainly juggles
Kconfig symbols but adds a Kconfig syntax error while doing that is a
broken patch.


Paul Bolle



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
