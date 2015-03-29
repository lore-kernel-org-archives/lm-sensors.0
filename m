From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 29 Mar 2015 00:55:23 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: Allow to compile dell-smm-hwmon driver without /proc/i8k
Message-Id: <55174D7B.8070401@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1427538255-10860-1-git-send-email-pali.rohar@gmail.com>	 <1427540660.2334.14.camel@x220>	 <CABz95_BkAvPoBAm_tRLH6OhCk_pDfJQ8UuwfhuEYuPNt3P-PGw@mail.gmail.com>	 <201503282300.48749@pali> <55172939.4070100@roeck-us.net> <1427582640.3377.0.camel@tiscali.nl>
In-Reply-To: <1427582640.3377.0.camel@tiscali.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Bolle <pebolle@tiscali.nl>
Cc: =?UTF-8?B?UGFsaSBSb2jDoXI=?= <pali.rohar@gmail.com>, Steven Honeyman <stevenhoneyman@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jean Delvare <jdelvare@suse.de>, Valdis Kletnieks <Valdis.Kletnieks@vt.edu>, Jochen Eisinger <jochen@penguin-breeder.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On 03/28/2015 03:44 PM, Paul Bolle wrote:
> Guenter Roeck schreef op za 28-03-2015 om 15:20 [-0700]:
>> Maybe that is the plan, but it is not what is happening.
>> I8K selects SENSORS_DELL_SMM, so a boolean I8K forces SENSORS_DELL_SMM
>> to be built into the kernel.
>>
>> What you suggest would work if I8K would depend on SENSORS_DELL_SMM,
>> but then the symbols would not be backward-compatible.
>
> I haven't actually looked into this part of the patch, since as far as
> I'm concerned this patch is broken.
>

You mean beyond the "ON" and the above problem ? Can you elaborate ?

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
