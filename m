From: Alan Tull <delicious.quinoa@gmail.com>
Date: Sun, 24 Aug 2014 00:48:43 +0000
Subject: Re: [lm-sensors] [PATCH v2 1/2] pmbus: add regulator support
Message-Id: <CANk1AXRag72MOf1c4_BBAXG38UKHxfs+hjsAu67xa-aU8JNqGw@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1408741894-24879-1-git-send-email-atull@opensource.altera.com>
	<1408741894-24879-2-git-send-email-atull@opensource.altera.com>
	<20140822214417.GC24407@sirena.org.uk>
	<alpine.DEB.2.10.1408221927370.2334@shineypoop>
	<53F89E8C.3070200@roeck-us.net>
	<20140823145404.GI24407@sirena.org.uk>
In-Reply-To: <20140823145404.GI24407@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, atull <atull@opensource.altera.com>, jdelvare@suse.de, lm-sensors@lm-sensors.org, lgirdwood@gmail.com, linux-kernel <linux-kernel@vger.kernel.org>, dinguyen@opensource.altera.com, yvanderv@opensource.altera.com

On Sat, Aug 23, 2014 at 9:54 AM, Mark Brown <broonie@kernel.org> wrote:
> On Sat, Aug 23, 2014 at 07:00:44AM -0700, Guenter Roeck wrote:
>> On 08/22/2014 05:31 PM, atull wrote:
>
>> >of_get_regulator_init_data() will only have an error if it cannot alloc
>> >the regulator_init_data struct.  That's why I did -ENOMEM.  If there
>> >is no platform data and nothing about the regulator in the device tree, we
>> >should end up with a zeroed out regulator_init_data.
>
>> Yes, but if OF is not defined it will return NULL as well. Unless I am
>> missing something, that means that the code will now fail if there is
>> no platform init data and OF is not configured.
>
> Indeed, and that's the more interesting case than running out of memory.

Thanks for catching this.  I'll remove the unnecessary check for NULL
and the brackets here.

Alan

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
