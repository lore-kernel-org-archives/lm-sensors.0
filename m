From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 27 Apr 2006 15:28:53 +0000
Subject: [lm-sensors] user prog "sensors" seg faults on x86_64?
Message-Id: <20060427172853.a15de9cf.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4450D446.10303@telus.net>
In-Reply-To: <4450D446.10303@telus.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> We have a dual Opteron 285 system on a Tyan Tiger K8WE (S2877) 
> motherboard. The make user ; make user_install went fine. The 
> sensor-detect script seemed to run ok and the modprobes seemed to work 
> but the "sensors -s" command segfaults. Is it a 64 bit problem? Using 
> Suse 10.1 x86_64 beta atm.

Which version of lm_sensors is this?

Does "sensors" (without -s) work?

Why don't you use the package which comes with Suse?

Which beta is this?

I'm using lm_sensors on Suse 10.0 x86_64 myself for quite some time now
without a problem, so I doubt there is a general 64-bit problem.

-- 
Jean Delvare

