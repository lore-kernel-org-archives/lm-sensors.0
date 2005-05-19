From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:32 +0000
Subject: Winbond 792 source codes for lm_sensor
Message-Id: <20050124201827.5ebc0cc2.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE0673FD@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE0673FD@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Chunhao,

> I have one question when I read the document
> lm_sensors/doc/developers/new_drivers:
> > * Be sure that SYSCTL and ALARM definitions in the driver are
> >   bracketed by the special comments so that the
> >   kernel/include/sensors.h file, which is generated
> >   automatically, contains your definitions.
> >   (for chip drivers only)
> The kernel/include/sensors.h should be generated automatically,
> But I don't know how to generate it. I have bracketed the SYSCTL and
> ALARM definitions in the driver w83792d.c, Could you give me the
> method of generating it?

You simply have to place the w83792d.c in kernel/chips and add a line
for it in kernel/chips/Module.mk:

KERNELCHIPSTARGETS += $(MODULE_DIR)/w83792d.o

Add that line right after the one for smbus-arp and it should be OK.

-- 
Jean Delvare
http://khali.linux-fr.org/
