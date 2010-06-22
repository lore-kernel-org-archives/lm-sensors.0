From: Ulf Granlund <galsjo@hotmail.com>
Date: Tue, 22 Jun 2010 09:00:37 +0000
Subject: Re: [lm-sensors] Too low temp readings on overclocked Intel Atom CPU
Message-Id: <BLU142-W258289F32521E0754EE71DD3C40@phx.gbl>
List-Id: <lm-sensors.vger.kernel.org>
References: <BLU142-W26CE1E8D8E3AE3FD1983A1D3C30@phx.gbl>
In-Reply-To: <BLU142-W26CE1E8D8E3AE3FD1983A1D3C30@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


Hi Jean, thank you for your answer.
Some answers to your questions, as far as I can get them:
The CPU model is "Intel Atom CPU 330 @1.6 GHz" according to system info in =
the BIOS.
CPU Voltage: From the manual or the Asrock home page, I have not found any =
clear specification on exactlywhat parameters the overclocking option alter=
s. I found some hardware review pages on the net stating thatwhen using thi=
s option ( with the highest available frequency, 2100 MHz) the CPU voltage =
is automaticallyset to 1.315 V. I have no idea about how reliable this info=
rmation is or where they got it from. In the BIOS theoverclocking option is=
 mentioned as "an optimized set" of overclocking parameters, indicating tha=
t at least morethan one parameter is affected.
=A0When I load the CPU:s there is a clear raise in temperature values both =
when I am overclocked and when running atstandard speed, but for essentiall=
y the same CPU load (watching a movie for 5 minutes) the temperatures are a=
bout 10 to 15=A0=B0Clower in the overclocked state, which does not seem rea=
sonable.
In the hardware reviews found on some net sites, it is mentioned that there=
 is a (Windows) systemmonitoring software that is supplied with the system =
from Asrock. There is data from this softwarepresented in the reviews, wher=
e temperature readings are collected in both standard and overclocked state=
s, andfrom that software they get temperature readings that are clearly hig=
her when running overclocked, which seems to bethe most reasonable result. =
To me this seems to show that it is possible to get reliable temp readings =
also in the overclockedstate. But then again that software is supplied by A=
srock, and I guess they have full control of all parameters.
Best Regards
Ulf
----------------------------------------
> Date: Mon, 21 Jun 2010 23:06:05 +0200
> From: khali@linux-fr.org
> To: galsjo@hotmail.com
> CC: lm-sensors@lm-sensors.org; huaxu.wan@intel.com
> Subject: Re: [lm-sensors] Too low temp readings on overclocked Intel Atom=
 CPU
>
> Hi Ulf,
>
> On Mon, 21 Jun 2010 12:19:50 +0200, Ulf Granlund wrote:
>>
>> Hello,
>> I am running an Asrock Ion computer under Ubuntu 10.4. It has four Intel=
 Atom CPU cores. In the Asrock BIOS thereis an option to introduce overcloc=
king. I have set the frequency to 1800 MHz insetad of the standard 1600 MHz.
>
> By doing this, you are unsupported. If you decide to use your hardware
> beyond its specification, you shouldn't be surprised if it fails.
>
> Please tell us the exact CPU model.
>
> Do you know if the overclocking alters only the frequency, or also the
> CPU core voltage?
>
>> After having the computer switched on for several hours, but the CPU:s m=
ainly idle, the output from the sensors command is as below,in a room where=
 ambient temperature is about 22 C.
>> coretemp-isa-0000Adapter: ISA adapterCore 0:       +4.0=B0C  (crit =3D +=
90.0=B0C)
>> coretemp-isa-0001Adapter: ISA adapterCore 1:      +16.0=B0C  (crit =3D +=
90.0=B0C)
>> coretemp-isa-0002Adapter: ISA adapterCore 2:       +3.0=B0C  (crit =3D +=
90.0=B0C)
>> coretemp-isa-0003Adapter: ISA adapterCore 3:      +16.0=B0C  (crit =3D +=
90.0=B0C)
>
> This is horribly formatted.
>
>> Clearly these temperatures are way too low.However, if I set the process=
or frequency to the standard 1600 MHz,I get:
>> coretemp-isa-0000Adapter: ISA adapterCore 0:      +17.0=B0C  (crit =3D +=
90.0=B0C)
>> coretemp-isa-0001Adapter: ISA adapterCore 1:      +25.0=B0C  (crit =3D +=
90.0=B0C)
>> coretemp-isa-0002Adapter: ISA adapterCore 2:      +18.0=B0C  (crit =3D +=
90.0=B0C)
>> coretemp-isa-0003Adapter: ISA adapterCore 3:      +25.0=B0C  (crit =3D +=
90.0=B0C)
>> Which at least seems far more reasonable.
>
> This is very interesting. Adding the coretemp driver maintainer in Cc.
>
>> It seems that the more I overclock, the lower the temperature readings g=
et.Can somebody explain how to get correct temp readings? It is of course m=
ore importantto me to get correct readings in the overclocked situation tha=
n in the standard situation...
>> The lm-sensors version used is 3.1.2 and the linux kernel version is 2.6=
.32.
>
> First thing to check is: do the temperature values increase or decrease
> when you load the CPUs?
>
> Then I guess you could give a try to the latest version of the driver,
> as it received changes recently:
> http://khali.linux-fr.org/devel/misc/coretemp/
>
> But anyway, odds are that the sensors are affected by overclocking and
> nothing can be done, except: don't do it.
>
> --
> Jean Delvare
 		 	   		 =20
_________________________________________________________________
Hotmail i mobilen p=E5 5 sekunder!
http://new.windowslivemobile.msn.com/SE-SE/windows-live-hotmail/default.aspx
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
