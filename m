From: keenanpepper@gmail.com (Keenan Pepper)
Date: Mon, 30 May 2005 02:19:20 +0000
Subject: [lm-sensors] SMSC LPC47M192 - "Device is disabled, will not use"
Message-Id: <429A5BE3.8060008@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <429A1930.6040409@gmail.com>
In-Reply-To: <429A1930.6040409@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Grant Coady wrote:
> Have you compiled all i2c sensor device drivers as modules to get a 
> successful probe?  Seems only the EEPROM detected?  Does BIOS screen 
> show 'hardware health' or similar summary indicating you have h/w 
> monitoring available?

Yes, I compiled all the drivers as modules as recommended here: 
http://secure.netroedge.com/~lm78/kernel26.html

sensors-detect says "Success... but not activated", which confuses me.

My BIOS displays the fan speed and CPU temperature, so I know the sensors are 
actually there, I just can't access them from linux.
