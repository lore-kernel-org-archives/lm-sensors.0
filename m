From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:03 +0000
Subject: lm77 on national sc1100
Message-Id: <200407020809.i6289XtV046788@zone3.gcu-squad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1088690691.2862.25.camel@null>
In-Reply-To: <1088690691.2862.25.camel@null>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


>$ sensors-detect
>[...]
>Next adapter: SCx200 ACB1
>Do you want to scan it? (YES/no/selectively):
>Client found at address 0x48
>Probing for `National Semiconductor LM75'... Failed!
>Probing for `National Semiconductor LM77'... Success!
>    (confidence 3, driver `lm75')
>Probing for `Dallas Semiconductor DS1621'... Failed!
>Probing for `Maxim MAX6650/MAX6651'... Failed!
>Probing for `National Semiconductor LM92'... Failed!
>Probing for `National Semiconductor LM76'... Success!
>    (confidence 2, driver `lm92')
>Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!
>[...]
>Driver `lm75' (should be inserted):
>  Detects correctly:
>  * Bus `SCx200 ACB1' (Algorithm unavailable)
>    Busdriver `UNKNOWN', I2C address 0x48
>    Chip `National Semiconductor LM77' (confidence: 3)
>
>Driver `lm92' (may not be inserted):
>  Misdetects:
>  * Bus `SCx200 ACB1' (Algorithm unavailable)
>    Busdriver `UNKNOWN', I2C address 0x48
>    Chip `National Semiconductor LM76' (confidence: 2)

OK, it works :) I'll see if I can improve it enough to grant a
confidence of 4 to the LM77. After all, the detection of the LM75 and
LM77 are being quite reliable now (at a price of an awful complexity,
admittedly). OTOH, the LM76 family isn't and I'm not sure that we will
be able to do much better.

Andras, could you please provide a dump of your chip?
i2cdump 1 0x48 w
i2cdump 1 0x48

Mark, could you temporarily hack your local copy of sensors-detect so as
to pretend that the LM77 can live at 0x4c-0x4f? Then give it a try. I
want to check that your LM75s will not be misdetected as LM77s.

I wonder if unused addresses (0x4-0x7 on LM75, 0x6-0x7 on LM77) will
always return the value of the last existing register (0x3 and 0x05,
respectively), or those of the previously read register. It doesn't
matter much because we read them in order almost all the time, but I'm
curious. And in the latter case (which I consider the most probable) it
would be a powerful mean of identification. Could either of you do some
testing in that direction (by hacking either of sensors-detect, i2cdump
or the lm75 or lm77 drivers).

>Just as a thought: if the kernel is compiled w/o modules,
>/proc/modules does not exist, so initialize_modules_list()
>will fail. Maybe it should just silently return if the
>file does not exist...

Ah, you are using a monolithic kernel? This is interesting. We are almost
never doing, and had several complaints about it not working properly
(but that was long time ago). How is it going for you?

Yes, you're right, we should keep silent if /proc/modules does not
exist. Care to provide a patch that does that? We may even remember and
never propose the user to try and load a module after that.

I think that your choice of having a separate driver for the lm77 is
correct. Both chips are definitely not compatible and there's no point
in having a single driver if there's no code nor logic we can share.

Thanks,
Jean Delvare
