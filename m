From: pjkonweb@gmail.com (Prakash J K)
Date: Wed, 01 Nov 2006 21:32:01 +0000
Subject: [lm-sensors] lm_sensors trigger pc buzzer beeping continuously
Message-Id: <5251aaf50611011320k48fa70d5n5ac7a5a7e1ca047c@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <5251aaf50609051620r683eb75fm95d738c444ff86da@mail.gmail.com>
In-Reply-To: <5251aaf50609051620r683eb75fm95d738c444ff86da@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

hello,
Sorry for the long delay.i checked by moving it87.ko to my /root dir and now
no beeping and no sensors output.

> prakash at ubuntu:~$ sensors -s
> Can't access procfs/sysfs file
> Unable to find i2c bus information;
> For 2.6 kernels, make sure you have mounted sysfs and libsensors
> was compiled with sysfs support!
> For older kernels, make sure you have done 'modprobe i2c-proc'!
>
but if i keep it87.ko intact and remove the package lm_sensors in
debian/ubuntu,there is no beeping...and i can access sensors reading through
"hardinfo" utility.
                                                thanks for your patience
                                                  Prakash J K

On 10/18/06, Rudolf Marek <r.marek at assembler.cz> wrote:
>
> Prakash J K wrote:
> > Hi,
> > thanks for ur interest.i tried unloading it87 module and again it beeps
> > for the current session.BIOS is up2date.
> >                                 regards,
>
> Ok and now please try following:
>
> 1) remove/delete/move the it87.ko
> 2) powerdown the system, unplug from power
> 3) boot linux
>
> Does it make the beeps too? Or only when you load or later unload the
> driver?
>
> Thanks,
> Rudolf
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061102/927740e7/attachment-0001.html 
