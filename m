From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:30 +0000
Subject: Set Fan-Speed ?
Message-Id: <3C6E85CD.76160D42@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020213083516.6baa5cc5.redtraxx@web.de>
In-Reply-To: <20020213083516.6baa5cc5.redtraxx@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

echo [0-255] > /proc/sys/dev/sensors/as99127..../pwm[1-2]

Unfortunately this only works if the pwm feature is already enabled.
There is currently no way to enable pwm using the driver.
Of course, this is assuming that the PWM feature is supported
in the as99127f and the registers are the same as the w83* chips.

mds


Volker Gausmann wrote:
> 
> Hi !
> 
> Is it possible to set the fan-speed on the AS99127F chip ?
> I know its a risk to set this parameter, but I have a very noisy fan and I think it's not necessary for the fan to run at 4000RPM when the CPU has a temperature about 30?C.
> 
> I know ASUS won't tell the details of their chips, but an Win-machine its possible to set the speed to the minimum of 2200RPM (Asus-PC-Probe).
> 
> Thanks and regards from Germany ...
> 
> Volker
> 
> --
> --------------------------------------
> Volker Gausmann
> http://home.foni.net/~redtraxx
> ICQ: 78952816
> Open Minds. Open Sources. Open Future.
> --------------------------------------
