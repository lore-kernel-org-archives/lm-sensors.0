From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Date: Thu, 17 May 2012 21:40:26 +0000
Subject: Re: [lm-sensors] [PATCH v6 3/3] gpio: TS-5500 GPIO support
Message-Id: <1337290826.7033.10.camel@trivette.site>
List-Id: <lm-sensors.vger.kernel.org>
References: <1334276935-11258-1-git-send-email-vivien.didelot@savoirfairelinux.com>
	 <1334276935-11258-4-git-send-email-vivien.didelot@savoirfairelinux.com>
	 <20120517210633.400633E0621@localhost>
In-Reply-To: <20120517210633.400633E0621@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Grant Likely <grant.likely@secretlab.ca>
Cc: x86@kernel.org, Jerome Oufella <jerome.oufella@savoirfairelinux.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Guenter Roeck <guenter.roeck@ericsson.com>, Jean Delvare <khali@linux-fr.org>, Linus Walleij <linus.walleij@stericsson.com>

On Thu, 2012-05-17 at 15:06 -0600, Grant Likely wrote:
> >  arch/x86/include/asm/ts5500.h |   62 ++++++++
> 
> Why the separate header file?  What will use these defines?  I
> normally expect driver-specific defines to be in the driver .c file
> directly; particularly for things like gpio drivers which should be a
> generic interface that doesn't need to export symbols. 

Should an intermediate driver directly use values for GPIOs instead of
these symbols? For example, how should a temperature sensor plugged on
this platform refer to inputs and outputs?

Thanks,
	Vivien


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
