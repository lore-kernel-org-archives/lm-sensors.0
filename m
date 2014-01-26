From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 26 Jan 2014 22:02:16 +0000
Subject: Re: [lm-sensors] lm90 driver no longer working on PCs in 3.13
Message-Id: <52E585E8.4000100@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <52E561D0.4040308@roeck-us.net> <20140126211357.6fa68909@endymion.delvare> <52E573B6.9040903@roeck-us.net> <20140126214936.7736f530@endymion.delvare> <20140126212256.GK11727@sirena.org.uk> <52E580CE.8080100@roeck-us.net> <20140126215354.GL11727@sirena.org.uk>
In-Reply-To: <20140126215354.GL11727@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>
Cc: Jean Delvare <khali@linux-fr.org>, LM Sensors <lm-sensors@lm-sensors.org>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Wei Ni <wni@nvidia.com>

On 01/26/2014 01:53 PM, Mark Brown wrote:
> On Sun, Jan 26, 2014 at 01:40:30PM -0800, Guenter Roeck wrote:
>> On 01/26/2014 01:22 PM, Mark Brown wrote:
>
>>> What is this platform and why does it have the regulator API enabled in
>>> the first place?
>
>> It is a PC running Ubuntu. you'd have to ask the distro maintainers why they
>> turn on regulators.
>
>> config-3.8.0-26-generic:CONFIG_REGULATOR=y
>> config-3.8.0-35-generic:CONFIG_REGULATOR=y
>> config-3.11.0-13-generic:CONFIG_REGULATOR=y
>
> Oh, magic.  Can you please file a bug with or otherwise talk to them
> asking them to turn that off (or contribute code to make it work)?  Feel
> free to add me as a CC when you do so.
>

That means they would have to stop supporting anything that _does_ need regulators,
which doesn't make much sense to me.

I think the bug is on your side, not theirs.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
