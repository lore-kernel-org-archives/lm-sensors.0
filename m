From: Rudolf Marek <r.marek@assembler.cz>
Date: Wed, 08 Aug 2007 20:52:19 +0000
Subject: Re: [lm-sensors] Questions about LPC and HW monitor IC drivers
Message-Id: <46BA2D03.9040205@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <5628d8010708050658m7116d3daud9d7450d85da5294@mail.gmail.com>
In-Reply-To: <5628d8010708050658m7116d3daud9d7450d85da5294@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

dave jones wrote:
> On 8/7/07, Rudolf Marek  wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>>> LPC is Winbond W83697UF, thanks.
>> Hmm this chip does not seem to have hardware monitoring caps? Are you sure it is
>> right one? Perhaps the chip is connected elsewhere? Maybe an i2c bus driven by GPIO?
> 
> Oops, sorry, I thought you meant LPC. The hw monitoring chip is
> Winbond W83L786NR.
> That chip was already supported in lm-sensors? Thanks.

No there is not. Maybe it is more or less compatible with something, this must
be checked first.

Rudolf
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGui0D3J9wPJqZRNURAiVCAJ0aykxKPMSOh1PtEcBemZWQNsel3wCgr0k6
ERUjrn6uadEDrXfwT8HOr48=9hOU
-----END PGP SIGNATURE-----

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
