From: "Constantine A. Murenin" <mureninc@gmail.com>
Date: Sun, 24 Jan 2010 07:58:32 +0000
Subject: Re: [lm-sensors] Status of Andigilog asc7621 driver submitted by
Message-Id: <f34ca13c1001232358i37ee31e7g7ec72e121c906d80@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3f9a31f41001230952g6321c47bq9baf5dcfdfaf5b59@mail.gmail.com>
	 <4B5B38C1.5080109@hhs.nl>
	 <3f9a31f41001232105l58d36ffdp8d06231f524a98ec@mail.gmail.com>
	 <f34ca13c1001232144t75ef8d1dqaffbe86b0c8407e7@mail.gmail.com>
	 <3f9a31f41001232223r4fc79debrd40c2987c11364c2@mail.gmail.com>
In-Reply-To: <3f9a31f41001232223r4fc79debrd40c2987c11364c2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Jaswinder Singh Rajput <jaswinderlinux@gmail.com>
Cc: Hans de Goede <j.w.r.degoede@hhs.nl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org

2010/1/24 Jaswinder Singh Rajput <jaswinderlinux@gmail.com>:
> Hello,
>
> On Sun, Jan 24, 2010 at 11:14 AM, Constantine A. Murenin
> <mureninc@gmail.com> wrote:
>> On 24/01/2010, Jaswinder Singh Rajput <jaswinderlinux@gmail.com> wrote:
>>> Many new Intel Motherboards are coming with this chip, if we complete
>>> =A0this driver then it will be great.
>>
>> Really?
>
> Yes, http://www.intel.com/products/server/motherboard/index.htm?iid=3Dmbd=
_body+sv_all
>
>
> I have checked with Intel=AE Workstation Board WX58BP :

http://www.intel.com/support/motherboards/server/wx58bp/sb/CS-030316.htm
=AB
Spares, Parts List and Configuration Guide [PDF]
File Name: WX58BP Config Guide 1.0.pdf
Size: 76,709 bytes
Date: April 2009
File Revision: 1.0
=BB

The board seems old, or, at least, old enough to be designed when
Andigilog still existed. :-)


> Now follows a summary of the probes I have just done.
> Just press ENTER to continue:
>
> Driver `to-be-written':
> =A0* Bus `SMBus I801 adapter at 2000'
> =A0 =A0Busdriver `i2c_i801', I2C address 0x2e
> =A0 =A0Chip `Andigilog aSC7621' (confidence: 5)
>
> Driver `coretemp':
> =A0* Chip `Intel Core family thermal sensor' (confidence: 9)
>
> Note: there is no driver for Andigilog aSC7621 yet.
> Check http://www.lm-sensors.org/wiki/Devices for updates.
>
> Do you want to overwrite /etc/sysconfig/lm_sensors? (YES/no): YES
> Starting lm_sensors: loading module coretemp =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
[ =A0OK =A0]
> Unloading i2c-dev... OK
>
> You can also check with other intel motherboards.
>
>> My understanding was that the company, Andigilog, no longer
>> seem to exist since at least a couple of months ago (I don't recall
>> the exact dates their web-site was taken down without any notice, but
>> currently the domain has no information regarding semiconductors
>> whatsoever [0]). =A0It would therefore seem somewhat strange if Intel
>> was still using these chips in their recent designs =97 do you have some
>> concrete examples? =A0Anyone has any more details regarding Andigilog
>> and their products?
>>
>
> http://who.is/whois/andigilog.com/
>
> These motherboards are build in Taiwan, China. I have no idea that how
> they are getting these chips but you can see them in your latest Intel
> motherboards ;-)

Well, a better link would have been:

http://web.archive.org/web/*/http://www.andigilog.com/

:-)

C.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
