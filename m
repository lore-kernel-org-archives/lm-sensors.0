From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:35 +0000
Subject: w83782d question
Message-Id: <20020628120415.I9322@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.21.0206281611570.1247-100000@xeon12.aei-potsdam.mpg.de>
In-Reply-To: <Pine.LNX.4.21.0206281611570.1247-100000@xeon12.aei-potsdam.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi, the best documentation is probably the code and the datasheet.
The alarms are read like this (kernel/chips/w83781d.c):

                data->alarms                     w83781d_read_value(client,
                                       W83781D_REG_ALARM1) +
                    (w83781d_read_value(client, W83781D_REG_ALARM2) << 8);
                if ((data->type = w83782d) || (data->type = w83627hf)) {
                        data->alarms |                            w83781d_read_value(client,
                                               W83781D_REG_ALARM3) << 16;
                }

Here are some constants from the top of the file:

#define W83781D_REG_ALARM1 0x41
#define W83781D_REG_ALARM2 0x42
#define W83781D_REG_ALARM3 0x450        /* not on W83781D */

The datasheet should break out what the bits mean.  From
kernel/include/sensors.h, we have them as meaning: 

#define W83781D_ALARM_IN0 0x0001
#define W83781D_ALARM_IN1 0x0002
#define W83781D_ALARM_IN2 0x0004
#define W83781D_ALARM_IN3 0x0008
#define W83781D_ALARM_IN4 0x0100
#define W83781D_ALARM_IN5 0x0200
#define W83781D_ALARM_IN6 0x0400
#define W83782D_ALARM_IN7 0x10000
#define W83782D_ALARM_IN8 0x20000
#define W83781D_ALARM_FAN1 0x0040
#define W83781D_ALARM_FAN2 0x0080
#define W83781D_ALARM_FAN3 0x0800
#define W83781D_ALARM_TEMP1 0x0010
#define W83781D_ALARM_TEMP23 0x0020     /* 781D only */
#define W83781D_ALARM_TEMP2 0x0020      /* 782D/783S */
#define W83781D_ALARM_TEMP3 0x2000      /* 782D only */
#define W83781D_ALARM_CHAS 0x1000

To see an example of how these are applied, look at the function:

void print_w83781d(const sensors_chip_name *name)

in prog/sensors/chips.c



Phil


On Fri, Jun 28, 2002 at 04:20:40PM +0200, Nana Sadowsky wrote:
> 
> 
> Dear support,
> 
> could you explain to (stupid) me what the number in
> /proc/sys/dev/sensors/alarms is about ?
> 
> >From reading the w83782d datasheet, I suppose it's a bitmask representing
> the bits set in the 3 hardware status registers, but I couldn't find any
> proof of this assumption anywhere in the documentation. 
> If so, in what order are they represented ?
> 
> (Better still, where is this stuff documented ?)
> Thanks in advance for any hints.
> 
> Best,
> Nana
> 
> =================================
> 
> sadowsky@aei-potsdam.mpg.de	(work)	++49 30 48496689 (home)
> nana.sadowsky@kiez.net		(home)	0179 7840245 (mobile)
> 
> =================================

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
