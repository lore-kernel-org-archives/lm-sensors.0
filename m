From: Antonio Marcheselli <antonio.marcheselli@gmail.com>
Date: Mon, 17 Jul 2023 12:47:58 +0000
Subject: label when space in sensor name
Message-Id: <CADMb=zn_1O_t=tYtAeAyhDdkX-ckFYvZHFhZUOvzwSWUhrp-iA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I'm trying to add a label to my CPU sensors so they make more sense
when listed by sensors.

My CPU core temps are called "Core 0" and "Core 1"

How do I account for the space in the configuration file? I tried
something but I get errors.

Here is what I tried which did not work.

chip "coretemp-*"
        label Core 0 "CPU Core 0"
        label Core 1 "CPU Core 1"
chip "w83627dhg-*"
        label fan1 "System Fan"
        label fan2 "CPU fan"

Thanks!
