From: ed.tman@verizon.net (Ed Harrison)
Date: Thu, 19 May 2005 06:23:52 +0000
Subject: sensors.conf for as99127f on asus a7m-266
Message-Id: <20030406183549.LUUT19613.out001.verizon.net@[192.168.1.100]>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E90214B.9090405@oceanography.ru>
In-Reply-To: <3E90214B.9090405@oceanography.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

** Reply to message from Jack <man@oceanography.ru> on Sun, 06 Apr 2003
16:44:59 +0400

My MB is A7V333 with ASB100(Bach) which is an as99127f.

# I've got asus a7m266 with as99127f chip, default config for it won't do 
# well, I've hacked this:
# 
# 
# 
# chip "as99127f-*"
# 
#      label in5 "-12V"
#      label in6 "-5V"

	both of the negative voltages gave me small positive numbers

#      label fan1 "CPU fan"

	Works right on CMOS.

#      label fan2 "Pwr fan"

	i got no reading on this fan at all.

#      label fan3 "SBr fan"

	Not installed on mine

#      label temp1 "SBr temp"

	Right on target with CMOS.

#      label temp2 "CPU temp"

	30 degrees F, low
	old calculation of "compute temp2 (@*30/43)+25, (@-25)*43/30" works
better

#      ignore temp3

	good idea--proprietary diode temp by ASUS--temp never changes

	Had to add "set vrm 9.0" as I have 1.75V, but got reading of 1.85V

# actually, even with the same chip, as you say, there are different
# values of resistors so on different mzboards configs would be different
# hence, i think configuration should be specific not only for the chip,
# but for the chip AND the mzboard. the lest, config should allow
# mzboard-specific subconfigurations for chips, so various people will
# quickly find their formulae for their mzboards and would send you

	I have been unable to quickly, or otherwise, find the correct formula
for fan2

# the data, and there'll be one good sensors.conf that anyone can
# use just finding their mzboard there, not probing for various stuff


Ed Harrison, broadcasting on:
        L I N U X
by SuSE (8.1), Kernel 2.4.20,
X-server 4.3, PolarBarMailer 1.25a
