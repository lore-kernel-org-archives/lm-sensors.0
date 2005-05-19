From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: gl518sm chip driver for 2.6 kernel
Message-Id: <1075295349.4017b475e9031@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I found that the gl518sm driver has not been ported to the 2.6
> kernel in the latest 2.6.1 release.  If no one has, I have attempted
> it, and it seems to work fine.  I have attached the file with this
> email. I hope it can be included into the sensors package.

This is a great piece of news :) We are really looking for driver
porters.

> What else do I need to do?

I will review your code this evening or tomorrow. Did you look at and
follow the porting guidelines (Documentation/i2c/porting-clients) or
not? If not, please take some time to read it, apply any change needed
to you code and submit it again for review. Else, your work is probably
over and all you have to do now is be patient until I can review your
code and send it to Greg KH for inclusion into Linux 2.6.3.

Thanks a lot :)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
