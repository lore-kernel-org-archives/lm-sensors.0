From: Rudolf Marek <r.marek@assembler.cz>
Date: Mon, 25 Jun 2007 18:20:09 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon/coretemp: Fix a broken error path -
Message-Id: <46800759.6040605@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <1182026585.4230.8.camel@localhost>	 <20070616231745.1b0f7bd9@hyperion.delvare>	 <1182071803.4815.5.camel@localhost>  <467575BF.1090207@assembler.cz>	 <1182335403.21563.99.camel@localhost>  <467AE640.9090409@assembler.cz> <1182779850.21781.11.camel@localhost>
In-Reply-To: <1182779850.21781.11.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: lkml <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>

> Hi Rudolf,
> 
> just one more update:
> 
> When I put my machine into s2ram and make it resume, one of the coretemp
> sensors gets lost. Ahh and I am already rmmod coretemp / loading
> microcode after resume / insmod coretemp...

Hello, If I understand correctly you unload the driver before suspend. Resume, 
update microcode, load the driver correct?

Please can you check dmesg if for example one core complains about bad microcode 
version?

Thanks,
Rudolf

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
