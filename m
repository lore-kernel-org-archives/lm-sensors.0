From: Gerold Gruber <Gerold.Gruber@edv2g.de>
Date: Sun, 25 Nov 2007 20:55:19 +0000
Subject: Re: [lm-sensors] k8temp, BE-2350 CPU
Message-Id: <4749E137.5020802@edv2g.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <46BAABD3.5000103@assembler.cz>
In-Reply-To: <46BAABD3.5000103@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

seems I have such a CPU, too:
cat /sys/bus/pci/drivers/k8temp/0000\:00\:18.3/temp*
16000
-6000
5000
5000

from /proc/cpuinfo:
cpu family      : 15
model           : 107
model name      : AMD Athlon(tm) 64 X2 Dual Core Processor 4000+
stepping        : 1

Board: Asrock AM2NF3-VSTA

regards


Moebius wrote:
> For me (AMD Athlon x2 64 4400+ and a asus MNPV-VM motherboard) it gives :
>=20
> cat /sys/bus/pci/drivers/k8temp/0000\:00\:18.3/temp*
> -9000
> -11000
> 2000
> -15000
>=20
> and the sensors command seems to give a temp1 value (witch is supposed=20
> to be the cpu one) lower than the one given by bios when I reboot (don't =

> know how to get the bios given temperature without rebooting and seeing=20
> it in the bios setup)
>=20
> Welle that's strange and insecure to configure something confident
>=20
> cordialement,
>=20
>=20
> Jean Delvare a =E9crit :
>> Hi Alistair,
>>
>> On Mon, 8 Oct 2007 00:53:25 +0100, Alistair John Strachan wrote:
>>> On Thursday 09 August 2007 07:38:29 Alistair John Strachan wrote:
>>>> On Thursday 09 August 2007 06:53:23 Rudolf Marek wrote:
>>>>> Hi,
>>>>>
>>>>> Sorry for the delay. I'm CCing the list too please do too.
>>>>>
>>>>> Alistair John Strachan wrote:
>>>>>> Hi,
>>>>>>
>>>>>> I've noticed a problem with the k8temp driver on a new BE-2350
>>>>>> processor. It seems the sensors report bogus values on this CPU. This
>>>>>> is when it is idling:
>>>>>>
>>>>>> root@joyeuse:~# cat /sys/bus/pci/drivers/k8temp/0000\:00\:18.3/temp*
>>>>>> -5000
>>>>>> -5000
>>>>>> -3000
>>>>>> 1000
>>>>>>
>>>>>> And this is under load:
>>>>>>
>>>>>> root@joyeuse:~# cat /sys/bus/pci/drivers/k8temp/0000\:00\:18.3/temp*
>>>>>> 7000
>>>>>> 12000
>>>>>> 11000
>>>>>> 17000
>>>>>>
>>>>>> This is a socket AM2 processor. Any idea what's wrong? Using kernel
>>>>>> 2.6.23-rc1, but it's also broken on Debian's 2.6.22.
>>>>> Hmm perhaps the formula does not work anymore :/ Can you send me outp=
ut
>>>>> of cat /proc/cpuinfo?
>>> Sorry to nag, Rudolf, but has there been any progress on this issue?
>> My understanding is that some K8 CPU series simply have broken thermal
>> sensors and there's not much we can do about it. In some cases you may
>> try applying arbitrary offsets to get somewhat realistic (yet
>> incorrect) values, in others even that won't work.
>>
>> Maybe we will have to blacklist some CPU series from the k8temp driver
>> to avoid the confusion.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
