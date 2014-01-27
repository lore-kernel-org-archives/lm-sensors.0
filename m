From: Stephen Warren <swarren@wwwdotorg.org>
Date: Mon, 27 Jan 2014 17:19:24 +0000
Subject: Re: [lm-sensors] lm90 driver no longer working on PCs in 3.13
Message-Id: <52E6951C.60609@wwwdotorg.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <52E561D0.4040308@roeck-us.net> <20140126211357.6fa68909@endymion.delvare> <52E573B6.9040903@roeck-us.net> <20140126214936.7736f530@endymion.delvare> <52E58330.90602@roeck-us.net> <52E58656.7000903@roeck-us.net> <20140126235103.GP11727@sirena.org.uk>
In-Reply-To: <20140126235103.GP11727@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>, Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <khali@linux-fr.org>, Liam Girdwood <lgirdwood@gmail.com>, Wei Ni <wni@nvidia.com>, linux-kernel@vger.kernel.org, LM Sensors <lm-sensors@lm-sensors.org>

On 01/26/2014 04:51 PM, Mark Brown wrote:
> On Sun, Jan 26, 2014 at 02:04:06PM -0800, Guenter Roeck wrote:
> 
>> I think I have a better idea: Surround the regulator code, or at least
>> its error handling, in the lm90 driver with
> 
>> 	if (IS_ENABLED(CONFIG_OF)) {
>> 	}
> 
>> Would that be ok ? If yes I'll submit a patch. I'll do the same in
>> another driver I am working on.
> 
> That's not going to have the desired effect in cases where DT is built
> into the kernel but not in use on the current system (which is a
> configuration that gets used) ...

The solution to that particular aspect of the problem is the following:

if (of_have_populated_dt()) {
	...

which is a run-time rather than compile-time test.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
