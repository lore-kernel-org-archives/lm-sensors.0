From: Soeren Sonnenburg <kernel@nn7.de>
Date: Mon, 25 Jun 2007 13:57:30 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon/coretemp: Fix a broken error path -
Message-Id: <1182779850.21781.11.camel@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <1182026585.4230.8.camel@localhost>
	 <20070616231745.1b0f7bd9@hyperion.delvare>
	 <1182071803.4815.5.camel@localhost>  <467575BF.1090207@assembler.cz>
	 <1182335403.21563.99.camel@localhost>  <467AE640.9090409@assembler.cz>
In-Reply-To: <467AE640.9090409@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rudolf Marek <r.marek@assembler.cz>
Cc: lkml <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>

On Thu, 2007-06-21 at 22:57 +0200, Rudolf Marek wrote:
> Hello Soeren,
[...]
> Soeren pointed at some T60, T60p BIOS update and luckily, there is a
> easy way 
> how to extract the microcode update and even convert it into the .txt
> format as 
> microcode update utility (http://www.urbanmyth.org/microcode/)
> expects.
> Attached scripts generates the mcode.txt file which may be used by the
> update 
> utility. Please can you give a try?

Hi Rudolf,

just one more update:

When I put my machine into s2ram and make it resume, one of the coretemp
sensors gets lost. Ahh and I am already rmmod coretemp / loading
microcode after resume / insmod coretemp...

Any idea's on that ?

Soeren
-- 
Sometimes, there's a moment as you're waking, when you become aware of
the real world around you, but you're still dreaming.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
