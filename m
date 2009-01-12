From: "David Hubbard" <david.c.hubbard@gmail.com>
Date: Mon, 12 Jan 2009 05:59:33 +0000
Subject: Re: [lm-sensors] "echo 0 > pwm2" does NOT stop fan
Message-Id: <4dfa50520901112159j1afc156cuf0a20bd49114b6a8@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <676459746@web.de>
In-Reply-To: <676459746@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jens,

On Sun, Jan 11, 2009 at 1:44 PM, Jens Gottstein <ruena@web.de> wrote:
> Hi there,
>
> since many years I use fancontrol on many systems - its a great software - thanks a lot.
>
> On my new system it does not stop my CPU-fan - just slows the fan down.
>
> I have a ASUS p5k-v with a w83627ehf, Ubuntu 8.10 (and 8.04) with a intel boxed fan (4-pins on the cable to the fan),
>
> uname -a :
>  Linux 2.6.27-9-generic SMP Thu Nov 20 21:57:00 UTC 2008 i686 GNU/Linux
>
> I did:
> cd /sys/devices/platform/w83627ehf.656/
> echo 255 > pwm2
> The fan is at full speed (cat fan2_input yields 2556)
>
> echo 0 > pwm2
> The fan does NOT stop, it just goes slow (cat fan2_input yields 1010)
>
> pwmconfig and fancontrol have the same problem.
>
> How can I stop the fan completely?
>
> I also tried the "Thermal Cruise mode", but this does not stop the fan, too.
>
>
> The content of the files in  /sys/devices/platform/w83627ehf.656/
>
> cat pwm2: 0
> cat pwm2_enable: 1
> cat pwm2_min_output: 1
> cat pwm2_mode: 1
> cat pwm2_stop_time: 1000
> cat pwm2_target: 60000
> cat pwm2_tolerance: 10000
>
> I am looking forward to your answers
>
> Thanks in advance
>
> ruena

You probably can't stop the fan completely. Can the BIOS stop the fan
completely? With a 4 pin fan, the fan does not depend on the output of
the sensors chip and can have a fixed minimum speed.

David

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
