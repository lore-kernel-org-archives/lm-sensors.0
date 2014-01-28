From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 28 Jan 2014 02:33:44 +0000
Subject: Re: [lm-sensors] lm90 driver no longer working on PCs in 3.13
Message-Id: <52E71708.7010607@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20140126211357.6fa68909@endymion.delvare> <52E573B6.9040903@roeck-us.net> <20140126214936.7736f530@endymion.delvare> <52E58330.90602@roeck-us.net> <52E58656.7000903@roeck-us.net> <20140126235103.GP11727@sirena.org.uk> <52E6951C.60609@wwwdotorg.org> <20140127185031.GA28910@roeck-us.net> <20140127230447.7e8be3a4@endymion.delvare> <20140127234135.GA18059@roeck-us.net> <20140127235815.GA8513@sirena.org.uk>
In-Reply-To: <20140127235815.GA8513@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>
Cc: Jean Delvare <khali@linux-fr.org>, Stephen Warren <swarren@wwwdotorg.org>, Liam Girdwood <lgirdwood@gmail.com>, Wei Ni <wni@nvidia.com>, linux-kernel@vger.kernel.org, LM Sensors <lm-sensors@lm-sensors.org>

On 01/27/2014 03:58 PM, Mark Brown wrote:
> On Mon, Jan 27, 2014 at 03:41:35PM -0800, Guenter Roeck wrote:
>
>> I'll test Mark's two patches on my system and let you know the results.
>> After looking some more into it, those _may_ actually fix the problem at least
>> for systems supporting ACPI. No promise, though, and I am not sure if that
>> would be sufficient (it may still not work on non-ACPI PCs). But then who
>
> They should fix ACPI systems, if they don't we need to fix them further
> - that case should just work, it was an oversight not to have a patch
> like the ACPI one in already.  I'm not sure how many non-ACPI PCs still
> exist, we're definitely talking about things over 10 years old (even
> before PCs became ACPI only they started to have ACPI present which
> should be sufficient).
>
> Jean, I'm doing a writeup but it's probably not going to be done today.
>

I confirmed that your two patches ("regulator: core: Correct default
return value for full constraints" and "ACPI: Flag use of ACPI and ACPI
idioms for power supplies to regulator API") together fix the problem
with the lm90 driver, at least for ACPI based systems.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
