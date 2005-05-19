From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:43 +0000
Subject: RFC adding special interfaces to sysfs?
Message-Id: <20050316000059.4802896a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <g0l431lg0hrj7msln8smiiah4566i21nhd@4ax.com>
In-Reply-To: <g0l431lg0hrj7msln8smiiah4566i21nhd@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> adm1026 uses analog_out so that's fine.

But lm87 uses aout_output and pcf8591 uses out0_output. The later is the
one which fits best in our current naming scheme, as redundant as it
might sound.

Also, it might make sense to just name is pwm0 as the suggested use for
the analog output is to control a fan. That's what we do for the
W83627THF IIRC. Ideally we would have names the pwm files something like
"fan_control" in the first place, so as to focus on the function instead
of the technology, but that's a bit late now.

-- 
Jean Delvare
