From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: Request for driver
Message-Id: <20040119230205.7ebf2710.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4006AFFA.80500@mart.ck.ua>
In-Reply-To: <4006AFFA.80500@mart.ck.ua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I'm sorry but I'm not a system programmer. I even not a C programmer.
> I've done few modification of w83627hf.c file (see attacment). So,
> at now, I can load w83627hf.o module. I even see some "files" under 
> /proc/.../sensors/:
> # ls /proc/sys/dev/sensors/w83637hf-isa-0290/
> alarms  fan1  fan3     in0  in2  in4  in6  in8   pwm2     sensor2 
> temp1 
>   temp3  vrm
> beep    fan2  fan_div  in1  in3  in5  in7  pwm1  sensor1  sensor3 
> temp2 
>   vid
> 
> But I see no output from "sensors" command (I've copied a section in
> sensors.conf from w83627hf section) and "sensors -s" produces errors:
> # sensors
> w83637hf-isa-0290
> Adapter: ISA adapter
> Algorithm: ISA algorithm
> # sensors -s
> Error: Line 1862: Unknown feature name
> ..
> 
> So, I can be helpful only as a tester.

I don't think so. You're not that far from a first result.

You hacked the driver in the correct way, except that you did define a
new "kind" for the w83637hf. There's nothing wrong with that, but this
means that you would also have to hack the library so that it knows
about that new kind.

A much quicker way would be to not define that new kind, i.e. treat the
637 exactly as if it was a 627. If the chips are compatible enough, this
could give interesting results (although I can't guarantee anything,
I've not read the data sheet for more than 2 minutes).

So I'd suggest that you hack the driver again, and only add the new
device ID this time. Assign the same kind as for a 627hf, and you should
start getting results from sensors. You can undo your changes to
sensors.conf, BTW.

Also, even if sensors doesn't work, you can "cat" the files in /proc and
see if values make sense (don't forget that values may need some
arithmetics applied to them as shown in sensors.conf).

Let us know how it goes.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
