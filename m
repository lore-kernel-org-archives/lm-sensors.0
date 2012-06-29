From: Michael Zintakis <michael.zintakis@googlemail.com>
Date: Fri, 29 Jun 2012 12:11:04 +0000
Subject: Re: [lm-sensors] Fintek f71882fg ACPI conflict
Message-Id: <4FED9B58.3090102@googlemail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4FEA4C10.2060904@googlemail.com> <20120627171505.GB12712@roeck-us.net> <4FEB90A8.8050901@googlemail.com> <20120628014548.GA15994@srcf.ucam.org> <4FEC3CDF.7050901@googlemail.com> <20120628144035.36ac75a0@endymion.delvare> <4FEC53DD.8050403@googlemail.com> <20120628152754.2ab6697a@endymion.delvare> <4FED3EB3.4000602@gmail.com>
In-Reply-To: <4FED3EB3.4000602@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Jean Delvare <khali@linux-fr.org>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, lm-sensors@lm-sensors.org


> In this case, however, where the BIOS does in fact expose an ACPI 
> thermal zone and relies on AML code to perform fan control, etc. then 
> it seems quite likely that it's not safe to access the same hardware 
> monitoring controller while AML code may be doing so at the same time. 
> The only way I can see that you could make ACPI "leave the hardware 
> monitoring chip alone" is to either have the kernel block its accesses 
> (quite likely breaking all fan/temperature control) or disable ACPI 
> entirely (in this case the BIOS likely either leaves the fan control 
> in "run at max speed always" mode or uses SMIs to gain control where 
> needed to adjust fan speeds, which causes the same concurrent access 
> problem).
Interesting and it sort-of confirms my "findings" from yesterday's bout 
I've had with ACPI.

When I completely deactivate ACPI ("acpi=off" in the kernel command 
line), there is obviously no more conflict errors reported, but what I 
also discovered is that the problem I've had with the fans not able to 
start (when they are at standstill initially) is not there any more!

When I forcefully stop a fan by "echo 1 > pwmX" (you were right, when I 
deactivate any sort of temperature, fan & voltage management in BIOS and 
ACPI is OFF, the fans run at maximum speed), then select "automatic" 
management and pass control over to the f71882fg driver, when the 
temperature rises enough for the fan to start spinning, but not enough 
to push it over the "safe" minimum speed threshold, this raises an alarm 
event (fanX_alarm gets triggered) and the f71882fg driver then, 
completely by itself, pushes the fan to its maximum speed momentarily 
and the fan starts spinning - exactly the behaviour I was "simulating" 
with my bash script.

Obviously, the pwm value then gets decreased by the driver below the 
"safe" minimum speed limit causing the fan to stop again and trigger the 
alarm again, but I could easily overcome this problem by setting 
pwmX_auto_point5_pwm to keep the fan at safe speed once it is started.

When I do this, everything is running absolutely flawlessly - I've ran 
this for 3 hours, putting various load levels on the system to see how 
it reacts to temperature changes and the f71882fg driver does a superb 
job without the need for my bash script!

The only downside is, if one could call it that, that I have to setup 
everything under /sys/class/hwmon/hwmonX/driver/ manually - from 
"pwmX_auto_pointY_temp/pwm" to "fanX_full_speed" and the like, but I 
could live with that, no problem.

Now, it seems to me that ACPI is the culprit, has been all along, and I 
need to get rid of the conflict in order to achieve that level of 
operation - without this I am going to struggle! Turning ACPI off 
completely is not an option for me at all - in such a case one 
noticeable effect is that my multi-core CPU doesn't get recognised (it 
is only recognised as a single-core) and the SMP-part of the kernel is 
not functioning. That, clearly, is unacceptable to me.

So, is there a way to make ACPI "leave my hardware monitoring chip 
alone" without fully deactivating it? I don't care if all 
fan/temperature control is going to "break" - I think the f71882fg chip 
driver is perfectly capable of doing that without the "help" from ACPI. 
So, is there any way - even with brute-force hacking of the kernel - to 
prevent ACPI from getting anywhere near my hwmon chip (please say "yes" 
:-) )?

Last couple of queries regarding the f71882fg driver:

What is the purpose of "pwmX_auto_channels_temp" (I have default values 
of 4, 2 and 1 for my 3 fans), "pwmX_auto_pointY_temp_hyst" and 
"pwmX_interpolate"? I think the latter could be a boolean value whether 
the f71882fg driver should interpolate values between the temperature 
points in order to determine fan speed, but can't be sure.

Also, is it possible to select which temperature reading should be used 
when selecting the fan speed? By default, to determine fan1's speed, 
temp1 is used and pwm1 value is then manipulated. Is it possible to 
instruct the driver to use a different sensor reading for the 
temperature in order to determine the speed of the fan?
 

MZ

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
