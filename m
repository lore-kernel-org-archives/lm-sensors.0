From: Kent Larsson <kent.larsson@gmail.com>
Date: Wed, 25 Sep 2013 16:01:47 +0000
Subject: [lm-sensors] Problems with set in5_max in nct6776-isa-0290
Message-Id: <CALmZR2NiQ3yhvYzmRz49YW7S=2RmkeTyRGdb3rPqqnNJZ57-Ow@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I want to change in5_min and in5_max. First I check that I have the right
value names:

    sensors -u
    ...
    in5:
      in5_input: 2.040
      in5_min: 1.224
      in5_max: 2.040
      in5_alarm: 1.000
    ...

Yes it looks that way. I try to set them in my configuration file

    test@debianstick:~$ cat /etc/sensors.d/custom
    chip "nct6776-isa-0290"
            ...
            set in5_min 1.224
            set in5_max 2.540

There seem to be no problem interpreting the configuration file, but only
in5_min takes affect

    test@debianstick:~$ sudo sensors -s
    test@debianstick:~$ sensors
    ...
    nct6776-isa-0290
    Adapter: ISA adapter
    ...
    in5:            +2.04 V  (min =  +1.22 V, max =  +2.04 V)  ALARM
    ...

A reboot does not help. I suspect that this is a bug, but I hope that I am
the bug. :-)

It's not important, but I thought I'd share it with the list in case
someone else stumbles over the same problem.

Best regards, Kent
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
