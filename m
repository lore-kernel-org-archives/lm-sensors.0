From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sat, 01 Apr 2006 19:35:50 +0000
Subject: [lm-sensors] W83627EHF driver enhancements
Message-Id: <442ED616.4070109@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I'm begining new thread so we are not lost in three past threads.

Let me summarize what we have now:

Me: 23.03.2006 23:08
     I posted the patch on the top of all changes (alarms, volts)
You: 24.03.2006
       You posted the clean up patch and the DC 0 and PWM 1 patch.

You: Re: [lm-sensors] [PATCH] Add fan control support to W83627EHF
      We agreed to have RPM cruise mode with new sysfs files for this, no patch yet.

I really like your cleanup patch but we cannot use it for the final file until we have finished the fans stuff.
There are two ways:

1) split it up to before the fan control patch and after fancontrol patch applied (more work)
2) apply it on the top of fancontrol patch when we are done with it (little extra work, just rip the DC change from the patch,
   plus little tweaking when there is new code in he file, no need to rework whole cleanup)

I propose this steps:

1) I will document that we have 0 for DC and 1 for PWM (patch to kernel doc)
2) You will send me the patch on the top of that one from 23.3 that fixes the DC 0 and PWM 1
   plus the manual stuff, optionaly you may include the new RPM cruise files features. This can be done in one patch because it
   is just "our" internal step.
   When we are done with this I will post the final patch and submit it to Jean for inclusion
3) Now you can send the cleanup patch on the top of previous patch (With the Signed-off-by stuff)

I'm sorry for late responces but I have simply lot of to do.

Thanks,
Regards
Rudolf

