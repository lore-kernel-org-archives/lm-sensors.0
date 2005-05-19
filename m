From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:40 +0000
Subject: lm-sensors are out of control !
Message-Id: <qSJt3pYk.1109757551.0808190.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <3948f2f205030118272afd83f0@mail.gmail.com>
In-Reply-To: <3948f2f205030118272afd83f0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Dimitris,

> I have been using lm-sensors on Debian for long time and they have
> been working great.  Today i noticed that they display the wrong
> temperature as you will see below.  I have booted in Windows and my
> temp. monitoring program says CPU is 36C . It never goes beyond 45C..
> I then entered in my BIOS to check for temps and the BIOS too says
> 36C.  In fact lm sensors used to display 36-40C always.
>
> Well, today for no reason when i run sensors i get these temps :
>
> sensors
> as99127f-i2c-0-2d
> (...)
> M/B Temp:    +35 C  (high =    +0 C, hyst =   -96 C)
> CPU Temp:  +83.0 C  (high =  +120 C, hyst =  +100 C)
> temp3:      -1.0 C  (high =  +160 C, hyst =  +150 C)
> (...)
> CPU 83C!!! This is not right .
> (...)
> What could be causing it to display wrong temps?

I suspect you are using 2.6 kernels and upgraded recently.

From the early days of AS99127F support, temp2 and temp3 have been
reporting half the temperature values they should have, for no reason
that I could find. In order to present valid temperatures in
"sensors", the default libsensors configuration file would multiply
them by 2:

chip "as99127f-*"
(...)
   compute temp2 @*2, @/2
   compute temp3 @*2, @/2

Some times ago I decided to sanitize this and fixed both the w83781d
driver (both lm_sensors and Linux 2.6) and the libsensors default
configuration file. So if you moved to a recent 2.6 kernel but dit not
update your libsensors configuration file (/etc/sensors.conf), the
result you obtain was expected.

All you have to do is edit /etc/sensors.conf and delete the compute lines
for as99127f's temp2 and temp3.

If your board required different compute lines before (not just the
multiplication by 2), you have to adjust them manually, not delete them.
Alternatively you can simly fetch the updated default configuration file
here, and start from there:
http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/etc/sensors.conf.eg

Thanks,
--
Jean Delvare
