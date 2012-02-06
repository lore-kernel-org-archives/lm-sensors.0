From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 06 Feb 2012 20:46:04 +0000
Subject: Re: [lm-sensors] [PATCH v5 4/5] hwmon: add MAX197 support
Message-Id: <1328561164.2261.258.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1328130344-18836-1-git-send-email-vivien.didelot@savoirfairelinux.com>
	 <1328130344-18836-5-git-send-email-vivien.didelot@savoirfairelinux.com>
	 <1328132138.2261.116.camel@groeck-laptop> <20120206151507.73a23eb8@v0nbox>
In-Reply-To: <20120206151507.73a23eb8@v0nbox>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Cc: "x86@kernel.org" <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, Jean Delvare <khali@linux-fr.org>

Hi Vivien,

On Mon, 2012-02-06 at 15:15 -0500, Vivien Didelot wrote:
[ ... ]
> 
> BTW, about the TS-5500 ADC part, is a platform ts5500_adc.c file the
> better solution, or should the device be declared in the ts5500.c
> platform code?
> 
I would suggest to declare it in the ts5500.c platform code. That seems
to be the common approach as far as I can see.

platform_add_devices() works pretty well for this. It saves you from
having to call platform_device_register() for each device separately.
Obviously that only works if all devices are declared in a single file.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
