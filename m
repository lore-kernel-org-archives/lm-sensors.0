From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 18 Nov 2008 18:15:22 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] k8temp warn about errata
Message-Id: <20081118191522.420e0837@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <48E3F505.40401@assembler.cz>
In-Reply-To: <48E3F505.40401@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 18 Nov 2008 10:46:03 -0700, Jordan Crouse wrote:
> Nothing scientific.  The AMD errata team might know more about it.  I 
> can identify the obviously broken sensors - my athlon X2 system for 
> example tells me the cores are 7C and 3C respectfully, but I don't know 
> if you could tell the difference between a well working sensor and a 
> marginally working sensor, especially with differing work conditions. 
> The best you could do is to figure out how cold the core could possibly 
> run, and then omit anything under that.
> 
> You might do a better job if you could compare the core temperature 
> against the system monitor - they should only differ by a few degrees (I 
> think there is some math about how much the external and internal diodes 
> should differ).  That said, thats not the sort of math you could do in 
> the kernel driver, you would need the user land to find the other sensor 
> and do the calculations.

This is the problem: the k8temp driver doesn't have access to other
sensors for comparison purposes. Even if it had, it wouldn't know which
sensor corresponds to the CPU (this is motherboard-specific.) So while
this can be used by the user to determine whether his CPU sensors are
working or not, this cannot be used as a way to automatically discard
CPUs with broken sensors.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
