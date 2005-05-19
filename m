From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:29 +0000
Subject: Problem with i2c-amd756
Message-Id: <20020206132531.A22363@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


I can't say specificly for your case, but it's often the case that an
I2C chip on the bus gets confused and locks up the bus when a
'collision' occurs.  Usually, it's impossible to clear the condition
w/o power cycling the computer.  If this is the case for you, then
it's not likely that anything can be done from the i2c-amd756 driver
to fix this condition.  Is this a problem which you can reproduce, or
is this a fairly random event?  If it is random, then it's likely that
a little noise on the I2C bus and a sensitive I2C chip is causing the
trouble.


Phil


On Thu, Feb 07, 2002 at 09:50:52PM +0100, Daniel Sobe wrote:
> Generally spoken, the lm_sensors package works very good for me. But one
> day it happened that after high load the application (wmlm) didn't show
> any correct numbers or voltages and the computer refused to reboot until
> power was switched off and on again. Later when grepping through the
> syslog I found following message where I'm not sure it relates to it but
> it might be:
> 
>  Jan 24 14:13:43 localhost kernel: i2c-amd756.o: SMBus collision!
> 
> In the sourcecode I found following:
> 
> 		printk("i2c-amd756.o: SMBus collision!\n");
> 		/* TODO: Clear Collision Status with a 1 */
> 
> and
> 
> /*
>    Supports AMD756 and AMD766.
>    Note: we assume there can only be one device, with one SMBus
> interface.
> */
> 
> Now my question: Can this collision really happen or was it just bad
> luck? Is there any way to improve the i2c-amd756 driver since AMD
> doesn't offer datasheet anymore?
> 
> Any help would be appreciated.
> 
> Daniel
> 
> -----------------------------------------------------------------
> 
> output of dmesg:
> 
> i2c-core.o: i2c core module
> i2c-amd756.o version 2.6.2 (20011118)
> i2c-core.o: adapter SMBus AMD7X6 adapter at 50e0 registered as adapter
> 0.
> i2c-amd756.o: AMD756/766 bus detected and initialized
> i2c-proc.o version 2.6.1 (20010825)
> w83781d.o version 2.6.2 (20011118)
> i2c-core.o: driver W83781D sensor driver registered.
> i2c-core.o: client [W83782D chip] registered to adapter [SMBus AMD7X6
> adapter at 50e0](pos. 0).
> i2c-core.o: client [W83782D subclient] registered to adapter [SMBus
> AMD7X6 adapter at 50e0](pos. 1).
> i2c-core.o: client [W83782D subclient] registered to adapter [SMBus
> AMD7X6 adapter at 50e0](pos. 2).
> 
> output from lsmod:
> 
> i2c-dev                 3744   0 
> ppp_deflate            39968   0  (autoclean)
> bsd_comp                4016   0  (autoclean)
> ppp_async               6256   0  (autoclean)
> ppp_generic            14704   0  (autoclean) [ppp_deflate bsd_comp
> ppp_async]
> slhc                    4608   0  (autoclean) [ppp_generic]
> NVdriver              820128  14  (autoclean)
> parport_pc             25504   1  (autoclean)
> lp                      6176   0  (autoclean)
> parport                24928   1  (autoclean) [parport_pc lp]
> rtc                     5536   0  (autoclean)
> 8139too                12864   1  (autoclean)
> serial                 44048   0  (autoclean)
> analog                  7520   0  (unused)
> joydev                  6816   0  (unused)
> input                   3392   0  [analog joydev]
> es1371                 27120   1 
> soundcore               3568   4  [es1371]
> ac97_codec              9680   0  [es1371]
> gameport                1552   0  [analog es1371]
> ide-scsi                7568   0 
> ncr53c8xx              51648   0  (unused)
> scsi_mod               80480   2  [ide-scsi ncr53c8xx]
> ide-cd                 26608   0 
> cdrom                  28896   0  [ide-cd]
> ide-floppy             11360   0 
> w83781d                17104   0  (autoclean) (unused)
> i2c-proc                6176   0  (autoclean) [w83781d]
> i2c-amd756              3200   0  (autoclean)
> i2c-core               12944   0  [i2c-dev w83781d i2c-proc i2c-amd756]
> 
> output from i2cdetect:
> 
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: XX XX XX XX XX XX XX XX 08 XX XX XX XX XX XX XX 
> 10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
> 20: XX XX XX XX XX XX XX XX XX XX XX XX XX UU XX XX 
> 30: 30 31 XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
> 40: XX XX XX XX XX XX XX XX UU UU XX XX XX XX XX XX 
> 50: 50 51 XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
> 60: 60 61 XX XX XX XX XX XX XX 69 XX XX XX XX XX XX 
> 70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
> 
> 
> 
> kernel: 2.4.17
> board: Shuttle AI61
> sensors: 2.6.2
> IC on Board: W83782D

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
