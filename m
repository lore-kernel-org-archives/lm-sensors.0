From: Luca <kronos.it@gmail.com>
Date: Fri, 31 Aug 2007 19:48:02 +0000
Subject: Re: [lm-sensors] [PATCH lm_sensors-2.10.4][RESEND] sensors-detect:
Message-Id: <68676e00708311248l68964f26k88801476b3da5398@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070831171637.2c343762@hyperion.delvare>
In-Reply-To: <20070831171637.2c343762@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 8/31/07, Gaston, Jason D <jason.d.gaston@intel.com> wrote:
> >-----Original Message-----
> >From: Jean Delvare [mailto:khali@linux-fr.org]
> >Hi Jason,
> >
> >For next time: patches to lm-sensors should be sent to the lm-sensors
> >list, not the i2c list.
>
> Should we update the MAINTAINERS file in the base kernel to reflect this?
>
> I2C SUBSYSTEM
> P:      Jean Delvare
> M:      khali@linux-fr.org
> L:      i2c@lm-sensors.org
> T:      quilt http://khali.linux-fr.org/devel/linux-2.6/jdelvare-i2c/
> S:      Maintained

The correct entry in under "HARDWARE MONITORING". I2C really is the
core i2c code.

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
