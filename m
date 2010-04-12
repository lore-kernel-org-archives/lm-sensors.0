From: Martin Vool <mardicas@gmail.com>
Date: Mon, 12 Apr 2010 16:52:14 +0000
Subject: [lm-sensors] Fancontrol script improvement
Message-Id: <v2i360a8e031004120952zcee44b71l896d64a4ecf88914@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello,

i am writing to you because i want to ask you what do you think of my idea.
Currently i can assign only one temperature sensor to a fan. In my
setup i need to monitor 2 sensors and set the fan speed accordingly to
a single fan.

It should not be very complicated to implement this, and implement it
so that the old configuration is not deprecated, for example:

...
FCTEMPS=3Dhwmon0/device/pwm1=3Dhwmon0/device/temp3_input:hwmon0/device/temp=
1_input
 hwmon0/device/pwm2=3Dhwmon0/device/temp2_input
MINTEMP=3Dhwmon0/device/pwm1E:50=A0 hwmon0/device/pwm2@
MAXTEMP=3Dhwmon0/device/pwm1U:60=A0 hwmon0/device/pwm2U
...
or
...
FCTEMPS=3Dhwmon0/device/pwm1=3Dhwmon0/device/temp3_input
hwmon0/device/pwm1=3Dhwmon0/device/temp1_input
hwmon0/device/pwm2=3Dhwmon0/device/temp2_input
MINTEMP=3Dhwmon0/device/pwm1E hwmon0/device/pwm1P=A0 hwmon0/device/pwm2@
MAXTEMP=3Dhwmon0/device/pwm1U hwmon0/device/pwm1`=A0 hwmon0/device/pwm2U


i personally would prefer the first, since it is more clear on what is goin=
g on.

When the script calculates the speeds it simply has to look what is
the highest RPM required for the monitored sensor.

Since i am not used to program in shellscripts i wanted to know if you
would like to implement this? If not then i would give it a shot, but
the code probably wouldn't be very pretty...

What do you think?


Martin Vool

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
