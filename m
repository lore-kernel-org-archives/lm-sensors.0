From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 02 Jul 2008 10:31:58 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon (c7temp): new driver for VIA C7 CPU
Message-Id: <20080702123158.18e5d307@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0806191620g1f001306r5d26cb67ed12d44b@mail.gmail.com>
In-Reply-To: <191fb4ca0806191620g1f001306r5d26cb67ed12d44b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

On Thu, 19 Jun 2008 16:20:34 -0700, Juerg Haefliger wrote:
> New driver to support temperature and voltage sensors embedded inside
> the VIA C7 CPU.
> 
> Sergio: Can you please test this patch?
> 
> Signed-off-by: Juerg Haefliger <juergh at gmail.com>

I had a colleague of mine (Cc'd, hi Wilken :)) test your driver. The
voltage part appears to work, we saw in0 change from 0.96 V at 800 MHz
to 1.00V at 1000 MHz. However the temperature is always reported as 0
degrees C. We dumped the value of eax after the cpuid() call and it's
0x0.

Does this mean that Wilken's CPU lacks the thermal diode? Or could this
be a bug in your driver? For reference, the CPU in question is:

processor	: 0
vendor_id	: CentaurHauls
cpu family	: 6
model		: 10
model name	: VIA Esther processor 1000MHz
stepping	: 9

If you need anything, just ask me or Wilken directly.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
