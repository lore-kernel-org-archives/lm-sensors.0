From: Christian Hohnstaedt <chohnstaedt@innominate.com>
Date: Thu, 16 Aug 2007 08:08:50 +0000
Subject: Re: [lm-sensors]
Message-Id: <20070816080850.GE10132@tweety>
List-Id: <lm-sensors.vger.kernel.org>
References: <87ekb9s3tn.wl%info@wore.ma.cx>
In-Reply-To: <87ekb9s3tn.wl%info@wore.ma.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Aug 15, 2007 at 09:28:58PM +0200, Jean Delvare wrote:
> Hi Christian,
> 
> > ---
> >  drivers/hwmon/ad7418.c    |    2 +-
> >  drivers/hwmon/asb100.c    |    4 ++--
> >  drivers/hwmon/ds1621.c    |    2 +-
> >  drivers/hwmon/lm75.c      |    2 +-
> >  drivers/hwmon/lm75.h      |    2 +-
> >  drivers/hwmon/w83627ehf.c |    2 +-
> >  drivers/hwmon/w83627hf.c  |    6 +++---
> >  drivers/hwmon/w83781d.c   |    2 +-
> >  8 files changed, 11 insertions(+), 11 deletions(-)
> 
> Test results:
> 
> ds1261: all OK
> w83627ehf: temp1 not OK (can't write negative limits)
Wasn't catched by searching for TEMP_TO_REG -> fixed.

> w83627hf: all OK
> w83781d: all OK
> 
> Please fix the w83627ehf temp1 case and resubmit.
I additionally found this issue in

drivers/hwmon/adm1021.c
drivers/hwmon/lm77.c
drivers/hwmon/lm93.c

and fixed them appropriately.
Patch follows, please test it.

Christian Hohnstaedt

-- 
Christian Hohnstaedt
Software Engineer

Innominate Security Technologies AG  /protecting industrial networks/
tel: +49.30.6392-3285 fax: +49.30.6392-3307
Albert-Einstein-Strasse 14, D-12489 Berlin, Germany
http://www.innominate.com

Register Court: AG Charlottenburg, HR B 81603
Management Board: Joachim Fietz, Dirk Seewald
Chairman of the Supervisory Board: Edward M. Stadum

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
