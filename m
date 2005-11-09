From: hwang@circadiant.com (Howard Wang)
Date: Wed, 09 Nov 2005 15:34:31 +0000
Subject: [lm-sensors] i2c -dev and i2c bus driver
Message-Id: <24EB6743805F45478251E18DEBF3F6BE8133F8@csserver.circadiant.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <24EB6743805F45478251E18DEBF3F6BE8133DD@csserver.circadiant.com>
In-Reply-To: <24EB6743805F45478251E18DEBF3F6BE8133DD@csserver.circadiant.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

	 

	I sent you an email with the sc1200 datasheet attached, unfortunately, it bounced back due to large

	size. since I don't have access to the target today, I just briefly reply answer your questions and

	tomorrow I'll try to post more detailed info from the target as well as the datasheet.
	

	>Hmm bad is that I dont know the hardware.
	But from the driver i can see:
	         for (i = 0; i < MAX_DEVICES; ++i) {
	                if (base[i] > 0)
	                        rc = scx200_acb_create(base[i], i);
	        }
	And there are two base defined.
	So this could create two busses.
	When you modprobe i2c-dev and the scx driver you should see
	in
	i2cdump -l
	
	Listed two ACB busses
	Do you see them?

	No. I only saw one: i2c-0 with the bus type of unknown. but this doesn't matter. the smbus just works fine

	with i2cdump 0 0x50 and 0x51. 

	i2cdump -l

	Installed I2C busses:

	i2c-0  unknown  netSemi sc1200

	
	>
	If so I would suggest:
	1) plug your device to ACB 2 where it works
	   do: i2cdetect (put acb2 bus number here)
	       i2cdump (put acb2 bus number here) 0xyourdeviceaddr

	this works fine. no problem. 
	

	>
	2) repeat with plugged to ACB1

	 

	i2cdump 1 0x57 ( a same type of device is connected to bus 1 with A0,A1,A2 pulled to high )

	return with open error. no such device. for i2c-1. ( the i2c node: 0 to32  under /dev/ do exist).

	Error: Could not open file '/dev/i2c-1': No such device

	one question for you: if let's say: 

	the acb1 has been configured to use different protocol other than acb2, how can I find out and reconfigure

	the acb1 to be the same as acb2 ?

	 

	appreciated your help.

	 

	howard

	 
