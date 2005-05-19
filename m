From: maurice@harddata.com (Maurice Hilarius)
Date: Thu, 19 May 2005 06:25:22 +0000
Subject: Tyan S4882 support complete
Message-Id: <6.1.2.0.2.20041115183340.0931a510@mail.harddata.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041115231910.2bd44311.khali@linux-fr.org>
In-Reply-To: <20041115231910.2bd44311.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

With regards to your message at 03:19 PM 11/15/04, Jean Delvare. Where you 
stated:
>Hi all,
>
>Just wanted to let you know that Linux 2.6.10-rc2 is out, and had full
>support for the National Semiconductor LM63 and the specific SMBus
>multiplexing needed by the S4882. After some discussions and changes to
>my code, my drivers were accepted and merged. Thus the S4882 is
>officially supported by Linux 2.6 since today.
>
>I've also commited all my changes to lm_sensors CVS, so hardware
>monitoring on the S4882 is also fully publicly supported on 2.4 kernels
>since yesterday.
>
>Enjoy :)
Thanks Jean.
As they say "You rock!"

Further comments below..

>The only missing thing is the SMBus multiplexing driver autoloading. You
>will have to manually load the i2c-amd756-s4882 driver to get
>multiplexing to work. ...
>Unfortunately, developing DMI data gathering for x86_64 is a somewhat
>tricky task, not the kind that can be done remotely, and we do not have
>an x86_64 system available for kernel development (as far as I know at
>least.)
>
>If Tyan or Harddata (or possibly both together) is interested in me
>adding the autoload feature, please consider the donation of an x86_64
>system. It wouldn't have to be full featured and shiny new, even an
>older system would do providing it's x86_64 and working fine. It would
>also be a nice way to reward and support the lm_sensors project in
>general, and support linux on the x86_64 architecture too (if I own such
>a machine myself, it better be well supported.)

OK, let's explore this.
Do you need an S4882 based system, or **just** and X86-64 machine?
for example, would a machine built around an S2850 ( single Opteron 14x 
socket 940 CPU board)
do the trick?

If Tyan will donate the board, we will donate the box, CPU, RAM, etc..
If we did this, probably the easiest way would be for Tyan to send us the 
board, we build and set up the machine, and forward it to Jean.

Brandon & Alex, what do you think of this idea?

Thanks!


With our best regards,

Maurice W. Hilarius       Telephone: 01-780-456-9771
Hard Data Ltd.               FAX:       01-780-456-9772
11060 - 166 Avenue        mailto:maurice@harddata.com
Edmonton, AB, Canada      http://www.harddata.com/
    T5X 1Y3

