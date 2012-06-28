From: Michael Zintakis <michael.zintakis@googlemail.com>
Date: Thu, 28 Jun 2012 11:15:43 +0000
Subject: Re: [lm-sensors] Fintek f71882fg ACPI conflict
Message-Id: <4FEC3CDF.7050901@googlemail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4FEA4C10.2060904@googlemail.com> <20120627171505.GB12712@roeck-us.net> <4FEB90A8.8050901@googlemail.com> <20120628014548.GA15994@srcf.ucam.org>
In-Reply-To: <20120628014548.GA15994@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Guenter Roeck <linux@roeck-us.net>, lm-sensors@lm-sensors.org, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org


>> Could any of the more knowledgeable on here explain why
>> is it such a bad idea please?
>>     
>
> Because there's no handshaking between the firmware and the OS driver, 
> and accesses to hardware sensors are often indexed. Imagine this 
> scenario:
>
> ACPI                             lmsensors
> ----                             ---------
> select temperature register
>                                  select fan speed register
> read value
>                                  read value
>
> ACPi will read the fan speed register instead of the temperature 
> register, and the value may be far too high and cause a critical 
> shutdown of the system.
>
> That's the *good* outcome. The bad outcome involves these register 
> accesses racing in a way that disables fan control or thermal trip 
> points and risks causing hardware damage. It's not safe for two 
> different codepaths to access the same hardware without having any kind 
> of locking, so if your system firmware declares that ACPI is using the 
> temperature device the hardware sensors framework will refuse to.
>   
All noted, thanks for the explanation - pretty hairy stuff! The tragic 
thing is, I have no way of telling ACPI to *not* use or "implement" its 
own fan, voltage, temperature management and let a more capable piece of 
software (the f71882fg driver in this case) do that job!

What is the alternative? There is none that I could see. I tried using 
memmap to force ACPI not to use the memory region claimed by f71882fg 
(0x290 - 8 bytes long according to the driver), but that didn't help 
much. What am I supposed to do - deactivate ACPI completely? That would 
be like going after a fly with a bazooka!

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
