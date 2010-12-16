From: Juerg Haefliger <juergh@gmail.com>
Date: Thu, 16 Dec 2010 10:23:44 +0000
Subject: Re: [lm-sensors] Driver for SMSC SCH5627 needed
Message-Id: <AANLkTinNuGETSREiBdUyCxA9gezn5SvoDQ=AP5=5okv6@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4CBD8E44.8070909@ts.fujitsu.com>
In-Reply-To: <4CBD8E44.8070909@ts.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi Jean,

While I have your attention :-)

> Hi Jean
>
>>> Took a quick glance at the datasheet. This is a totally different
>>> beast that is not even remotely compatible to anything we support thus
>>> far AFAIK. It contains an embedded microcontroller (!) which handles
>>> all the hwmon related tasks. The datasheet that I received doesn't
>>> contain any information about the microcontroller other than a simple
>>> block diagram. So at the moment it's absolutely a no go and even with
>>> all the technical data we would have to start from scratch with a new
>>> driver.
>>
>> Thanks Juerg for checking this. Can you please update sensors-detect
>> with the device name and features, and also create an entry in
>> wiki/Devices? So that other user with that chip know the current
>> status, even if it's bad.
>
> I added detection to sensors-detect but I'm not too happy with the outcome:
> Trying family `SMSC'...                                     Yes
> Found `SMSC SCH5627 Desktop Embedded Controller'
>   (but not activated)
>
> The chip shouldn't be probed at all since it's non-standard. Users
> might get confused by the 'not activated' message and will ask how to
> activate it. Is there a way to bypass the probing and just print a
> message that there is no driver for this chip?

Any suggestions on how to accomplish this?

Thanks
...Juerg

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
