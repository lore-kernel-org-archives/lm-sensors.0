From: Alexander Kiel <alexanderkiel@gmx.net>
Date: Thu, 15 Nov 2007 11:08:21 +0000
Subject: Re: [lm-sensors] PWMconfig problem with Asus P5B Deluxe / Winbond
Message-Id: <1195124901.6275.7.camel@alex>
List-Id: <lm-sensors.vger.kernel.org>
References: <4dfa50520711142226r2e6d1c3fy229e05d4ca43d032@mail.gmail.com>
In-Reply-To: <4dfa50520711142226r2e6d1c3fy229e05d4ca43d032@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

> I am one of them. I have CC'ed your email to the lm-sensors mailing
> list. Can you kindly include the CC in your future replies? That is
> the correct mailing list to post this discussion on.

Ok. Thanks. I will CC.

> I recall seeing this problem before. The list archives have a similar
> problem for an MSI 975x board:
> http://lists.lm-sensors.org/pipermail/lm-sensors/2007-April/019545.html
> http://lists.lm-sensors.org/pipermail/lm-sensors/2007-April/019566.html
> 
> For that board, the solution was that the Intel ICH7 chip controlled
> the fan using a GPIO pin. 

No. This isn't the same problem I have. He uses the 4-pin connector. I
only use two case fans on normal 3-pin connectors which are controllable
by Speedfan under Windows.

> But he wasn't getting a "Permission denied"
> error. Can you please double-check that you have permission to write
> to the files? I'm not going to quiz you on your setup (SELinux? or a
> problem in /etc/sudoers?) -- but I'll take your word for it that it's
> a driver error and not a sysfs permissions error.

Good point. I'm so stupid. I do a sudo echo "0" > pwm1. So echo "0" is
executed as root but the file writing not. Ok as root it works. I can
write something into actually pwm4 and the fan stops.

But pwmconfig does not work either. It says:

------------------------------------------------------------
Found the following PWM controls:
   hwmon0/device/pwm1
hwmon0/device/pwm1_enable stuck to 1
Failed to set pwmhwmon0/device/pwm1 to full speed
Something's wrong, check your fans!
------------------------------------------------------------

And  if I try a echo "0" > pwm1_enable I get "bash: echo: write error:
Invalid argument". echo "2" works. So I think this is one for you. 


Best Regards and thanks for help
Alex


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
