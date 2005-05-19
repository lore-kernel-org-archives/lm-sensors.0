From: grant_nospam@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:43 +0000
Subject: RFC adding special interfaces to sysfs?
Message-Id: <i27f31hv11srtidvll40dbqf6be8ljp9kr@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <g0l431lg0hrj7msln8smiiah4566i21nhd@4ax.com>
In-Reply-To: <g0l431lg0hrj7msln8smiiah4566i21nhd@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi All,

On Wed, 16 Mar 2005 00:00:59 +0100, you wrote:

>> adm1026 uses analog_out so that's fine.
>
>But lm87 uses aout_output and pcf8591 uses out0_output. The later is the

>one which fits best in our current naming scheme, as redundant as it
>might sound.
>
>Also, it might make sense to just name is pwm0 as the suggested use for
>the analog output is to control a fan. That's what we do for the
>W83627THF IIRC. Ideally we would have names the pwm files something like
>"fan_control" in the first place, so as to focus on the function instead
>of the technology, but that's a bit late now.

Makes sense to me: use an existing fan control output, scale to 
percentage if needed.  Count this one solved with a few options.

Mark wrote:
>no other driver bothers with clearing chassis intrusion, so I wouldn't bother.
>If you're motivated, though, do it however  you want. If it were me,
>I'd name it chassis_clear and implement both methods whenever it's written to.

As far as Chassis Intrusion (CI) goes, I've coerced an unused IN 
limit for time being as all I need is a write-only trigger event. 

Count this one highly optional with name 'chassis_clear' available.

Cheers,
Grant.


