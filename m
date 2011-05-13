From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 13 May 2011 19:36:17 +0000
Subject: Re: [lm-sensors] Will there ever be EMC6w201 support?
Message-Id: <20110513213617.5bfac5b5@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110414034609.476411A9866@localhost.localdomain>
In-Reply-To: <20110414034609.476411A9866@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jeff,

On Fri, 13 May 2011 12:47:07 -0500, Jeff Rickman wrote:
> On 5/13/2011 11:44 AM, Jean Delvare wrote:
> > Looks very promising. Now let's wait for Jeff's report.
> 
> I have promising results; no crash messages. "sensors" out that shows 
> N/A. See attached.
> 
> I still need to use the "force" option or else I get the "no such 
> device" error message. See attached.

That's good enough as far as I'm concerned. The driver wasn't written
for this machine, it happens to work on Harry's, good for him, but as
long as the driver doesn't crash, that's fine with me. If you see N/A
in the output of "sensors" because the driver doesn't get any value
from the BIOS (cat /proc/i8k will certainly return many -22s.) Why it
works on Harry's machine and not on yours while they seem pretty
similar is certainly strange, but that's out of scope for me.

So, thanks Jeff and Harry for the testing on i8k, at least the assembly
code problem is solved. Luca, are you going to make a proper
submission, or should I handle it? I don't want to steal the credit
from you.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
