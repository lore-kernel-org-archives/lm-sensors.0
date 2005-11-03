From: roger@planbit.co.uk (Roger Lucas)
Date: Thu, 03 Nov 2005 00:28:18 +0000
Subject: [lm-sensors] RE: vt8231.c
Message-Id: <20051102232752.C637B12EB5@bluewhale.planbit.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051102092453.47B1712E9E@bluewhale.planbit.co.uk>
In-Reply-To: <20051102092453.47B1712E9E@bluewhale.planbit.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

No problem.  I appreciate the effort you are spending on the code review.

- Roger

-----Original Message-----
From: Jean Delvare [mailto:khali@linux-fr.org] 
Sent: 02 November 2005 20:56
To: Roger Lucas
Cc: Knut_Petersen@t-online.de; LM Sensors
Subject: Re: [lm-sensors] RE: vt8231.c

Hi Roger, Knut,

> > But if I use
> > 
> >     compute fan1 @/9 , @*9
> >     set fan1_min 0
> >     set fan1_div 1
> > 
> > that results in a sensors output of
> > 
> >    fan1:     1324 RPM  (min =    0 RPM, div = 1)          ALARM
>
> I'm not sure exactly how the VT8231 generates its alarms.  I'll have to
look
> into the device spec and see exactly what it does then get back to you.

This means that my suggestion of changing FAN_FROM_REG earlier today
was probably not correct, and FAN_TO_REG should be changed instead:

static inline u8 FAN_TO_REG(long rpm, int div)
{
	if (rpm = 0)
		return 255;
	return SENSORS_LIMIT(1310720 / (rpm * div), 1, 254);
}

static inline long FAN_FROM_REG(u8 reg, int div)
{
	if (reg = 0 || reg = 255)
		return 0;
	return (1310720 / (reg * div));
}

Ideally we should probably handle the fan speed measurement registers
and the low limit registers differently, as 255 means no low limit (0
RPM) but is still a valid speed measurement. However, I am not certain
the benefit is worth the additional code.

Roger: I am in the process of reviewing all your code. This takes some
time so please be patient. I couldn't finish the review today,
hopefully it will be OK tomorrow.

Thanks,
-- 
Jean Delvare

