From: Moebius <moebius20@free.fr>
Date: Sun, 25 Nov 2007 14:13:01 +0000
Subject: Re: [lm-sensors] k8temp, BE-2350 CPU
Message-Id: <474982ED.8040200@free.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <46BAABD3.5000103@assembler.cz>
In-Reply-To: <46BAABD3.5000103@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


For me (AMD Athlon x2 64 4400+ and a asus MNPV-VM motherboard) it gives :

cat /sys/bus/pci/drivers/k8temp/0000\:00\:18.3/temp*
-9000
-11000
2000
-15000

and the sensors command seems to give a temp1 value (witch is supposed=20
to be the cpu one) lower than the one given by bios when I reboot (don't=20
know how to get the bios given temperature without rebooting and seeing=20
it in the bios setup)

Welle that's strange and insecure to configure something confident

cordialement,


Jean Delvare a =E9crit :
> Hi Alistair,
>=20
> On Mon, 8 Oct 2007 00:53:25 +0100, Alistair John Strachan wrote:
>> On Thursday 09 August 2007 07:38:29 Alistair John Strachan wrote:
>>> On Thursday 09 August 2007 06:53:23 Rudolf Marek wrote:
>>>> Hi,
>>>>
>>>> Sorry for the delay. I'm CCing the list too please do too.
>>>>
>>>> Alistair John Strachan wrote:
>>>>> Hi,
>>>>>
>>>>> I've noticed a problem with the k8temp driver on a new BE-2350
>>>>> processor. It seems the sensors report bogus values on this CPU. This
>>>>> is when it is idling:
>>>>>
>>>>> root@joyeuse:~# cat /sys/bus/pci/drivers/k8temp/0000\:00\:18.3/temp*
>>>>> -5000
>>>>> -5000
>>>>> -3000
>>>>> 1000
>>>>>
>>>>> And this is under load:
>>>>>
>>>>> root@joyeuse:~# cat /sys/bus/pci/drivers/k8temp/0000\:00\:18.3/temp*
>>>>> 7000
>>>>> 12000
>>>>> 11000
>>>>> 17000
>>>>>
>>>>> This is a socket AM2 processor. Any idea what's wrong? Using kernel
>>>>> 2.6.23-rc1, but it's also broken on Debian's 2.6.22.
>>>> Hmm perhaps the formula does not work anymore :/ Can you send me output
>>>> of cat /proc/cpuinfo?
>> Sorry to nag, Rudolf, but has there been any progress on this issue?
>=20
> My understanding is that some K8 CPU series simply have broken thermal
> sensors and there's not much we can do about it. In some cases you may
> try applying arbitrary offsets to get somewhat realistic (yet
> incorrect) values, in others even that won't work.
>=20
> Maybe we will have to blacklist some CPU series from the k8temp driver
> to avoid the confusion.
>=20


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
