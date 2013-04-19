From: =?ISO-8859-1?Q?Martin_Hundeb=F8ll?= <martin@hundeboll.net>
Date: Fri, 19 Apr 2013 10:06:59 +0000
Subject: Re: [lm-sensors] Dell Inspiron 530 Chassis Fan Control?
Message-Id: <51711743.8090706@hundeboll.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20130316175820.GA979@whitehail.bostoncoop.net>
In-Reply-To: <20130316175820.GA979@whitehail.bostoncoop.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On 2013-04-18 16:50, Adam Rosi-Kessel wrote:
> On 3/16/2013 6:59 PM, Guenter Roeck wrote:
>>>>>> > > >>Sorry -- typo above. It should say I can control*CPU*  fans, b=
ut can't
>>>>>> > > >>find any documentation as to how to control the*chassis*  fan.
>>>>> > > >On my motherboard, all fan headers have 4 pins, but there is a j=
umper
>>>>> > > >to tell the board to treat the case fan headers as 3-pin. This is
>>>>> > > >rather rare though, most motherboards have it hard-wired
>>>> > >Thanks. I will check this. Before I open up my case, is there anywh=
ere I
>>>> > >can/should look in log files or /sys to see if the chassis fan is
>>>> > >controllable? Would this be found in a different place than the CPU=
 fans?
>>> >
>>> >No, it can't be seen from the logs nor /sys. Only hardware inspection
>>> >can tell you, and not even in all cases.
>>> >
>> Inspiron 530 manual (downloadable) says that the processor fan has a 4-p=
in
>> connector and the chassis fan has a 3-pin connector.
> Apologies as this a bit OT, but hoping someone can help me understand
> what's happening here. It does appear that the Inspiron has a 3-pin
> connector. When I power up the box, it is very quiet for about 4 or 5
> minutes. After that, the fan appears to go to 100% and never quiets down
> again. Even when I cpufreq-set to powersave and cap the max CPU freq at
> 2.0 GHz for all four cores (80% of max), it still stays loud
> indefinitely. I've opened up the box and cleaned out all dust and
> visually inspected the fans, and nothing appears awry.
> /sys/devices/virtual/thermal/thermal_zone0/temp consistently reports
> 40.0 degrees C i.e. 40000 (I'm actually suspicious of that number
> because it never seems to change). Any ideas for what I can do to
> troubleshoot why the fan is always running at full blast?

My Latitude E5430 has the same issue, but only when connected to=20
external monitors, so I suspect the GPU to produce too much heat.

--=20
Kind Regards
Martin Hundeb=F8ll
Frederiks All=E9 99, 1.th
8000 Aarhus C
Denmark

+45 61 65 54 61
martin@hundeboll.net

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
