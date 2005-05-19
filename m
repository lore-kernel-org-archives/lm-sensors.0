From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Thu, 19 May 2005 06:25:26 +0000
Subject: Regardding Ticket #: 1791
Message-Id: <25381867041212024810ea70e6@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <000001c4ad5f$6d5d83c0$843f4853@jonathan>
In-Reply-To: <000001c4ad5f$6d5d83c0$843f4853@jonathan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jonathan,

You can try the bmcsensors driver - this should be able to read the
temperatures (amongst other sensors) from the motherboard. For Kernel
2.4.x the bmcsensors driver is included in the standard lm_sensors,
however for kernel 2.6.x a port has been made but is not included in
the standard lm_sensors (kernel). See
http://bmcsensors-26.sourceforge.net/ for more information.

Let me know how it goes - I need more feedback on how well (or not)
the ported driver works on different IPMI implementations.
Unfortunatley i havn't got around to updating the path to apply to
more recent (2.6.8+) kernels, but I will get around to this shortly. I
want to incorporate any changes made to the 2.4 version before doing
so and that takes time (the patch probably applies cleanly/with easy
modifications to more recent kernels itself).

Yani


On Thu, 14 Oct 2004 09:12:24 +0200 (CEST), Jean Delvare
<khali@linux-fr.org> wrote:
> 
> >I sent you information about where to download source code for a IPMI
> >bus. I have a question, Should I be able to get the temperature readings
> >through lm_sensors if the driver works or am I supposed to find another
> >program?
> 
> I don't know. All I vaguely know is that we have drivers named i2c-ipmi,
> i2c-ipmb and bmcsensors which I think can be used to access the IPMI
> data. I have no idea how well they work nor whether you need additional
> stuff to get them to work. I never had to use this myself.
> 
> Jean
> 
>
