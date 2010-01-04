From: Gabriel C <nix.or.die@googlemail.com>
Date: Mon, 04 Jan 2010 14:09:17 +0000
Subject: Re: [lm-sensors] Status/support for Linux HECI from Intel? (for
Message-Id: <1820d69d1001040609j6c0b169w38694c33af3fa686@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.DEB.1.10.0812300700410.11356@p34.internal.lan>
	 <4964DB3E.6080908@intel.com>
	 <alpine.DEB.1.10.0901071142200.29147@p34.internal.lan>
	 <1231356111.6648.2.camel@maxim-laptop> <49937CDF.10307@frugalware.org>
	 <alpine.DEB.1.10.0902121236120.19381@p34.internal.lan>
	 <1820d69d1001040551k26cfd925q4ada6b226740ac30@mail.gmail.com>
	 <alpine.DEB.2.00.1001040851490.29475@p34.internal.lan>
In-Reply-To: <alpine.DEB.2.00.1001040851490.29475@p34.internal.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: Gabriel C <crazy@frugalware.org>, Maxim Levitsky <maximlevitsky@gmail.com>, Dan Williams <dan.j.williams@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, Andriy Gapon <avg@icyb.net.ua>

2010/1/4 Justin Piszcz <jpiszcz@lucidpixels.com>:
>
>
> On Mon, 4 Jan 2010, Gabriel C wrote:
>
>> 2009/2/12 Justin Piszcz <jpiszcz@lucidpixels.com>:
>>>
>>>
>>> On Thu, 12 Feb 2009, Gabriel C wrote:
>>>
>>>> Maxim Levitsky wrote:
>>>>
>>>>> On Wed, 2009-01-07 at 11:42 -0500, Justin Piszcz wrote:
>>>>>>
>>>>>> On Wed, 7 Jan 2009, Dan Williams wrote:
>>>>>>
>>>>>>> Justin Piszcz wrote:
>>>>>>>>
>>>>>>>> The HECI interface would allow lm_sensors developers to grab the
>>>>>>>> temperatures off the chips on the board.
>>>>>>>>
>>>>>>>> From 2005(?)-2008 there was some chatter about supporting it but it
>>>>>>>> never
>>>>>>>> seemed to happen, is there any eventual planned support for
>>>>>>>> supporting
>>>>>>>> Intel's HECI interface or if the user wants to see the
>>>>>>>> temperatures/voltages just buy a different motherboard with an ITE
>>>>>>>> I/O
>>>>>>>> controller?
>>>>>>>>
>>>>>>>> I have a couple DG965WH boards and it would be nice to see the
>>>>>>>> temperature of the chipset etc without having to reboot into the
>>>>>>>> BIOS.
>>>>>>>>
>>>>>>> Hi Justin,
>>>>>>>
>>>>>>> I am not up to date on the progress in this area, but perhaps this
>>>>>>> site
>>>>>>> (http://www.openamt.org/) has what you are looking for?
>>>>>>>
>>>>>>> Regards,
>>>>>>> Dan
>>>>>>>
>>>>>> Yeah that is the site-- however, will it ever get merged? =A0I have =
not
>>>>>> heard anything about it for a year or so.
>>>>>
>>>>> Nope, the heci is just a controller, but we need a way to tell that
>>>>> controller to show us the temperature data.
>>>>> But intel hasn't released the QST sdk, and probably never will.
>>>>>
>>>>> Sad,
>>>>
>>>>
>>>> Well I found this interesting thread about :
>>>>
>>>>
>>>>
>>>> http://software.intel.com/en-us/forums/manageability-software-developm=
ent/topic/54851/
>>>>
>>>> It looks like the QST SDK already exists and is planned to be released=
..
>>>> (
>>>>
>>>> =A0http://software.intel.com/en-us/forums/manageability-software-devel=
opment/topic/54851/reply/74068/
>>>> )
>>>
>>> I volunteer to test any patches if/when they are created after the SDK =
is
>>> released.
>>>
>>
>>
>> Again me .. Well the SDK is *still* not released .. =A0The Intel folks
>> said back in August :
>>
>> "The latest word is that the SDK is being prepared for approval but it
>> is contingent upon an upcoming platform release."
>>
>> ( whatever that means )
>>
>>
>> Anyway Andriy Gapon has posted on lm-sensors some nice tool to read
>> the sensors output ( thx :) )
>>
>> (http://lists.lm-sensors.org/pipermail/lm-sensors/2009-October/026830.ht=
ml)
>>
>> Today I'm out from hospital so I've decided to quick hack this tool
>> and make it work on Linux.
>>
>> Here the output from my DQ45CB mobo:
>>
>> crazy@thor:~/INTEL/QST/Li$ sudo ./heci-qst
>> CPU =A0Temp: =A0 =A0 =A056.00 =A0 =B0C
>> MB =A0 Temp: =A0 =A0 =A031.14 =A0 =B0C
>> ICH =A0Temp: =A0 =A0 =A067.37 =A0 =B0C
>> MCH =A0Temp: =A0 =A0 =A066.00 =A0 =B0C
>> CPU =A0Fan: =A0 =A0 =A0 1080 =A0 =A0RPM
>> INL =A0Fan: =A0 =A0 =A0 1202 =A0 =A0RPM
>> OUTL Fan: =A0 =A0 =A0 288 =A0 =A0 RPM
>> +12 =A0Volts: =A0 =A0 11.965 =A0V
>> +5 =A0 Volts: =A0 =A0 5.021 =A0 V
>> +3.3 Volts: =A0 =A0 3.316 =A0 V
>> MCH =A0Vccp: =A0 =A0 =A01.122 =A0 V
>> CPU1 Vccp: =A0 =A0 =A01.125 =A0 V
>>
>> Justin I know is not based on released SDK of Intel but maybe you
>> still want to do some tests ?:)
>
> Hi,
>
> I upgraded my system and have a new board now, I do have another system t=
hat
> uses the same board (DG965WH) if you have a patch/URL with the software I
> can give it a run.

The file was attached ..

Just do:

gcc -o heci-qst heci-qst-linux.c

>
> Justin.

Gabriel

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
