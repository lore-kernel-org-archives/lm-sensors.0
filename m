From: =?iso-8859-1?Q?Bj=F6rn_Gerhart?= <oss@extracloud.de>
Date: Mon, 14 May 2012 21:21:37 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] hwmon: (it87) Create voltage attributes only if voltage is enabled
Message-Id: <C559C0E5-C41E-4C3E-B981-A3556465C34E@extracloud.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1336530714-26615-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1336530714-26615-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Guenter,

Am 11.05.2012 um 21:15 schrieb Bj=F6rn Gerhart:
> Hi @ll,
>=20
> Am 11.05.2012 um 15:38 schrieb Guenter Roeck:
>> On Fri, May 11, 2012 at 05:23:52AM -0400, Jean Delvare wrote:
>> [ ... ]
>>>=20
>>>>> So my personal guess is that this bit switches VIN7 to the internal
>>>>> source just as with the other chips.
>>>>>=20
>>>> Hmmm ... no idea what I should do. Play it safe or assume this is an e=
rror
>>>> in the data sheet ? I tend towards playing safe, but not too much.
>>>> Guess I am waiting for someone to convince me otherwise...
>>>=20
>>> I would not skip VIN7 until we know more. People will never report
>>> about missing 5VSB monitoring, but they will report if 5VSB looks wrong.
>>>=20
>>> Do we have any tester for the IT8783F yet? What you could do for now is
>>=20
>> Bjoern Gerhart has been testing it quite extensively. I don't recall
>> what they do with VIN7, though.
>>=20
> Yes, I have an IT8783F hw configuration with voltage in7 connected to 1.1=
V nominal. I can give it a re-test with the latest patches applied on begin=
ning of next week against kernel 2.6.32. Then I can also ask if my hw colle=
agues have an idea about the pin 91 mystery.
>=20
In our design, the IT8783F's Pin 91 is defined as VIN7, and likewise bit2 o=
f index 0x2C is 1.
As I'm not yet used to git: which would be the easiest way to get the it87 =
with all patches integrated for kernel 2.6.32 for testing purposes? On your=
 github site, I didn't find the appropriate entry for the patches you sent.=
..

Bj=F6rn


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
