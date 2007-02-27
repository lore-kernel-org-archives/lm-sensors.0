From: hjk@linutronix.de (=?iso-8859-1?q?Hans-J=FCrgen_Koch?=)
Date: Tue, 27 Feb 2007 19:58:26 +0000
Subject: [lm-sensors] [PATCH] Add MAX6650 support
Message-Id: <200702272058.27507.hjk@linutronix.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200701171359.46334.hjk@linutronix.de>
In-Reply-To: <200701171359.46334.hjk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Am Dienstag, 27. Februar 2007 19:07 schrieb Jean Delvare:

>
> > Do the count, speed and config also have to be modified to follow a
> > convention?
>
> The count and config files are non-standard files so they don't have to
> follow any specific convention. In fact I would even remove these
> files, in particular the config file infringes the fundamental sysfs
> rule. And the count file isn't particularly useful.

Well, the current implementation assumes that the MAX6650 is initialized by 
the BIOS. On the other hand, the 5V/12V setting is done by the driver, the 
value is hardcoded in the source. This doesn't look like a clean solution.

I suggest to add module parameters to allow configuration of 5V/12V, 
prescaler, count and mode. Then we _know_ the settings and can drop the 
config and the count file. We also get rid of the hardcoded 5V/12V setting 
and don't need to rely on a BIOS that might or might not do what we want.

Any objections?

>
> The speed file, what is it doing? If it is used to set the desired fan
> speed, then the right name would be fan1_target. Does it only apply to
> one fan or all? Is it always active?

It sets the speed of the single fan for a MAX6650. For a MAX6651, it sets a 
speed that is valid for all connected fans, if I understand the data sheet 
correctly. In any case, this works only if mode is set to "closed loop".

Thanks,
Hans


