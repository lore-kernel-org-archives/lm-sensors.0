From: Beth <beth.null@gmail.com>
Date: Mon, 11 Aug 2008 11:02:10 +0000
Subject: Re: [lm-sensors] Problems with a MSI K8T Neo2 v2.0 (wrong voltages
Message-Id: <7641eb8f0808110402j4c633df8xb3f4d61e99a27d2c@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <7641eb8f0808081145q3ad0208ftaa94915e52e0043@mail.gmail.com>
In-Reply-To: <7641eb8f0808081145q3ad0208ftaa94915e52e0043@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi again ;).

Well I re-checked all, and at the bios there is no way of slowing down
the fans, the only thing I can do as I said previously is turning
on/off the Cool&Quiet option (but it doesn't affect the pwm & fan
matching).

With the voltages, well, maybe the negative ones aren't monitored or
connected, but it is purely informative.

The main problem is the fan speeds, sometimes I fell that the pc will
take off land ;).

Any other suggestion? idea?

Thanks for your support, see you.

2008/8/9 Beth <beth.null@gmail.com>:
> Hi Matt,
>
> sensors -v :
>
>      sensors version 3.0.0 with libsensors version 3.0.0
>
> I am going to check the FAQ to see if I missed something, and the only
> thing I can see at BIOS is enabling and disabling Cool & Quiet without
> any visible (audible is more appropriate) change, but I am going to
> re-check all to be sure.
>
> Thanks for your help, see you.
>
>
> 2008/8/9 Matt Roberds <mattroberds@cox.net>:
>> On Fri, 8 Aug 2008, Beth wrote:
>>>
>>> (I am using ubuntu 8.04 and kernel 2.6.24-19-generic, with an AMD
>>> Athlon(tm) 64 X2 Dual Core Processor 4200+)
>>
>> What version of sensors are you running?  (Say
>> sensors -v
>> to find out.)
>>
>>> The temps seems to be accurate but the voltages are wrong.
>>
>> See
>> http://www.lm-sensors.org/wiki/FAQ/Chapter3#Somemeasurementsarewayoutofr=
ange.Whathappened
>> and
>> http://www.lm-sensors.org/wiki/FAQ/Chapter3#a-5Vand-12Vreadingsarewayout=
ofrange
>>
>>
>>> And if I try to do a pwmconfig no correlations are detected:
>>
>> Have you tried disabling or at least changing the speed and fan related
>> settings in the BIOS to see if that affects anything?
>>
>> Matt Roberds
>>
>>
>
>
>
> --
> ---------------------------------------------------
> Jos=E9 Antonio Robles
>
> beth.null@gmail.com
>
> 661 960 119
>
> Sometimes something happens ...
> ---------------------------------------------------
>



--=20
---------------------------------------------------
Jos=E9 Antonio Robles

beth.null@gmail.com

661 960 119

Sometimes something happens ...
---------------------------------------------------

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
