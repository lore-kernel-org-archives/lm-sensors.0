From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:32 +0000
Subject: Winbond 792 source codes for lm_sensor
Message-Id: <20050124195346.7a59acc5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE0673FD@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE0673FD@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Chunao,

> > - Why is the vol_factor array exposed to /proc? Isn't this only for
> >   debugging?
> >   These shouldn't be exposed to the user. If the user needs to
> >   adjust computation it can be done in /etc/sensors.conf.
>
> In the requirements of our customer: the motherboard vendor should
> have the permission to modify the voltage factor, so I expose it into
> /proc. I write it with the reference of our Windows version, the
> Windows version GUI supply a interface to modify the voltage factor,
> but it need authentication, That's to say, NOT all of the user can
> modify it.

As I understand it, these factors account for the resistors placed on
the motherboard, which are needed to bring all voltages back into the
measurable 0V-4V range. Am I correct?

Is so, this does indeed not belong to the driver and has to be removed.
Such computation has always been performed in userspace by libsensors,
for all drivers. The reason for this is that libsensors can do almost
any mathematical operation, not only apply factors. As a matter of fact,
the W83792D chip needs more than factors for -5V and -12V (an additional
offset is needed), and unless I am missing something, your driver
doesn't handle that. There is also a kernel development policy which
states that conversions should always be moved outside of the kernel
when possible, and this is exactly what libsensors is there for.

The "authentification" issue you are talking about is unrelated. The
root user (and only him/her) will possibly change the voltage factors,
regardless of the method (/proc or libsensors) - not the "motherboard
vendor".

As a side note, I'm already not certain that restricting the access to
these values in the Windows world makes sense, but I am certain that it
makes no sense in the Linux world. The goal of open-source tools is to
give the users the possibility to change whatever them want to, and
certainly not to put restrictions to what they are allowed to do. And at
any rate there is no room for such a restriction mechanism in the
libsensors framework.

As a side note, the voltage factors were used in your driver for the
measured values only, not for the limits (unless I missed something) so
it was not working correctly anyway.

> And I will need your help at that time. For example, to add 792
> related codes into the script program "sensors-detect" because I know
> very few about Perl. :-)

The sensors-detect script is supposed to already identify the W83792D
chip (since lm_sensors 2.9.0). If it doesn't, let us know and we'll fix
it.

What will obviously require an update though is libsensors. I suppose
you will provide a patch together with the driver itself? Seems hard to
properly test the driver and especially its interaction with "sensors"
without this.

Thanks,
-- 
Jean Delvare
http://khali.linux-fr.org/
