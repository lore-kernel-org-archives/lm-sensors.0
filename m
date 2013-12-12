From: Thomas Raschbacher <lordvan@lordvan.com>
Date: Thu, 12 Dec 2013 07:28:44 +0000
Subject: Re: [lm-sensors] Configuration for motherboard Asus M5A97 PRO
Message-Id: <5cabf4d6830dabfe024fae354466da6b@secure.lordvan.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CANd=OGHaRax2kRYepnUrLX8KN1VwmLxkse_ObbOYOyQhTUc5cQ@mail.gmail.com>
In-Reply-To: <CANd=OGHaRax2kRYepnUrLX8KN1VwmLxkse_ObbOYOyQhTUc5cQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi.

I will have a look when I get a chance (but it might have to wait until=20
the weekend - or even longer if i don'T get aroudn to it then-)

Regards

On 2013-12-09 09:20, Jean Delvare wrote:
> Hi Felipe,
>=20
> On Sun, 8 Dec 2013 21:54:34 -0200, Felipe Almeida Lessa wrote:
>> I've tried to adjust the values to my motherboard.  The result is
>> pasted below.  I hope it can make it to the wiki :).
>>=20
>> Cheers!
>>=20
>> PS: I'm not subscribed to the mailing list.
>>=20
>> # Asus M5A97 PRO
>> # http://blog.felipe.lessa.nom.br/?p=93
>> chip "k10temp-pci-00c3"
>>      label temp1 "CPU Temp (rel)"
>>=20
>> chip "it8721-*"
>>      label  in0 "+12V"
>>      label  in1 "+5V"
>>      label  in2 "Vcore"
>>      ignore in4
>>      ignore in5
>>      ignore in6
>=20
> I'm quite surprised by this, that's a rather uncommon voltage input
> mapping. How did you figure it out?
>=20
>>=20
>>      compute in0  @ * (515/120), @ / (515/120)
>>      compute in1  @ * (215/120), @ / (215/120)
>=20
> And where do these scaling factors come from?
>=20
>>=20
>>      ignore temp3
>>      label temp1 "CPU Temp"
>>      label temp2 "M/B Temp"
>>=20
>>      label fan1 "CPU Fan"
>>      label fan2 "Chassis Fan"
>>      label fan3 "Power Fan"
>>=20
>>      ignore intrusion0
>=20
> I've added your configuration file at:
> http://www.lm-sensors.org/wiki/Configurations/Asus/M5A97-Pro
>=20
> Thomas, you have the same board and have been asking for a
> configuration file for it last week, so you could give it a try. If you
> and Felipe share your findings, you may be able to improve Felipe's
> initial file (which I suspect needs improvements, but I may be wrong.)
>=20
> I wrote an article on how to figure out voltage mappings and scales:
> http://www.lm-sensors.org/wiki/VoltageLabelsAndScaling
> The IT8721F has 0.012 mV LSB. If you both gather all the different
> values you get in the BIOS for +5V and +12V, we should be able to come
> up with something.
>=20
> Or if any of you have Windows and the Asus monitoring tool installed on
> the same machine, even better.
>=20
> Please keep the list in Cc if you want us to be able to help.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
