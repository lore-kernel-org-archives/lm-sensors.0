From: Marcelo Coelho <marcelocoelho@gmail.com>
Date: Sun, 29 May 2011 09:21:09 +0000
Subject: Re: [lm-sensors] Working configuration for intel D945GCLF
Message-Id: <BANLkTikwvPAYiFajEsPp4AHXR+SV7670-w@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <BANLkTikVJz5rUrtdHEY82Lc8yoggnyA8HA@mail.gmail.com>
In-Reply-To: <BANLkTikVJz5rUrtdHEY82Lc8yoggnyA8HA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi!


The Bios says 1.8V.

In the afternoon I noticed that the fans weren't shown and that I had
to put the acpi_enforce_resoures=3Dlax option in grub.

The modules that i needed were i2c-i801, smsc47m1, smsc47m192.

The final configuration is:


# Configuration for Intel DG945GCLF

chip "smsc47m1-*"
    label fan1 "fan case"
# The minimum speed for fans with this chip is 1300. So, if you have a
disconnected fan
# your best option is to ignore it
#    ignore fan1
#    set fan1_min 1300

    label fan2 "fan cpu"


chip "smsc47m192-*"
    label in0 "+2.5V"
    set in0_min  2.5 * 0.95
    set in0_max  2.5 * 1.05

    label in1 "Vcore"
    set in1_min  0.9
    set in1_max  1.162

    label in2 "+3.3V"
    set in2_min  3.3 * 0.90
    set in2_max  3.3 * 1.10

    label in3 "+5V"
    set in3_min  5.0 * 0.90
    set in3_max  5.0 * 1.10

    label in4 "+12V"
    set in4_min 12.0 * 0.90
    set in4_max 12.0 * 1.10

    label in5 "VCC"
    set in5_min  3.3 * 0.90
    set in5_max  3.3 * 1.10

    label in6 "+1.5V"
    set in6_min  1.5 * 0.90
    set in6_max  1.5 * 1.10

    label in7 "+1.8V"
    set in7_min  1.8 * 0.90
    set in7_max  1.8 * 1.10

    label temp1 "Chipset Temp"
    set temp1_min 0
    set temp1_max 90

    label temp2 "CPU Temp"
    set temp2_min 0
    set temp2_max 85

    label temp3 "System Temp"
    set temp3_min 0
    set temp3_max 75


Best regards,
Marcelo Coelho

2011/5/29 Jean Delvare <khali@linux-fr.org>:
> Hi Marcelo,
>
> On Sat, 28 May 2011 11:00:28 +0100, Marcelo Coelho wrote:
>> Hi,
>>
>> I don't have a wiki account, so anyone that has one can put this in
>>
>> intel/D945GCLF ?
>
> Done:
> http://www.lm-sensors.org/wiki/Configurations/Intel/D945GCLF
>
> Thanks for your contribution.
>
>> =A0 =A0 label in7 "+1.8V"
>> =A0 =A0 set in7_min =A01.8 * 0.90
>> =A0 =A0 set in7_max =A01.8 * 1.10
>
> Presumably this is the DDR2 memory module voltage? What does the BIOS
> say?
>
> --
> Jean Delvare
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
