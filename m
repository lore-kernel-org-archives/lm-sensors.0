From: Rudolf Marek <r.marek@assembler.cz>
Date: Thu, 23 Apr 2009 06:57:22 +0000
Subject: Re: [lm-sensors] w83793 related question
Message-Id: <49F01152.30108@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <49E45712.6020906@aei.mpg.de>
In-Reply-To: <49E45712.6020906@aei.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> What makes you think there is a relation between SMM and ACPI?

There should be. See ACPI specs and Global lock chapter. It should be a hw lock 
between ACPI and SMM code touching the hw. Maybe we are lucky and something like 
this is really implemented.

But since the 1) is true I would suspect that we just see some other transactions.

>> 3) Make a driver more bullet proof. Maybe it would be possible somehow to force 
>> the driver to have a longer timeouts, more retries etc.
> 
> This is pointless. If another entity is accessing the chip without
> proper locking, no amount of timeouts or retries will help. In this
> scenario, reported errors are in fact the best thing than can happen.
> The worst case is silent misbehavior.

It is not pointless if this entity is just observed. I mean it is not using the 
i2c hw like our driver but it is using the bus itself.

Thanks,
Rudolf

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
