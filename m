From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 15 Dec 2008 22:34:17 +0000
Subject: Re: [lm-sensors] F8000 support added to f71882fg driver,
Message-Id: <4946DB69.1000002@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081215180300.GA6612@rho>
In-Reply-To: <20081215180300.GA6612@rho>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Chuan-kai Lin wrote:
> On Mon, Dec 15, 2008 at 11:16:02PM +0100, Hans de Goede wrote:
>>>  3. The full-speed number seems to record the maximum measured fan
>>>     speed instead of the maximum possible fan speed.
>> So this gets updated by hardware? This is not mentioned anywhere in
>> the dcos, but if that is the case that would be good!
> 
> Appears to be the case.  See previous message attachment: in loaded.txt
> the _full_speed values are higher than in idle.txt.
> 
>>>  4. I cannot change fan speed by altering tempX_auto_pointY_pwm
>>>     values.  However, both the CPU fan and the case fan do speed up
>>>     when the system gets warm.
>> what does cat pwmX_enable give you, if it gives 3, the relevant pwm is
>> in thermostat mode see the documentation I also attached.
> 
> See previous message attachment: they both report 2.
> 

Hmm, can you be so kind as to resend, I already deleted it.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
