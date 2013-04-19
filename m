From: arno@natisbad.org (Arnaud Ebalard)
Date: Fri, 19 Apr 2013 05:34:48 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] Add support for GMT G72/G763 PWM fan controller
Message-Id: <877gjz9j7r.fsf@natisbad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <cover.1366322287.git.arno@natisbad.org>
	<4f4a821bbc61e2da28fd70553fd717ada255097d.1366322287.git.arno@natisbad.org>
	<20130419043555.GA14124@roeck-us.net>
In-Reply-To: <20130419043555.GA14124@roeck-us.net> (Guenter Roeck's message of
	"Thu, 18 Apr 2013 21:35:55 -0700")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <khali@linux-fr.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, lm-sensors@lm-sensors.org, devicetree-discuss@lists.ozlabs.org, Rob Landley <rob@landley.net>, linux-doc@vger.kernel.org, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Simon Guinot <simon.guinot@sequanux.org>, Olivier Mouchet <olivier.mouchet@gmail.com>

Hi,

Guenter Roeck <linux@roeck-us.net> writes:

> On Fri, Apr 19, 2013 at 12:28:21AM +0200, Arnaud Ebalard wrote:
>> 
>> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
>> Tested-by: Arnaud Ebalard <arno@natisbad.org>
>> ---
>>  drivers/hwmon/Kconfig  |   10 +
>>  drivers/hwmon/Makefile |    1 +
>>  drivers/hwmon/g762.c   | 1159 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 1170 insertions(+)
>>  create mode 100644 drivers/hwmon/g762.c
>> 
> checkpatch says:
>
> total: 1 errors, 15 warnings, 0 checks, 1182 lines checked
>
> Please fix those. Also, please make sure there are spaces around operators.
>
> Additional comments inline. This is not a complete review; I gave up after
> a while. Please fix the problems and resubmit.

Thanks for taking the time and sorry for some lame errors (missing
spaces around operators, spaces issues, unchecked overflow). Regarding
the ssize_t, I will replace it by an int where appropriate; basically
all the functions not returning a size value or an error (i.e. those not
using sprintf).

Will try and resubmit a v1 with all thoses fixed and additional review
done after the week end

Cheers,

a+

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
