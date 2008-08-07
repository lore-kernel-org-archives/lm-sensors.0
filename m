From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Thu, 07 Aug 2008 07:31:28 +0000
Subject: Re: [lm-sensors] Getting an alarm even with values between min/max
Message-Id: <489AA4D0.6010506@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <489AA0CF.4010509@medizinische-genetik.de>
In-Reply-To: <489AA0CF.4010509@medizinische-genetik.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Marc Muehlfeld wrote:
> Hello.
> 
> I run lm_sensors 2.6.5 on a Redhat 7.2 machine (it's a server for a legacy 
> application).
> 
> Nothing changed on the OS for ~3 years and I'm unsure, why I get an alarm 
> since a few days on VCore1/VCore2 even the values are in the range:
> 
> w83627hf-i2c-0-2c
> Adapter: SMBus AMD75x adapter at 80e0
> Algorithm: Non-I2C SMBus adapter
> #2 VCore1: +1.55 V  (min =  +1.44 V, max =  +1.76 V)       ALARM
> #2 VCore2: +1.60 V  (min =  +1.52 V, max =  +1.68 V)       ALARM
> 
> What causes this?
> 

Given that this setup has worked without alarms before, chances are pretty big 
that those ALARMS are real, IOW the powersupply on your motherboard for the CPU 
is starting to fail (bad elco's ?). An ALARM gets set when the voltage gets 
outside the allowable window and then *stays set* even if the voltage returns 
to normal. It gets cleared the first time you read it.

So I think the following is happening:
1) voltage briefly goes outside window, the w83627hf sets its alarm flag
2) you run sensors, voltage has returned to normal but the ALARM flag that was
    set gets reported now (and normally also cleared)

You could try running sensors in quick succession, if this is an intermediate 
failure, the ALARM should not be present on the second run. (But their might be 
some bug causing it to stay set, thats some pretty old software you're running 
there).

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
