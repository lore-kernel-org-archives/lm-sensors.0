From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 12 Aug 2008 08:59:19 +0000
Subject: Re: [lm-sensors] New style driver for w83781d?
Message-Id: <20080812105919.4475b55a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4899A4F7.70201@grandegger.com>
In-Reply-To: <4899A4F7.70201@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Wolfgang,

On Tue, 12 Aug 2008 10:55:58 +0200, Wolfgang Grandegger wrote:
> We need support for the MON35W42 on an embedded MPC8544 board, which 
> seems to be compatible with the w83782d. There are more issues, e.g. the 
> early ISA bus probing of the existing driver hangs the system. Maybe i2c 
> probing should be done first!?

If both interfaces are available, we want to use the ISA one, because
it's much faster, so it must be registered first.

What could be done though would be disabling the ISA interface
altogether on architectures where it isn't supported (in particular
PPC.) This shouldn't be too difficult. If you write a patch doing this,
I'll be happy to review it. Affected drivers would be w83781d and lm78.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
