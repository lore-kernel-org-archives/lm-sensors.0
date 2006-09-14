From: david.c.hubbard@gmail.com (David Hubbard)
Date: Thu, 14 Sep 2006 04:13:20 +0000
Subject: [lm-sensors] w83627ehf-isa-0290 CPU fan rpm: wrong value
Message-Id: <4dfa50520609132113x3f385247y6d89665b49f5c2bb@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <loom.20060908T163738-492@post.gmane.org>
In-Reply-To: <loom.20060908T163738-492@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Simone,

This is a hardware problem that has no easy solution. I believe you
have fans with three pins and three wires. (If the fan that is giving
you the wrong value is a four-wire fan, then this must be something
else.) Three-wire fans get an RPM count while the power is being
rapidly turned on and off. It can cause this kind of behavior.

Hope this helps,
David

On 9/8/06, simone marchi <simone.marchi at ilc.cnr.it> wrote:
> Dear all,
> I've a problem with that sensors about CPU fan RPM value reported.
> My motherboard is a Asus A8V-E SE.
> I use SuSE 10.1. (2.6.16.21-0.13-default)
>
> The sensors command report sometimes a correct value (~2200rpm)
> and other time a wrong value (~140rpm).
> I've seen that the multiplier of the fan (fan2_div for me)
> switch between 4 and 64.
> I tried to force manually the value to 4 by this command:
>
> echo -n "4" > /sys/bus/i2c/devices/9191-0290/fan2_div
> but I've got a "permission denied" (I ran the command as root)
>
> If I list that file I got that result:
> -r--r--r-- 1 root root 0 2006-09-08 16:43
>             /sys/bus/i2c/devices/9191-0290/fan2_div
>
> So, I can't modify that value.
> I've tried to chmod the fan2_div, but I can't chage the value yet.
>
> I tried also with a more recent kernel (2.6.18-rc6) but
> I got the same error
> (with new kernel I can monitoring, in addition, the voltages)
>
> Does anyone help me?
>
> Thank you
> Ciao simone
>
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors at lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>

