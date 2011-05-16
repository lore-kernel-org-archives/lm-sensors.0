From: "Alistair John Strachan" <alistair@devzero.co.uk>
Date: Mon, 16 May 2011 21:39:53 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (abituguru) Depend on DMI
Message-Id: <68479a1e683cc5914e1f64f478bbeb35.squirrel@mail.devzero.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110516110612.49ed4204@endymion.delvare>
In-Reply-To: <20110516110612.49ed4204@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, May 16, 2011 3:47 pm, Guenter Roeck wrote:
> On Mon, May 16, 2011 at 05:06:12AM -0400, Jean Delvare wrote:
>> The abituguru drivers are only built on X86, where DMI support is now
>> enabled by default. So let these drivers depend on DMI, for the
>> following gains:
>> * Robustness and safety. Detection of these devices is weak and uses
>>   non-standard methods, it should really be limited to Abit boards
>>   unless the user explicitly asks otherwise.
>> * Code simplicity. The code is easier to read without ifdefs.
>> * Better build testing coverage. Now there's only one way to build the
>>   drivers, so no risk of build failure on exotic systems.
>>
>> Signed-off-by: Jean Delvare <khali@linux-fr.org>
>> Cc: Alistair John Strachan <alistair@devzero.co.uk>
>> Cc: Hans de Goede <hdegoede@redhat.com>
>
> Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>

It's nice to see this actually happen.

Acked-by: Alistair John Strachan <alistair@devzero.co.uk>

-- 
Cheers,
Alistair.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
