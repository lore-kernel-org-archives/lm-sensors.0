From: david.c.hubbard@gmail.com (David Hubbard)
Date: Sat, 04 Mar 2006 21:17:33 +0000
Subject: [lm-sensors] [PATCH] Add fan control support to W83627EHF
Message-Id: <4dfa50520603041317y12ae7d2eu52791b91790006d2@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4409FFA1.7050109@sh.cvut.cz>
In-Reply-To: <4409FFA1.7050109@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

Thanks for posting your work! I'm testing it right now. I have a question:

> pwm[1-4]_enable - this file controls mode of fan/temperature control:
>        * 0 Disabled. In fact the pwm is set to 255
>        * 1 Manual Mode, write to pwm file any value 0-255 (fullspeed)
>        * 2 Thermal Cruise
>        * 3 Smart FAN III

There is another mode, RPM Cruise, in the datasheet. Smart Fan 3 is
only supported by CPUFANOUT0 and CPUFANOUT1. Tell me what you think,
maybe mode 3 should be RPM cruise and mode 4 is either not allowed
(-EINVAL) or for the two fans that allow Smart Fan 3, it turns it on.

That's all until I get through testing,
David

