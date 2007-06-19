From: Walt H <walt_h@lorettotel.net>
Date: Tue, 19 Jun 2007 22:47:13 +0000
Subject: Re: [lm-sensors] initial fintek f71882fg driver, test please
Message-Id: <46785CF1.4010307@lorettotel.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4676A4D8.5020706@hhs.nl>
In-Reply-To: <4676A4D8.5020706@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hans de Goede wrote:
> Hi all,
>
> Here is my first work on a fintek f71882fg driver (also epox 1308). 
> Still todo:
> in1 max, beep and alarm read and write
> tempX fault read
> tempX beep and alarm read and write
> tempX max / crit / hyst writing
> fanX fault read
> pwm support
>
> This version should work on non Epox motherboards like MSI too (Thanks 
> Mathias Grimmberger)
>
> To test drop fintek71882 and the Makefile in a dir, type make and then 
> insmod fintek71882.ko
>
> The easiest way to then read the settings is by using the 3.0 sensors 
> branch, which comes with dyn chipsupport:
> remove your current lm-sensors userspace package (for example on 
> Fedora do rpm -e lm_sensors --nodeps)
> svn checkout 
> http://lm-sensors.org/svn/lm-sensors/branches/lm-sensors-3.0.0
> cd lm-sensors-3.0.0
> make
> sudo make install
> sudo ldconfig
>
>
> I've also attached a sensors.conf for the Epox M1697 motherboard I'm 
> using for testing, modify as needed.
>
>
> Thanks for testing & Regards,
>
> Hans

Compiled and installed fine against a patched 2.6.21 x86_64 kernel .  
Looks good so far.  I'm displaying sensor values through gkrellm and the 
temps and fan values look good.  Vcor1 looks high, and the voltage 
inputs need tweaks under gkrellm, but I'm mainly interested in temp and 
fan values anyway.  Appreciate everybody's work on this!  Thanks,

-Walt



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
