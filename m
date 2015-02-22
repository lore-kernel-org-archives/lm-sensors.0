From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 22 Feb 2015 23:31:11 +0000
Subject: Re: [lm-sensors] i8k: move driver from char to hwmon
Message-Id: <54EA66BF.6090000@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <201502221250.49466@pali>	<54EA12DC.1000403@roeck-us.net>	<201502221844.54371@pali>	<54EA1BC4.9080606@roeck-us.net> <20150222230741.051f12b9@endymion.delvare>
In-Reply-To: <20150222230741.051f12b9@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <jdelvare@suse.de>
Cc: =?windows-1252?Q?Pali_Roh=E1r?= <pali.rohar@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Steven Honeyman <stevenhoneyman@gmail.com>, Valdis.Kletnieks@vt.edu, Jochen Eisinger <jochen@penguin-breeder.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On 02/22/2015 02:07 PM, Jean Delvare wrote:
> On Sun, 22 Feb 2015 10:11:16 -0800, Guenter Roeck wrote:
>> I would still leave the driver name alone, though; the problem
>> is that "modprobe i8k" is mentioned in pretty much all references
>> to the driver.
>
> This might be solved with a module alias? You can pass any arbitrary
> string to MODULE_ALIAS(). This would still break insmod but pretty much
> everyone is calling modprobe to load kernel modules anyway.
>

You are right, that might work.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
