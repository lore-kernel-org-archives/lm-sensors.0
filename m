From: Mihai Tanasescu <mihai@duras.ro>
Date: Sat, 04 Apr 2009 16:16:40 +0000
Subject: Re: [lm-sensors] Quick question Winbord w83627ehf - BIOS vs manual
Message-Id: <49D787E8.60107@duras.ro>
List-Id: <lm-sensors.vger.kernel.org>
References: <49D78077.6090505@duras.ro>
In-Reply-To: <49D78077.6090505@duras.ro>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Mihai Tanasescu wrote:
> Hello guys,
>
>
> I'm having some "theoretical" dilemmas here and wanted some help if 
> possible.
>
> I'm having an Asus P5B Deluxe MB with a W83627DHG chip.
>
> Prob:
>
> If I enable in Bios, Q-Fan Control (Thermal Cruise in normal 
> language:) ), then do the settings in /sys like:
>
> /sys/devices/platform/w83627ehf.656/pwm1_enable
> pw2_enable
> etc
> pwm1_target
> pwm1_tolerance
>
> get set automatically based on what is read by the BIOS ? or do I have 
> to set them ?
>
> Also, if I set them, do they overwrite the BIOS settings ?
>
> I'm a bit confused here and would be grateful if you could shed some 
> light on the subject.
>
>
>
> Thanks,
> Mihai
>

I partially found the answer to this...

The settings are read from BIOS.

Half the question still remains...if I change anything manually there 
with echo "value" > /sys/... then does it take effect and override the 
BIOS setting ?





_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
