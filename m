From: Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
Date: Tue, 13 Jan 2009 09:36:16 +0000
Subject: Re: [lm-sensors] [PATCH] GPIO output support for LM93 kernel driver
Message-Id: <496C6090.3050609@teltonika.lt>
List-Id: <lm-sensors.vger.kernel.org>
References: <f967eaa30901120805y5628259co8e58e6568d677f63@mail.gmail.com>
In-Reply-To: <f967eaa30901120805y5628259co8e58e6568d677f63@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Olivier Hochreutiner wrote:
> Hi there,
> 
> I have been using the LM93 kernel driver and I noticed that 'gpio'
> file in sysfs is read-only and that the GPIO pins of the LM93 chip can
> be used as input only.
> I attached a patch that allows to also use GPIO pins as output, by
> simply writing to 'gpio' in sysfs. The patch is against the current
> git revision of the mainstream kernel.
> I did not handle the case where the GPIO pins are used as inputs after
> being used as output (in which case, according to the datasheet, 0s
> should be written to the GPO register, and thus 1s should be written
> to the 'gpio' sysfs file). Also, if some pins are used as inputs and
> others as outputs, then, when writing to the 'gpio' file in sysfs, the
> pins used as inputs should be set to 1 (so that the corresponding bits
> in the GPO register are set to 0).
> 
> Comments are welcome.

IMO gpiolib would be better and more generic solution instead of creating
some custom sysfs entry...

> Best regards,
> 
> Olivier Hochreutiner
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
