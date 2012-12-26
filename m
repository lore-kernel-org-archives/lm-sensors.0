From: Andrey Repin <hell-for-yahoo@umail.ru>
Date: Wed, 26 Dec 2012 20:11:57 +0000
Subject: Re: [lm-sensors] Help to make lm-sensors work with an Asus TUSL2-C
Message-Id: <1745860422.20121227001157@mtu-net.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <50DB2017.8010403@tiscali.it>
In-Reply-To: <50DB2017.8010403@tiscali.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greetings, Mauro Molinari!

> I'm writing because I need help to configure lm-sensors to work on an
> old Asus TUSL2-C motherboard. I read a lot of documentation on 
> lm-sensors website and wiki and I did some searches with Google, however 
> I can't understand what I'm doing wrong.

Have you tried downloading newer sensors-detect script from the website?

> First of all, I'm using a Linux distribution based on Debian Squeeze: 
> precisely, it's OpenMediaVault 0.4. "uname -a" shows:
> Linux openmediavault 2.6.32-5-686 #1 SMP Sun Sep 23 09:49:36 UTC 2012 
> i686 GNU/Linux
> and "sensors -v" shows:
> sensors version 3.1.2 with libsensors version 3.1.2

> I installed lm-sensors with "apt-get install lm-sensors". Then, I 
> launched "sensors-detect". The problem is: no sensor is found. The only 
> relevant output is given at the end:

> ---
> Do you want to probe the I2C/SMBus adapters now? (YES/no):
> Using driver `i2c-i801' for device 0000:00:1f.3: Intel 82801BA ICH2

> Sorry, no sensors were detected.
> ---

> So, if I understand it correctly, the i2c-i801 driver is found and 
> queried, but no sensors are found there.
> I then made some researches on the Internet and found the following 
> information.

> At:
> http://lists.lm-sensors.org/pipermail/lm-sensors/2005-March/011402.html
> a user says that lm-sensors works with Asus TUSL2-C. I also found out 
> the example configuration file at:
> http://www.lm-sensors.org/browser/lm-sensors/trunk/etc/sensors.conf.eg?rev)64
> which mentions the TUSL2-C: for it the AS99127F chip should apply.
> Then, if I look at:
> http://www.lm-sensors.org/wiki/Devices
> I actually find that the AS99127F chip is supported by the w83781d 
> driver since kernel 2.5.67, however the sensors-detect program shows this:
> Probing for `Winbond W83781D' at 0x290...                   No

> Further searching brings this:
> http://www.lm-sensors.org/ticket/1317
> which seems to say that it's a known issue that no sensors are found on 
> the TUSL2-C. It also says to see the FAQ, but the FAQ doesn't say 
> anything in particular for this motherboard or for that chip.

> I then tried the following:
> - run "modprobe w83781d", then run "sensors": still "No sensors found"
> - created a file named "asus.conf" under /etc/sensors.d (it's not clear 
> to me if the custom configuration file in /etc/sensors.d can be named as 
> I like, or if I must give it a specific name...) and put in it all the 
> contents from sensors.conf.eg related to the AS99127F chip, then run 
> "sensors" or even "sensors -c /etc/sensors.d/asus.conf" (do I need to 
> specify the config location??): still "No sensors found"

> I don't know what else to try! :-(


--
WBR,
Andrey Repin (hell-for-yahoo@umail.ru) 27.12.2012, <00:11>

Sorry for my terrible english...


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
