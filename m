From: Brendan Heading <brendanheading@gmail.com>
Date: Mon, 31 Aug 2015 12:19:37 +0000
Subject: Re: [lm-sensors] compilation under musl
Message-Id: <CA+BsyQ5XTbovy2+pr-OsospJjbwy8vOZuinwxnMNBn_egxo7kQ@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CA+BsyQ7oUSF73bHio+L9pZGTTzsYbWmSVifgXTR_4zRrABShMA@mail.gmail.com>
In-Reply-To: <CA+BsyQ7oUSF73bHio+L9pZGTTzsYbWmSVifgXTR_4zRrABShMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

>> It's a long time since glibc 2.0.1 was released - 1997. Accordingly,
>> it seems to make little sense at this stage to try to retain
>> compatibility with very old libcs - so maybe it should be removed
>> entirely as per the following patch ? :
>>
>> http://git.alpinelinux.org/cgit/aports/plain/main/lm_sensors/musl-fix-in=
cludes.patch?id=FEce1d19448dbd3a56fd8ac70443116187141848
>>
>> Is there any chance that this patch could be considered for inclusion
>> in the main lm-sensors tree ?
>
> Agreed. Patch committed with further cleanups (moving <sys/...>
> includes to the top of the list):
> http://www.lm-sensors.org/changeset/6314
>
> Thanks for your contribution.

Thanks Jean!

Brendan

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
