From: Rudolf Marek <r.marek@assembler.cz>
Date: Fri, 22 Nov 2013 21:51:20 +0000
Subject: Re: [lm-sensors] ITE it8603e
Message-Id: <528FD1D8.2000605@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAC-0Eqii0d94mPbn=8MoOn9UMP_srC3s5Dt3q45G+GTdo2kptw@mail.gmail.com>
In-Reply-To: <CAC-0Eqii0d94mPbn=8MoOn9UMP_srC3s5Dt3q45G+GTdo2kptw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Khali,
 > I see no good reason to add a separate list for the IT8603E, the list
> is the same as labels_it8721 above except for "+3.3V" which has been
> renamed to "AVCC3" but really that's exactly the same. Let's reuse
> labels_it8721 to optimize the driver size.

OK

>>   		sio_data->beep_pin = superio_inb(IT87_SIO_BEEP_PIN_REG) & 0x3f;
>> +	} if (sio_data->type = it8603) {
>

> This coding style is misleading. Either you have an "else", or you move
> the "if" to the following line. I think you're missing the "else"
> actually, and without it you introduce a big regression in the it87
> driver.

Yes sorry about that. It was somehow overlooked during developement.

> I've make all the suggested changes myself to avoid another round trip.

Great thanks a lot!

> Also I've updated Kconfig as suggested by Guenter. The resulting patch

Yes I did that but forgot to include it in the patch.

> can be seen at:
> http://khali.linux-fr.org/devel/linux-3/jdelvare-hwmon/hwmon-it87-01-add-it8603e-support.patch
> Please let me know if I got anything wrong. Retesting would be
> appreciated, just in case.

I tested that and it is OK. Thank you again for review and help,

Rudolf


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
