From: manu@agat.net (Blindauer Emmanuel)
Date: Thu, 19 May 2005 06:23:59 +0000
Subject: w83781d 2.7.0 - temp2
Message-Id: <200306092142.56416.manu@agat.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,
I'm using lm_sensors since a few weeks, for monitoring the temp and fan of 
my motherboard.
I was getting bad values with the default config file with as99127f
I've noticed that some persons have modified the computing of temp2.
I've used the first values, and it work fine
"compute temp2 (@*30/43)+25, (@-25)*43/30" is ok with the motherboard Asus 
A7V333-X
Fan values are ok, when the bios is set no to slow down the fan in case of 
low temp.
When the fan slow down, values returned are bad (168750 RPM, 96428 RPM, 
675000 RPM and other values like that.

So I hope these informations will help you a little more.

Emmanuel


-- 
