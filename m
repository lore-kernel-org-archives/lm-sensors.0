From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:32 +0000
Subject: Ticket 892: No sensors found!
Message-Id: <3CE024F4.B7BA9CC5@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3CE21B56@epostleser.online.no>
In-Reply-To: <3CE21B56@epostleser.online.no>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

w83781d isn't getting initialized which we have other reports on 
(when it is compiled-in) and don't know the reason.
Don't see a startup message for i2c-viapro either which is bad.
sensors-detect should run w/o modules but I guess we have to fix that.
As you can see we have some work to do with no-module kernels.
The only workaround for you at this point is to enable modules.

Arne Vidar Sj?n?st wrote:
> 
> Ref: Ticket 892
> 
> The kernel dont support modules, thats why I have patched this into the
> kernel. Everything built in, no modules. Its running Slackware 7.
> 
> Kernelsetup:
> [Y] I2C support
> [Y] I2C mainboard interfaces
> [Y]   VIA Technologies, Inc. VT596A/B, 686A/B, 8233 (NEW)
> [Y] I2C device interface
> [Y] I2C /proc interface (required for hardware sensors)
> 
> [Y] Hardware sensors support
> [Y]   Winbond W83781D, W83782D, W83783S, W83627HF, Asus AS99127F
> 
> dmesg:
> i2c-core.o: i2c core module version 2.6.3 (20020322)
> i2c-dev.o: i2c /dev entries driver module version 2.6.3 (20020322)
> i2c-proc.o version 2.6.3 (20020322)
> No other things regarding sensors
> 
> sensors:
> No sensors found!
> 
> sensors-detect:
> Can't access /proc/modules! at /usr/local/sbin/sensors-detect line 991.
> 
> lsmod:
> Module                  Size  Used by
> lsmod: QM_MODULES: Function not implemented
