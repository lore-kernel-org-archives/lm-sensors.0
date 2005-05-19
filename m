From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: fan2 readout on Chaintech MB
Message-Id: <20030917225126.420740fc.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200308310230.14115.ljubo108@vip.hr>
In-Reply-To: <200308310230.14115.ljubo108@vip.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I have been trying to use recent CVS version. I update CVS whenever I 
> can with cvs update -d, I did not updated just lm90 or any file
> separately.
> 
> My install procedure goes like this(Mandrake 9.1):
> 1. vanilla 2.4.22 kernel
> 2. con kolivas 2.4.22-ck2 patch set
> 3. patching kernel with i2c and lm_sensors
> 4. loading my kernel config file
> 5. compiling and installing kernel
> 6. reboot
> 7. cd into lm_sensors, make and make install
> 8. /prog/detect/sensors-detect
> 9. then I edit modules and modules.conf as suggested
> 10. reboot
> 11. Gkrellm, KSensors or just sensors
> 
> I have used con kolivas ck1 patchset on previous lm_sensors config.

What's inside that patchset? Anything related to either ACL or GRSEC?

Can you remember all changes that occured between when "sensors -s" was
working OK, and when it wasn't anymore? I'd appreciate if you could take
all the steps back to a state where "sensors -s" works again. If we
could isolate the problem, we would have a chance to understand it.

> Unfortunately I have had some problems with 166MHz FSB jumper on my 
> motherboard and I have RMA the board. I thing that replacment/new
> board will arrive next week so I can't do more testing now :-((

No problem, I am busy myself and most of the lm_sensors developers also
are.

> As soone as I get it working again I will do more testing.

OK, thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
