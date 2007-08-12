From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 12 Aug 2007 11:34:42 +0000
Subject: Re: [lm-sensors] lm_sensors / linux 2.6 kernel adm 1024 support
Message-Id: <20070812133442.06b21f98@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Tue, 24 Jul 2007 15:57:14 +0200, Hans de Goede wrote:
> Short intro: I'm the author of several 2.6 hwmon drivers, and I'm also a 
> teacher in computer science at a Dutch University. Coming September I will be 
> giving a class in writing Linux device drivers and I want to use some real 
> world examples as lab exercises. Currently this includes letting the students 
> write a driver for the adm 1024, which I will then submit to the kernel and 
> maintain, unless the students want to do this him / her self.
> 
> In order for this to happen I need to have some hardware for the students to 
> develop the driver on. May I ask which motherboards you have with this chip, 
> then I can try to buy one (second hand).

I had a look at MBM's list of supported boards, and only found the
following two boards listed as using one or more ADM1024 chips:
Acer	Veriton 3200PC
Tyan	HeSL

You may also try asking Analog for an ADM1024 evaluation board:
http://www.analog.com/en/content/0,2886,766%255F1079%255F11192%255F0,00.html

As a side note... the ADM1024 register map is suspiciously similar to
the LM87 register map. This certainly deserves further investigation,
maybe adding support for the ADM1024 to the lm87 driver would be easier
and cheaper than porting the old adm1024 driver or writing a brand new
one.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
