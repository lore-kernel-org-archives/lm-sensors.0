From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:42 +0000
Subject: Latest cvs -> Compile Errors
Message-Id: <3DDFB0B5.7804E20@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200211161710.26342.amalysh@web.de>
In-Reply-To: <200211161710.26342.amalysh@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> 
> (Resending again, looks like there were problems with stimpy yesterday
> evening and still this morning.)
> 
> > Khali, this probably breaks your doc-features tool.
> It did, and I workaround it. I don't know how we can generate a doc for
> bmcsensors since it has some kind of dynamic allocation for the
> ctl_table, if I understand it well. I tool a look at the code and I
> couldn't see how the proc names will be generated. It seems that
> bmcsensors_proc_name_pool is used uninitialized (or is there something I
> don't know about kmalloc?) I'd appreciate some explanations, for my
> personal knowledge if not to find a way to generate the doc.

The bmcsensors module queries the BMC (onboard controller), via the IPMI
protocol,
for SDR's (sensor data records).
It looks for 4 types of sensors: temperature, voltage, current, and fan.
Then it kmallocs a /proc table (bmcsensors_dir_table) and some extra
space
to generate and store the /proc names (bmcsensors_proc_name_pool).
It generates the /proc names according to the sensor type, starting with
1.
(e.g. in1, in2, in3, temp1, temp2, fan1, fan2, fan3, fan4).
Then it registers bmcsensors_dir_table in the usual manner.

So the bmcsensors module doesn't have any limit on the number of each
type of sensor.
The limit is in lib/chips.c, where there's no way to do a dynamic
struct sensors_chip_feature bmcsensors[]? So we have to fill that
struct with the max expected of each sensor type.
Since it's static, there's really no reason to have x+1, x+2, ...
SYSCTL definitions. We might as well just go back to the old way.
