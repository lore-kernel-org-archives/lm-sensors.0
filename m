From: alfredo@milanicomparetti.com (Alfredo Milani-Comparetti)
Date: Thu, 19 May 2005 06:24:20 +0000
Subject: W83627HF SuperIO support in lm_sensors
Message-Id: <3F795D94.21925.E95D64@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030929180436.GB1779@pua.nirvana>
In-Reply-To: <20030929180436.GB1779@pua.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Known "problem" (much more of a feature actually). Our patching script
> does only include the more stable drivers. Other drivers are only
> available when you compile modules outside of the kernel tree. Our
> sensors-detect script doesn't know about that of course, and detects
> whatever it can.
> 
> If you want more drivers, either tweak the FILES and Config.in files in
> mkpatch, or build the modules directly in the lm_sensors directory
> instead of patching the kernel.

I see :-)
Anyway: since yours is a kernel recompiled for those who "know what they're 
doing" and since setting up lm_sensors needs some knowledge, I think it would 
be nice to include all those modules in your distribution.
Consider that sensors-detect script already knows which modules are dangerous 
and which ones are not and acts accordingly.
Just a suggestion. Thank you for your time :-)

Alfredo Milani Comparetti
alfredo@milanicomparetti.com
SpeedFan home page --> http://www.almico.com/speedfan.php
Delphi home page --> http://www.almico.com/delphi
Elf home page    --> http://www.radsite.com/elf
