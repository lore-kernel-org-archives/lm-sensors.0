From: "=?ISO-8859-1?Q?Ludovic_Leb=E8gue?=" <ludovic@lebegue.org>
Date: Wed, 10 Dec 2008 22:24:05 +0000
Subject: [lm-sensors] Fwd:  sensors-detect: testers wanted!
Message-Id: <689a35800812101424v77822dc1x4b2b94e71eb09be4@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jean,

Here is the result of my latest tests with f8000 on a 2.6.27 kernel.

- Compilation OK :
- insmod OK : kernel trace
    Dec 10 23:16:57 xxx kernel: [88516.594275] f8000: Found F8000 chip at 0=
xa00
    Dec 10 23:16:57 xxx kernel: [88516.595009] f8000 f8000.2560: Fan
monitoring is enabled
    Dec 10 23:16:57 xxx kernel: [88516.595667] f8000 f8000.2560:
Temperature and voltage monitoring is enabled
- "sensors" output
    f8000-isa-0a00
    Adapter: ISA adapter
    in0:         +3.36 V
    in1:         +3.34 V
    in2:         +3.28 V
    fan1:       1466 RPM
    fan2:        909 RPM
    fan3:          0 RPM
    fan4:          0 RPM
    temp1:       +46.0=B0C  (high =3D +60.0=B0C, crit =3D +70.0=B0C)
    temp2:       +41.0=B0C  (high =3D +85.0=B0C, crit =3D +100.0=B0C)
    temp3:       +40.0=B0C  (high =3D +85.0=B0C, crit =3D +100.0=B0C)

It all seems OK to me.

Regards
Ludovic


---------- Forwarded message ----------
From: Ludovic Leb=E8gue <ludovic@lebegue.org>
Date: 2008/12/10
Subject: Re: [lm-sensors] sensors-detect: testers wanted!
To: Jean Delvare <khali@linux-fr.org>


Bonjour Jean,

Oui en effet je t'avais contact=E9 pour =E9crire un petit proto sur le
f8000 alros que tu n'avais pas les datasheets ...

Je compile la derni=E8re version et je t'envoi le r=E9sultat ...

Cordialement
Ludovic

2008/12/4 Jean Delvare <khali@linux-fr.org>:
> Bonjour Ludovic,
>
> Il me semble que c'est toi qui avait test=E9 mon pilote pr=E9liminaire po=
ur
> le F8000 il y a plusieurs mois ?
>
> On Wed, 3 Dec 2008 23:38:19 +0100, Ludovic Leb=E8gue wrote:
>> Hi Jean
>>
>> Just tested it on my computer.
>>
>> The result is Ok compared to what gave the previous version.
>>
>> Here is the copy of the latest lines :
>>
>>
>> Driver `coretemp':
>>   * Chip `Intel Core family thermal sensor' (confidence: 9)
>>
>> Driver `f8000':
>>   * ISA bus, address 0xa00
>>     Chip `Asus F8000 Super IO' (confidence: 9)
>>
>> Do you want to generate /etc/sysconfig/lm_sensors? (yes/NO):
>> To load everything that is needed, add this to one of the system
>> initialization scripts (e.g. /etc/rc.d/rc.local):
>>
>> #----cut here----
>> # Chip drivers
>> modprobe coretemp
>> # Warning: the required module f8000 is not currently installed
>> # on your system. For status of 2.6 kernel ports check
>> # http://www.lm-sensors.org/wiki/Devices. If driver is built
>> # into the kernel, or unavailable, comment out the following line.
>> modprobe f8000
>> /usr/bin/sensors -s
>> #----cut here----
>>
>> If you have some drivers built into your kernel, the list above will
>> contain too many modules. Skip the appropriate ones! You really
>> should try these commands right now to make sure everything is
>> working properly. Monitoring programs won't work until the needed
>> modules are loaded.
>>
>> Unloading i2c-dev... OK
>> Unloading i2c-i801... OK
>
> OK, merci pour le rapport. =C7a m'a l'air correct, en tout cas il n'y a
> rien qui me choque.
>
> Est-ce que tu aurais la possibilit=E9 de tester =E0 nouveau mon pilote
> f8000 ? J'y ai apport=E9 quelques am=E9liorations ce matin, maintenant que
> j'ai de la documentation technique dessus. Si tu testes et que =E7a
> marche, je pourrai peut-=EAtre ajouter ce pilote dans Linux 2.6.29 pour
> que d'autres utilisateurs puissent en profiter.
>
> Le nouveau pilote est l=E0 :
> http://jdelvare.pck.nerim.net/sensors/f8000/
>
> En plus de la sortie de "sensors", je suis int=E9ress=E9 par les logs du
> noyau au chargement du pilote.
>
> Merci,
> --
> Jean Delvare
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
