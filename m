From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 08 Jul 2005 21:02:11 +0000
Subject: [lm-sensors] problems loading i2c-proc
Message-Id: <20050708210156.5b5b3492.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.62.0507071513250.11559@snowball.fnal.gov>
In-Reply-To: <Pine.LNX.4.62.0507071513250.11559@snowball.fnal.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Steven,

> > Another possibility is a problem with symbol versioning, which you
> > seem to have enabled. It should work, but maybe you could try
> > without versioning, just in case.
> 
> I have no idea either how to enable or disable symbol versioning. 
> Have never had to do anything about this before in previous i2c
> releases compiled on the same machines.

This is enabled at kernel compilation time in Loadable module support >
Set version information on all module symbols.

You didn't tell us how you are installing i2c. Have you patched your
kernel sources tree? Or are you compiling i2c separately? In the latter
case, is the kernel a stock one or did you recompile it at some point?

Can you share your kernel configuration file so that I try reproducing
the problem?

Thanks,
-- 
Jean Delvare
