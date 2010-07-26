From: Luca Tettamanti <kronos.it@gmail.com>
Date: Mon, 26 Jul 2010 07:39:20 +0000
Subject: Re: [lm-sensors] asus_atk0110 on a p6td deluxe
Message-Id: <AANLkTik+iy=Cv6DwoiPSehE6+d+5j8+iw5UzydO6x-xg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <724895.29279.qm@web28512.mail.ukl.yahoo.com>
In-Reply-To: <724895.29279.qm@web28512.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Mon, Jul 26, 2010 at 12:14 AM, Marco <jjletho67-ml@yahoo.it> wrote:
>
>
>>> Hi,
>>> i'm using the asus_atk0110 driver on a asus p6td deluxe mb, Fedora 12, =
kernel
>>> 2.6.32.16-141.fc12.x86_64, sensors 3.1.2
>>>
>>> The problem is with the list of sesors i obtain, which i think is incom=
plete
> [cut]
>>> I expect several more parameter like QPI/DRAM volatge, DRAM bus voltage=
 etc.
>>>
>>> Using google i found a lot of users with a similar hardware which can o=
btain
>>> more sensors, for example:
>>>
>>>http://vip.asus.com/forum/view.aspx?id 090518224331815&board_id=3D1&mode=
l=3DRampage+II+Gene&page=3D1&SLanguage=3Den-us
>>>s
>>> http://swiss.ubuntuforums.org/showthread.php?p=9072795
>>
>>The links show the output for the Asus Rampage 2 board, not the P6T.
>>atk0110 gets the list of the sensors directly from ACPI, and in your
>>board those readings are not present.
>>
>>Luca
>
> Hi Luca,
> thank you for your asnwer.
> i'm quite sure the board has those informations somewhere because asus (w=
indows
> only) utility can get theme out!

Hum, the DSDT that I have here does not contain those readings; you
might have a different board revision with additional probes.

> Is there a way to "browse" the ACPI looking for them ?

iasl :-)
Or just send me the DSDT (/sys/firmware/acpi/tables/DSDT), I'll take a look.

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
