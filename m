From: "Wan, Huaxu" <huaxu.wan@intel.com>
Date: Mon, 28 Jun 2010 07:14:38 +0000
Subject: Re: [lm-sensors] Too low temp readings on overclocked Intel Atom CPU
Message-Id: <625BA99ED14B2D499DC4E29D8138F150308467AE9B@shsmsx502.ccr.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <BLU142-W26CE1E8D8E3AE3FD1983A1D3C30@phx.gbl>
In-Reply-To: <BLU142-W26CE1E8D8E3AE3FD1983A1D3C30@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Ulf,

The accuracy of sensors deteriorate more when far away from TjMax, a
spec say the temperature error is about +-10C at 50C. So, as you said,
 the value is more reasonable after the cup load increased.

Thanks
Huaxu


>-----Original Message-----
>From: Ulf Granlund [mailto:galsjo@hotmail.com]=20
>Sent: Sunday, June 27, 2010 4:46 AM
>To: khali@linux-fr.org
>Cc: lm-sensors@lm-sensors.org; Wan, Huaxu
>Subject: RE: [lm-sensors] Too low temp readings on overclocked=20
>Intel Atom CPU
>
>
>Hi Jean,
>I guess you are right about most of this. Clearly, the sensors=20
>are very unreliable at low temperatures.If I leave the=20
>computer switched off for a few hours in an ambient temp of 23=20
>C, and then turn it on,the senors show values in the order of=20
>-5 C for the first few minutes before the machine is warmed=20
>up,when reasonably, they should show about 23 C. And this is=20
>when the CPU is running at standardspeed. So the error that=20
>occurs from overclocking is relatively small compared to this=20
>ca 30 C error.=A0It possible that the sensors=A0perform better at=20
>higher temp, as you say, but how do I know that?=A0I can stress=20
>the machine and see=A0that I get more reasonable values when the=20
>CPU is working harder,and also the difference between=A0
>overclocked and standard speed is less pronounced at higher=20
>working load,=A0but there is no real way for me to tell when=20
>they stop beeing completely wrong and start beeing right.=A0
>Hopefully they will at least fulfill the function of turning=20
>the processor down before it burnsup, and apparently that is=20
>the only useful function they have, it seems that they can not=20
>really be used forreading the temperature.
>However, I have one last question. Since the processor only=20
>has two physical cores, butI get four readings, is there some=20
>way to tell which values are the ones from the realcores?
>Thanks for your advice,RegardsUlf
>----------------------------------------
>> Date: Wed, 23 Jun 2010 09:53:51 +0200
>> From: khali@linux-fr.org
>> To: galsjo@hotmail.com
>> CC: lm-sensors@lm-sensors.org; huaxu.wan@intel.com
>> Subject: Re: [lm-sensors] Too low temp readings on=20
>overclocked Intel Atom CPU
>>
>> Hi Ulf,
>>
>> Preliminary note: the mAtom 330 is a dual-core CPU, so you=20
>really have
>> 2 cores, not 4. I guess that each core has hyper-threading, which is
>> why you see 4 CPU entries. But I suspect that there's only one sensor
>> per core, so the coretemp driver should only display 2 values. I've
>> sent a patch fixing this, but it didn't receive any comment:
>> http://lists.lm-sensors.org/pipermail/lm-sensors/2010-May/028511.html
>>
>> About the Asrock software: it is possible that Asrock knows about the
>> problem and silently compensate for it. You'd need to ask=20
>them. But it
>> is also possible that other CPU samples have working sensors when
>> overclocked and only yours doesn't. Each CPU is unique when
>> overclocking. The only way to know for sure would be to run=20
>the Asrock
>> software on your own system.
>>
>> Don't you have an external hardware monitoring chip on your board? It
>> would probably be less influenced by overclocking, and would thus be
>> more reliable for comparing the temperature with and without
>> overclocking.
>>
>> Anyway, please note that the CPU temperature values reported by the
>> coretemp driver are notoriously inaccurate as long as they are way
>> below the critical limit. This is your case. So the bottom=20
>line is that
>> your CPU is very cool and you have no thermal issue at all.
>>
>> But beware, problems when overclocking aren't limited to a higher
>> running temperatures. All kind of issues can happen, which you won't
>> notice until things start failing mysteriously. And overclocking
>> doesn't buy you much in practice anyway, as the limiting speed factor
>> these days is more often the disk and memory speed than the=20
>CPU speed.
>>
>> Jean
>>
>> On Tue, 22 Jun 2010 11:00:37 +0200, Ulf Granlund wrote:
>>>
>>> Hi Jean, thank you for your answer.
>>> Some answers to your questions, as far as I can get them:
>>> The CPU model is "Intel Atom CPU 330 @1.6 GHz" according to=20
>system info in the BIOS.
>>> CPU Voltage: From the manual or the Asrock home page, I=20
>have not found any clear specification on exactlywhat=20
>parameters the overclocking option alters. I found some=20
>hardware review pages on the net stating thatwhen using this=20
>option ( with the highest available frequency, 2100 MHz) the=20
>CPU voltage is automaticallyset to 1.315 V. I have no idea=20
>about how reliable this information is or where they got it=20
>from. In the BIOS theoverclocking option is mentioned as "an=20
>optimized set" of overclocking parameters, indicating that at=20
>least morethan one parameter is affected.
>>>  When I load the CPU:s there is a clear raise in=20
>temperature values both when I am overclocked and when running=20
>atstandard speed, but for essentially the same CPU load=20
>(watching a movie for 5 minutes) the temperatures are about 10=20
>to 15 =B0Clower in the overclocked state, which does not seem reasonable.
>>> In the hardware reviews found on some net sites, it is=20
>mentioned that there is a (Windows) systemmonitoring software=20
>that is supplied with the system from Asrock. There is data=20
>from this softwarepresented in the reviews, where temperature=20
>readings are collected in both standard and overclocked=20
>states, andfrom that software they get temperature readings=20
>that are clearly higher when running overclocked, which seems=20
>to bethe most reasonable result. To me this seems to show that=20
>it is possible to get reliable temp readings also in the=20
>overclockedstate. But then again that software is supplied by=20
>Asrock, and I guess they have full control of all parameters.
>>> Best Regards
>>> Ulf
>>> ----------------------------------------
>>>> Date: Mon, 21 Jun 2010 23:06:05 +0200
>>>> From: khali@linux-fr.org
>>>> To: galsjo@hotmail.com
>>>> CC: lm-sensors@lm-sensors.org; huaxu.wan@intel.com
>>>> Subject: Re: [lm-sensors] Too low temp readings on=20
>overclocked Intel Atom CPU
>>>>
>>>> Hi Ulf,
>>>>
>>>> On Mon, 21 Jun 2010 12:19:50 +0200, Ulf Granlund wrote:
>>>>>
>>>>> Hello,
>>>>> I am running an Asrock Ion computer under Ubuntu 10.4. It=20
>has four Intel Atom CPU cores. In the Asrock BIOS thereis an=20
>option to introduce overclocking. I have set the frequency to=20
>1800 MHz insetad of the standard 1600 MHz..
>>>>
>>>> By doing this, you are unsupported. If you decide to use=20
>your hardware
>>>> beyond its specification, you shouldn't be surprised if it fails.
>>>>
>>>> Please tell us the exact CPU model.
>>>>
>>>> Do you know if the overclocking alters only the frequency,=20
>or also the
>>>> CPU core voltage?
>>>>
>>>>> After having the computer switched on for several hours,=20
>but the CPU:s mainly idle, the output from the sensors command=20
>is as below,in a room where ambient temperature is about 22 C.
>>>>> coretemp-isa-0000Adapter: ISA adapterCore 0: +4.0=B0C (crit=20
>=3D +90.0=B0C)
>>>>> coretemp-isa-0001Adapter: ISA adapterCore 1: +16.0=B0C=20
>(crit =3D +90.0=B0C)
>>>>> coretemp-isa-0002Adapter: ISA adapterCore 2: +3.0=B0C (crit=20
>=3D +90.0=B0C)
>>>>> coretemp-isa-0003Adapter: ISA adapterCore 3: +16.0=B0C=20
>(crit =3D +90.0=B0C)
>>>>
>>>> This is horribly formatted.
>>>>
>>>>> Clearly these temperatures are way too low.However, if I=20
>set the processor frequency to the standard 1600 MHz,I get:
>>>>> coretemp-isa-0000Adapter: ISA adapterCore 0: +17.0=B0C=20
>(crit =3D +90.0=B0C)
>>>>> coretemp-isa-0001Adapter: ISA adapterCore 1: +25.0=B0C=20
>(crit =3D +90.0=B0C)
>>>>> coretemp-isa-0002Adapter: ISA adapterCore 2: +18.0=B0C=20
>(crit =3D +90.0=B0C)
>>>>> coretemp-isa-0003Adapter: ISA adapterCore 3: +25.0=B0C=20
>(crit =3D +90.0=B0C)
>>>>> Which at least seems far more reasonable.
>>>>
>>>> This is very interesting. Adding the coretemp driver=20
>maintainer in Cc.
>>>>
>>>>> It seems that the more I overclock, the lower the=20
>temperature readings get.Can somebody explain how to get=20
>correct temp readings? It is of course more importantto me to=20
>get correct readings in the overclocked situation than in the=20
>standard situation...
>>>>> The lm-sensors version used is 3.1.2 and the linux kernel=20
>version is 2.6.32.
>>>>
>>>> First thing to check is: do the temperature values=20
>increase or decrease
>>>> when you load the CPUs?
>>>>
>>>> Then I guess you could give a try to the latest version of=20
>the driver,
>>>> as it received changes recently:
>>>> http://khali.linux-fr.org/devel/misc/coretemp/
>>>>
>>>> But anyway, odds are that the sensors are affected by=20
>overclocking and
>>>> nothing can be done, except: don't do it.
>>>>
>>>> --
>>>> Jean Delvare
> 		 	   		 =20
>_________________________________________________________________
>V=E5rfina smileys till Messenger h=E4r!
>http://springpack.msn.se
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
