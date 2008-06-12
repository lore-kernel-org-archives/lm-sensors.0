From: "Paul Smith" <phhs80@gmail.com>
Date: Thu, 12 Jun 2008 16:57:04 +0000
Subject: Re: [lm-sensors] Wrong CPU Temp
Message-Id: <6ade6f6c0806120957q7d0c0bch641e409749bf8ae6@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <001201c33f14$0ee832a0$f265a8c0@gf01>
In-Reply-To: <001201c33f14$0ee832a0$f265a8c0@gf01>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Thu, Jun 12, 2008 at 2:30 PM, Jean Delvare <khali@linux-fr.org> wrote:
>> In the output below, the value
>>
>> CPU Temp:     -2.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  sens=
or =3D transistor
>>
>> seems unlikely:
>>
>> $ sensors
>> it8712-isa-0290
>> Adapter: ISA adapter
>> VCore 1:     +1.28 V  (min =3D  +0.00 V, max =3D  +4.08 V)
>> VCore 2:     +1.82 V  (min =3D  +0.00 V, max =3D  +4.08 V)
>> +3.3V:       +3.38 V  (min =3D  +0.00 V, max =3D  +4.08 V)
>> +5V:         +6.85 V  (min =3D  +0.00 V, max =3D  +6.85 V)   ALARM
>> +12V:       +11.84 V  (min =3D  +0.00 V, max =3D +16.32 V)
>> -12V:       -13.86 V  (min =3D -27.36 V, max =3D  +3.93 V)
>> -5V:         -7.34 V  (min =3D -13.64 V, max =3D  +4.03 V)
>> Stdby:       +6.85 V  (min =3D  +0.00 V, max =3D  +6.85 V)   ALARM
>> VBat:        +4.08 V
>> fan1:       1704 RPM  (min =3D    0 RPM, div =3D 8)
>> fan2:          0 RPM  (min =3D    0 RPM, div =3D 8)
>> fan3:          0 RPM  (min =3D    0 RPM, div =3D 8)
>> M/B Temp:    -55.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  sens=
or =3D transistor
>> CPU Temp:     -2.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  sens=
or =3D transistor
>> Temp3:       +47.0=B0C  (low  =3D +127.0=B0C, high =3D +90.0=B0C)  senso=
r =3D thermal diode
>> cpu0_vid:   +1.350 V
>>
>> $
>>
>> My motherboard is a GigaBite GA-81945PL-G, the processor is an Intel
>> Dual Core, and the operating system is Fedora 9.
>>
>> Any ideas?
>
> Typical of Gigabyte boards. They put two Ethernet chips, 2 USB
> controllers, Firewire, two Serial ATA controllers, etc. on the board,
> but omit the thermistor for motherboard temperature to save a few
> cents. Go figure... My own board (Gigabyte K8V Ultra-939) says:
>
> temp1:       +25.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  senso=
r =3D disabled
> temp2:       -55.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  senso=
r =3D disabled
> temp3:       +47.0=B0C  (low  =3D +10.0=B0C, high =3D +51.0=B0C)  sensor =
=3D thermal diode
>
> And temp1 never changes. So, same as yours: temp3 is the CPU
> temperature, and temp1 and temp2 can be ignored (and even disabled).
> The relevant part of my configuration file is:
>
> ### Temperatures
>
>   # Gigabyte confirmed that there is no system temperature sensor on this
>   # motherboard. This is really disappointing, as the board is otherwise
>   # full featured.
>
>   ignore temp1
>   ignore temp2
>   label  temp3  "CPU Temp"
>
>   set temp1_type 0
>   set temp2_type 0
>
>   # The CPU temperature was seen from 34 to 48 degrees C so far.
>   set temp3_min  10
>   set temp3_max  51
>
> Hope that helps,

Thanks, Jean. Now I know (from you) that temp3, in my case,
corresponds to the CPU temperature.

Paul

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
