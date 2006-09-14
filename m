From: simone.marchi@ilc.cnr.it (simone marchi)
Date: Thu, 14 Sep 2006 09:26:44 +0000
Subject: [lm-sensors] w83627ehf-isa-0290 CPU fan rpm: wrong value
Message-Id: <45092054.7030009@ilc.cnr.it>
List-Id: <lm-sensors.vger.kernel.org>
References: <loom.20060908T163738-492@post.gmane.org>
In-Reply-To: <loom.20060908T163738-492@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

David Hubbard ha scritto:
> Hi Simone,
> 
> This is a hardware problem that has no easy solution. I believe you
> have fans with three pins and three wires. (If the fan that is giving
> you the wrong value is a four-wire fan, then this must be something
> else.) Three-wire fans get an RPM count while the power is being
> rapidly turned on and off. It can cause this kind of behavior.
> 
> Hope this helps,
> David
> 

Hi David,
thank you for your support!
My fan has three pens and three wires. I'm using the bundled fan with my
athlon64 3800+.
I've tried to do a simple (dangerous) hack of w83627ehf source code:
I've substitute all occurence of
w83627ehf_read_value(client, W83627EHF_REG_FANDIV1)
with the vale 4 (that works fine for me).
I know that can be very dangerous because I'm not kernel expert!
But it works fine!

So, I also tried to patch my kernel (2.6.18-rc6) with
gregkh-i2c-hwmon-w83627ehf-add-pwm-support.patch
to gain fancontrol also.
With this patch I can successfully controll my fan and get correct value
for rpm fan speed.

A simple report about fancontrol:
the pwmconfig configurator fails sometime and it says "no correlation".
But, if I try other times, it works fine and I can get fan control (with
pleasure :) )
The Q-fan2 Bios feature (by Asus) must be enabled or disabled ?

thank you
ciao simone




