From: juergh@gmail.com (Juerg Haefliger)
Date: Fri, 31 Mar 2006 16:49:56 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: new vt1211 driver
Message-Id: <191fb4ca0603310849n73b8648cl31d0c605a789548@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0602251324o560dcd61oc55dc703f452a570@mail.gmail.com>
In-Reply-To: <191fb4ca0602251324o560dcd61oc55dc703f452a570@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>>> I'm proposing that some of funcs can be done via macro or 2D array.
>>> This might help to shrink the source code a bit.
>>
>> I had it this way in the begining but threw it out for some reasons I
>> can't remember anymore. I'll take a look at it again.
>
> Maybe Jean have some idea about it too? Or others?

I fixed it already, don't bother.

>>> I'm not user about the runtime UCONFIG configuration. Perhaps cleanest
>>> solution would be to create/remove sysfs nodes runtime instead of
>>> exporting them with zero.
>>
>> I don't understand. Exporting the UCH config register is a left-over
>> from the 2.4 driver. I think the reason why it's in the 2.4 driver is
>> because some BIOSes don't set it correctly. Maybe this is not true
>> anymore and we can now fully rely on the BIOS doing it right and don't
>> need to export the register anymore. Comments anyone?
>
> Well me. I think we can drop this interface and read the UHC
> conf only at the driver start. User with bad BIOS config can
> do i2cset/isaset commands if neccessary to change the config
> and then load the driver.
>

hmm... libsensor currently supports this interface. Is it deprecated?
Using i2c to change it would be OK I guess, except that the driver
itself doesn't need i2c anymore (it's platform) and the user would
have to compile i2c just for this (if required, that is).
How about using a module load parameter instead?

...juerg

