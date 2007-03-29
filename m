From: "George T. Joseph \(development\)" <gtj.devel@peakin.com>
Date: Thu, 29 Mar 2007 23:16:32 +0000
Subject: Re: [lm-sensors] [PATCH] coretemp 2/3 Add the coretemp driver
Message-Id: <22E26940476D1E48AA6F292B5316C9C337F9@bes1.peakin.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <46006650.8000603@assembler.cz>
In-Reply-To: <46006650.8000603@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This may be a little late, but how about a module parameter that sets
tjmax (and suppresses the warning). This way if the detection logic
fails for some reason, the driver can still be used if the user knows
what the tjmax for their processor is.

> -----Original Message-----
> From: lm-sensors-bounces@lm-sensors.org 
> [mailto:lm-sensors-bounces@lm-sensors.org] On Behalf Of Rudolf Marek
> Sent: Tuesday, March 20, 2007 4:55 PM
> To: LM Sensors
> Cc: bytes@linuxgazette.net; Alexey Dobriyan; 
> nicolas@boichat.ch; jpiszcz@lucidpixels.com
> Subject: [lm-sensors] [PATCH] coretemp 2/3 Add the coretemp driver
> 
> Hello Jean,
> 
> This is just the fixed version of the driver (the small typo 
> Nicolas pointed 
> out). Please can you test/apply to your stack once we know it 
> is OK and once the 
> 1/3 patch is applied?
> 
> Thanks,
> 
> This patch adds the support for the digital temperature 
> sensor found in recent 
> Intel Core CPUs.
> 
> Signed-off-by: Rudolf Marek <r.marek@assembler.cz>
> 
> Rudolf
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
