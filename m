From: rene.mayrhofer@gibraltar.at (Rene Mayrhofer)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: vt1211 fan speed control
Message-Id: <3F956350.30207@gibraltar.at>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F8C6A50.5080604@gibraltar.at>
In-Reply-To: <3F8C6A50.5080604@gibraltar.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Mark Studebaker wrote:
> the first is the speed 0-255 and the second is the enable 0|1.
> After writing a 1 to the second value you should be able to change the
> first value
> in subsequent writes.
I've now tried
echo 128 1 > /proc/sys/dev/sensors/vt1211-isa-6000/pwm1
echo 0 1 > /proc/sys/dev/sensors/vt1211-isa-6000/pwm1
echo 0 > /proc/sys/dev/sensors/vt1211-isa-6000/pwm1

But cat /proc/sys/dev/sensors/vt1211-isa-6000/pwm1 returns "255 1" every 
time.

best regards,
Rene
