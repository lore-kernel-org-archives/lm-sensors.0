From: Brad Campbell <brad@wasp.net.au>
Date: Mon, 05 Oct 2009 13:48:59 +0000
Subject: Re: [lm-sensors] it87 sensors need an ACPI driver (2.6.31)
Message-Id: <4AC9F94B.3070701@wasp.net.au>
List-Id: <lm-sensors.vger.kernel.org>
References: <c43b2e150909200120kf87cdc2oabafea8abbf01227@mail.gmail.com> <68676e00909200520s7730b516v4e0d6c17d529d0a7@mail.gmail.com> <4AC939BB.8090600@wasp.net.au> <4AC9B896.9080900@msgid.tls.msk.ru>
In-Reply-To: <4AC9B896.9080900@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Luca Tettamanti <kronos.it@gmail.com>, lm-sensors@lm-sensors.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Michael Tokarev wrote:
> Brad Campbell wrote:
> []
>> Vanilla Kernel 2.6.31.1 fails to load it87 on my machine with the same 
>> messages as posted above.
>>
>> [71916.534278] it87: Found IT8716F chip at 0x290, revision 0
>> [71916.535783] it87: in3 is VCC (+5V)
>> [71916.537239] it87: in7 is VCCH (+5V Stand-By)
>> [71916.538763] ACPI: I/O resource it87 [0x295-0x296] conflicts with 
>> ACPI region IP__ [0x295-0x296]
>> [71916.540365] ACPI: Device needs an ACPI driver
>>
>> In addition, asus_atk0110 loads but leaves no trace in dmesg when loaded.
> 
> try acpi_enforce_resources=lax kernel command-line parameter.

That certainly allows the it87 driver to load and function. I was more interested in seeing if the 
motherboard was able to be supported in the asus driver, but whatever works.

Cheers :)

Regards,
Brad
-- 
Dolphins are so intelligent that within a few weeks they can
train Americans to stand at the edge of the pool and throw them
fish.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
