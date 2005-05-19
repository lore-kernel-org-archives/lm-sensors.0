From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:42 +0000
Subject: [PATCH] updated it87 for kernel 2.6 - Part1
Message-Id: <1077008514.4031d8824b712@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040216231514.61a84c5e.komoriya@paken.org>
In-Reply-To: <20040216231514.61a84c5e.komoriya@paken.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

According to Takeru KOMORIYA <komoriya@paken.org>:

> I agree with you. I was feeling something strange with INVALID.
> I think it's better to change "invalid" in sensors program(patch is
> attached).

Correct, except that now, a really invalid value (i.e. different from
0,
2 and 3) will be silently ignored. I agree that, if the driver is
written correctly, this should not possibly happen. Still, an extra
check doesn't cost much and could help us trap problems later. I'll
correct this.

> Also, documentation for it87 should be changed.
> -----
>   To change sensor x to a thermistor, 'echo 2 > sensorx'
>   where x is 1, 2, or 3.
>   To change sensor x to a thermal diode, 'echo 3 > sensorx'.
> - Any other value is invalid.
> + Give 0 for unused sensor.
> ----

Correct again, except that "Any other value is invalid" should be kept.
I'll handle that too.

> Definition of sysfs files already exist in kernel2.6 source and
> works for me...

Aha, correct :) I swear I checked wether they were there or not, and
did
not see them! Incredible.

> Oh, I was in confusion! Sorry for my rush patch.
> Please just ingore my first patch which contains useless code.

I guess you refer to the additional chunk in it87_update_client? I
don't
really get why you say it is useless. I would keep that code. Our
general policy is not to do any supposition as to wether some values
don't change in chips (such as limits, and in this case sensor types).
We have seen cases where these "constant" values *were* changing,
probably because the BIOS is accessing the chip in our back. So,
reading the sensor types in it87_update_client sounds like the right
thing to do (although I agree that in most case it should be safe not
to do so).

> My proposal with attached new patch is:
>  1. delete temp_type option because it can be set at runtime

OK.

>  2. change the value for thermal diode to be compatible with
> 'sensors' program

OK. Strange it wasn't correct in the first place.

>  3. add some comments for temperature types

OK. Good idea.

>  4. Change copyright mark of (c) to (C)

OK.

I still would like set_sensor to fail (return -1) if an attempt to
write
an invalid value (i.e. different from 0, 2 and 3) is made. This
basically means adding the following lines:

	if (val = 3)
	    data->sensor |= 1 << nr;
	else if (val = 2)
	    data->sensor |= 8 << nr;
+	else if (val != 0)
+	    return -1;

Unless you have an objection, of course.

Please resubmit a patch including the requested changes, or explain me
why you should not. BTW, don't worry about resubmitting patches. This
is how things work and this is perfectly normal :) This is the only way
we can ensure that the code that goes into the kernel is the best we
can collectively think of.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
