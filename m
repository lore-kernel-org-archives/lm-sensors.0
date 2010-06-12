From: Jelle de Jong <jelledejong@powercraft.nl>
Date: Sat, 12 Jun 2010 10:45:10 +0000
Subject: Re: [lm-sensors] ITE IT8721F chipset support?
Message-Id: <4C136536.6010909@powercraft.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Jean Delvare wrote, on 12-06-10 11:37:
> Manual fan speed control isn't available on Asus desktop boards that
> implement ATK0110, and probably never will. I fear you chose the wrong
> board for the job, sorry.

Thank you for the information and your help on the #lm-sensors irc
channel.

The real solution would be that the asus_atk0110 module would be able
to set the PWM values of the iTE chipset. I understeand that the
ATK0110 is a proprietary solution of ASUS. Could anybody contact ASUS
and request for specification of the ATK0110 and IT8721F else they
start losing more customers.

I am going to switch to an other vendor and bought a Gigabyte
GA-890GPA-UD3H with an iTE IT8720. Hopefully this will workout better.

I also tried the acpi_enforce_resources=lax and used modprobe it87
force_id=0x8720 this shows pwm input controls but non of them
responded with pwmconfig, seems the pwm controls are not compatible.

With kind regards,

Jelle de Jong

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
