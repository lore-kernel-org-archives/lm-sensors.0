From: Rainer Koenig <Rainer.Koenig@ts.fujitsu.com>
Date: Wed, 20 Oct 2010 07:17:56 +0000
Subject: Re: [lm-sensors] Driver for SMSC SCH5627 needed
Message-Id: <4CBE97A4.3060704@ts.fujitsu.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4CBD8E44.8070909@ts.fujitsu.com>
In-Reply-To: <4CBD8E44.8070909@ts.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Juerg,

Juerg Haefliger schrieb:
>> I have a board that has a SMSC SCH5627 chip on it. sensors detect report
>> "unknow chip SMSC 0xc601".
>> Where can I get a driver for this chip?
>>    =20
>
> First we need a datasheet. Then we can figure out if we already have a
> driver that supports a similar device and could be easily extended. No
> datasheet usually means no driver.
>  =20
I perfectly understand that. So we used our contacts to SMSC to ask them
for a chip documentation that is not under NDA. Didn't get an answer yet,
but still hoping.
> What board model/vendor is this? Dell machine?
>  =20
The board is a D2984 board used in the ESPRIMO E5645 from Fujitsu
Technology
Solutions. Data sheet is here:
http://docs.ts.fujitsu.com/dl.aspx?idO300628-7547-44b6-ac82-172ebae232c1

Best regards
Rainer

--=20
Dipl.-Inf. (FH) Rainer Koenig
Project Manager Linux Clients
Dept. TSP WPS R&D SW OSE

Fujitsu Technology Solutions
B=C3=BCrgermeister-Ullrich-Str. 100
86199 Augsburg
Germany

Telephone: +49-821-804-3321
Telefax:   +49-821-804-2131
Mail:      mailto:Rainer.Koenig@ts.fujitsu.com=20

Internet         ts.fujtsu.com
Company Details  ts.fujitsu.com/imprint.html


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
