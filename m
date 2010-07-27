From: Marco <jjletho67-ml@yahoo.it>
Date: Tue, 27 Jul 2010 14:42:28 +0000
Subject: Re: [lm-sensors] asus_atk0110 on a p6td deluxe
Message-Id: <825311.74058.qm@web28504.mail.ukl.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <724895.29279.qm@web28512.mail.ukl.yahoo.com>
In-Reply-To: <724895.29279.qm@web28512.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org




>Ok, as expected the hwmon section does not contain additional entries.
>
>However, in GIT3 I see at least the following entries that are
>connected to the hwmon chip:
>
>"BCLK Frequency"
>"CPU Voltage" (another one, but for a different register)
>"CPU Ratio"
>"QPI/DRAM Core Volt"
>"DRAM Bus Voltage"
>
>It will take a bit of reverse engineering to get GIT3 to work; are you
>able to compile a patched version of the driver and do some tests?
>
>Luca

Hi Luca,
The entries you have found are exactly what i was expecting! 
Those values are available in the asus (win only) utility so I imagine they 
should be somewhere

I usually use default distro kernels, but i can try to recompile a module... 
could you give me some basic hint, a makefile or something similar ?

Thank you a lot!

Marco 



      

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
