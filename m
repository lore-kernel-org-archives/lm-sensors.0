From: a@gaydenko.com (Andrew Gaydenko)
Date: Thu, 28 Dec 2006 21:22:13 +0000
Subject: [lm-sensors] W83627DHG, steps to use
Message-Id: <200612290022.13346@goldspace.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200612271943.00165@goldspace.net>
In-Reply-To: <200612271943.00165@goldspace.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi, David!

==== On Thursday 28 December 2006 09:59, you wrote: ===...
>
>More information:
>- thread http://lists.lm-sensors.org/pipermail/lm-sensors/2006-December/018438.html
>- message http://lists.lm-sensors.org/pipermail/lm-sensors/2006-December/018443.html
>
...

OK, as for coretemp - will wait. 

I have applied the W83627DHG patch, all sensors works (THANKS!) except for +5V
(it shows something about 0.384V). So, I can stay with CPU temp from W83627DHG.
But what does this sensor show? First CPU temp? Second one? I mean Core 2 Duo.

Another problem is, when I try pwmconfig, I get such error:

Testing pwm control 9191-0290/pwm2 ...
  9191-0290/fan2_input ... speed was 1721 now 1713
/usr/sbin/pwmconfig: line 102: echo: write error: Invalid argument

It is for current SVN tree. So, I don't know a reason why pwm doesn't work - is 
this disabled by BIOS, or is this the script error? I'm not shell guru :-)


Thanks!
Andrew

