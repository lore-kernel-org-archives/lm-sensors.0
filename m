From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 31 Jan 2012 15:12:38 +0000
Subject: Re: [lm-sensors] [w83627ehf] Not all fans are shown (#3)
Message-Id: <20120131161238.2b1d1bd9@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120127145130.GA29746@ericsson.com>
In-Reply-To: <20120127145130.GA29746@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 28 Jan 2012 16:14:35 +0100, CC wrote:
> I wasn't aware that mainboard chips can and do modulate +12V by PWM
> themself. So there's actually *three* methods/modes to drive a fan:
> 
> 1) Voltage regulation ("DC")
> 2) PWM by modulating the +12V line
> 3) PWM by providing a control signal
> 
> In my previous statements, I did assume that "PWM" always means (3).
> Maybe we could adapt the documentation to reflect the situation. I
> guess it's a valid distinction, and you surely wouldn't want another
> smart-ass guy complaining about it.

Adapt which documentation? I wasn't even aware that we documented this
somewhere in the first place.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
