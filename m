From: marcin.dawidowicz@kontron.pl (Marcin Dawidowicz)
Date: Fri, 24 Nov 2006 18:19:05 +0000
Subject: [lm-sensors] [PATCH] driver for SMSC SCH311x
Message-Id: <200611241919.05709.marcin.dawidowicz@kontron.pl>
List-Id: <lm-sensors.vger.kernel.org>
References: <200607241255.42688.Marcin.Dawidowicz@kontron.pl>
In-Reply-To: <200607241255.42688.Marcin.Dawidowicz@kontron.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Rudolf and Alan,

Here is my patch for SVN lm-sensors repository to add SMSC SCH311x support for 
user space from some time ago. I think, there won't be a big problem to apply 
it to current repository state.

Best regards,
Marcin

Dnia pi?tek 24 listopad 2006 13:31, Rudolf Marek napisa?:
> Hello Alan,
>
> Sorry for the delay.
>
> Alan Pettitt wrote:
> > I have installed your patch for the SCH311x on a Kontron 6012 processor
> > board using Redhat linux 2.6.18. After doing a modprobe I now get:
> >
> > sch311x-isa-0a70
> > Adapter: ISA adapter
> >
> >
> > but no further information. Is there something I am missing ?
>
> Yes you are missing userspace support (the generic support is not yet
> ready). Maybe Marcin will have something? I'm ccing him.
>
> You may access the chip through sysfs interface
> /sys/class/hwmon*/device/...
>
> Rudolf
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors at lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

-- 
Best regards / Mi?ego dnia

Marcin Dawidowicz
 

------------------------------------------------------------------

Kontron East Europe sp. z o.o.
Nowy adres / New address

  03-821 Warszawa Poland
  ul. ?upnicza 17

Tel.:        +48 22  389 84 82

E-MAIL   :  <mailto:marcin.dawidowicz at kontron.pl>
mailto:marcin.dawidowicz at kontron.pl

 "we create digital brains for a more intelligent world"

------------------------------------------------------------------
-------------- next part --------------
A non-text attachment was scrubbed...
Name: sch311x-lm-sensors_SVN.patch
Type: text/x-diff
Size: 13278 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061124/084d3622/attachment.bin 
