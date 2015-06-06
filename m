From: Gergely Imreh <imrehg@gmail.com>
Date: Sat, 06 Jun 2015 14:51:56 +0000
Subject: [lm-sensors] Parallella board temperature sensing
Message-Id: <CAJ3iQcr8cSEB_vYYR2_0H-Am0wYstQvtfzHJcVgMsdcWzFn=VA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,

I was checking out what would it take to support lm-sensors on the
Parallella board[1]. It's an interesting little board with a dual core
Xilinx ARM Cortex-A9, an FPGA, and a 16-core Epiphany co-processor.
It's Xilinx XADC sensor used for temperature/voltage sensing does not
seem to be anywhere on the lm-sensors supported device list. Currently
users seem to monitor it through reading the device data directly from
the /sys entries and doing the necessary scaling and conversion (as it
was discussed on the Parallella forums, bash script included[2])

In a nutshell, the data is accessible through
/sys/bus/iio/devices/iio:device0/in_temp0_{raw,offset,scale} files.
There are also 8 voltage readings there that could be extracted.

I'm really happy to do any testing for sure, as well as some
development if there are any pointers how to get started.

Cheers,
   Greg


[1]: https://www.parallella.org/
[2]: https://parallella.org/forums/viewtopic.php?f#&t=930

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
