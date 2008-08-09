From: Beth <beth.null@gmail.com>
Date: Sat, 09 Aug 2008 01:54:18 +0000
Subject: Re: [lm-sensors] Problems with a MSI K8T Neo2 v2.0 (wrong voltages
Message-Id: <7641eb8f0808081854t28e36437qc298f8f6f340babf@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <7641eb8f0808081145q3ad0208ftaa94915e52e0043@mail.gmail.com>
In-Reply-To: <7641eb8f0808081145q3ad0208ftaa94915e52e0043@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Matt,

sensors -v :

      sensors version 3.0.0 with libsensors version 3.0.0

I am going to check the FAQ to see if I missed something, and the only
thing I can see at BIOS is enabling and disabling Cool & Quiet without
any visible (audible is more appropriate) change, but I am going to
re-check all to be sure.

Thanks for your help, see you.


2008/8/9 Matt Roberds <mattroberds@cox.net>:
> On Fri, 8 Aug 2008, Beth wrote:
>>
>> (I am using ubuntu 8.04 and kernel 2.6.24-19-generic, with an AMD
>> Athlon(tm) 64 X2 Dual Core Processor 4200+)
>
> What version of sensors are you running?  (Say
> sensors -v
> to find out.)
>
>> The temps seems to be accurate but the voltages are wrong.
>
> See
> http://www.lm-sensors.org/wiki/FAQ/Chapter3#Somemeasurementsarewayoutofra=
nge.Whathappened
> and
> http://www.lm-sensors.org/wiki/FAQ/Chapter3#a-5Vand-12Vreadingsarewayouto=
frange
>
>
>> And if I try to do a pwmconfig no correlations are detected:
>
> Have you tried disabling or at least changing the speed and fan related
> settings in the BIOS to see if that affects anything?
>
> Matt Roberds
>
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
