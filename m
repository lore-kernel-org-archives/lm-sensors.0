From: Rudolf Marek <r.marek@assembler.cz>
Date: Tue, 18 Mar 2014 08:39:02 +0000
Subject: Re: [lm-sensors] IT8620E/IT8623E vs. IT8603E
Message-Id: <53280626.1040306@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20140316120945.4dc8b28c@endymion.delvare>
In-Reply-To: <20140316120945.4dc8b28c@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

The IT8623E is same asi IT8603E. Asus has no information about IT8620E.

Do you have any testers for IT8603E?

Thanks
Rudolf

On 16.3.2014 12:58, Rudolf Marek wrote:
> Hi Jean,
>
>  > Recently you added support for the IT8603E chip to the it87 driver.
>> Since then we had a number of requests to support the IT8620E and the
>> IT8623E as well, for which we do not have a datasheet.
>>
>> Do you happen to know if there is some degree of compatibility between
>> these 3 chips?
>
> No idea, but I guess they are quite similar. Maybe we can check regs 58h and 5bh
> in HWM block. It should be 90h and 12h.
>
> I will try to contact the Asus and we will see.
>
> Thanks
> Rudolf
>
>>
>> Thanks,
>>
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
