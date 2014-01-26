From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 26 Jan 2014 21:47:09 +0000
Subject: Re: [lm-sensors] lm90 driver no longer working on PCs in 3.13
Message-Id: <52E5825D.9090104@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <52E561D0.4040308@roeck-us.net> <20140126211357.6fa68909@endymion.delvare> <52E573B6.9040903@roeck-us.net> <20140126205216.GJ11727@sirena.org.uk>
In-Reply-To: <20140126205216.GJ11727@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>
Cc: Jean Delvare <khali@linux-fr.org>, LM Sensors <lm-sensors@lm-sensors.org>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Wei Ni <wni@nvidia.com>

On 01/26/2014 12:52 PM, Mark Brown wrote:
> On Sun, Jan 26, 2014 at 12:44:38PM -0800, Guenter Roeck wrote:
>> On 01/26/2014 12:13 PM, Jean Delvare wrote:
>
>>> Me, I really don't know. I seem to remember I tested Wei's patch set on
>>> an emulated ADM1032 chip and it was working fine. So maybe it depends
>>> on the kernel configuration, or something changed on the regulator side
>>> meanwhile.
>
>> The regulator code changed with 3.13; the dummy regulator no longer exists,
>> and the functionality it provided is supposed to be handled automatically.
>> But that only really works on devicetree based systems and otherwise returns
>> -EPROBE_DEFER as mentioned above.
>
> CONFIG_REGULATOR_DUMMY should never have been used in production, it was
> a debug tool to help bringup but it broke things as often as it fixed
> them particularly with init ordering which is why it generated a warning
> when it was used.
>
> The dummy driver is still there, if you're doing bringup you can hack it
> in still or if you genuniely used it then specify that full constraints
> are provided like the changelog says (and as I've previously said).
>
>> Another possible fix would be to have the regulator core return -ENODEV
>> instead of -EPROBE_DEFER on non-dt systems. No idea if this would be acceptable
>> or even feasible.
>
> No, this would introduce breakage due to init ordering.
>

You have a solution for that in dt configurations. I don't think you have one for
non-dt systems - you simply assume that all regulators are there. For dt, you even
have a constraint to tell the kernel if regulator configurations are fully specified,
and you automatically return success if not and if a regulator does not exist.
So you know that there is a problem. For non-DT configurations you simply assume and
expect that regulators are all declared. I don't think that is a feasible approach
for non-DT systems.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
