From: Ingo Struck <ingo@ingostruck.de>
Date: Thu, 19 Jul 2012 14:41:25 +0000
Subject: [lm-sensors] Asus P8B WS conf Mockup
Message-Id: <20120719144125.GA7508@neo.s25>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="YiEDa0DAkWCtVeE4"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi there, 

after some hours of investigation I found there is near to no
support for the Asus P8B WS mainboard yet.

Please find attached my config-mockup (based on the jc42 module
and the experimental nct6775 driver module).

Should work with kernels 2.6.36 and newer. Please publish to your
wiki.

Thanks and kind regards

Ingo Struck

--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="P8B-WS.conf"

# Configuration for Asus P8B WS
# as running at Hetzner X6 type host (2012-07)
#
# NOTE: this relies on jc42 driver module (2.6.36 and newer)
# and on the experimental nct6775 driver module
# https://github.com/groeck/nct6775.git

chip "nct6776-isa-*"
	set fan1_min 600
	set fan2_min 600
	ignore fan3 # not connected
	ignore fan4 # not connected
	ignore fan5 # not connected

	label in1 "+12V"
	compute in1 12*@, @/12
	set in1_min 0.95*12 # 1V ref ?
	set in1_max 1.05*12
	label in4 "+5V"
	compute in4 5*@, @/5
	set in4_min 0.95*5 # 1V ref ?
	set in4_max 1.05*5 

	ignore in5 # possibly bogus vid
	ignore cpu0_vid # possibly bogus vid

	# mapping: SYSTIN -> temp1, CPUTIN -> temp2, AUXTIN -> temp3
	# PECI Agent 0 -> temp7, PCH_CHIP_TEMP -> temp8

	# guesswork:
	set temp1_max 45
	set temp1_max_hyst 40
	set temp2_max 100
	set temp2_max_hyst 96
	set temp3_max 45
	set temp3_max_hyst 40

	ignore temp8 # PCH_CHIP_TEMP, reports 0
	ignore temp9 # PCH_CPU_TEMP, reports 0
	ignore temp10 # PCH_MCH_TEMP, reports 0

	ignore intrusion0 # not connected @ Hetzner
	ignore intrusion1 # not connected @ Hetzner

# memory modules ?
bus "i2c-0" "SMBus I801 adapter at f040"

chip "jc42-i2c-0-*" 
	set temp1_min 1
	set temp1_max 50
	set temp1_crit 60

--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--YiEDa0DAkWCtVeE4--
