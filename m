From: lamar@synque.com (Lamar Willis)
Date: Thu, 19 May 2005 06:24:20 +0000
Subject: lm_sensors 2.8.1 test
Message-Id: <200310071243.44286.lamar@synque.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean,
	Not sure is Alex is interested in this, if not I'm sure he'll say so. I've 
installed 2.8.1 and here the early results:

lm90-i2c-0-4c
Adapter: SMBus AMD75x adapter at 06e0
Algorithm: Non-I2C SMBus adapter
M/B Temp:    +45?C  (low =   +5?C, high =  +70?C)         
CPU Temp:  +55.6?C  (low =  +5.0?C, high = +70.0?C)         
tcrit1:      +85?C
tcrit2:      +85?C
hyst:        +10?C

So yes, the lm90 (if that's what's on my MPX2) is being read correctly (and 
with higher precision). Apparently only CPU0 is supported, I didn't see 
anything in the docs or configuration filers that would suggest otherwise, so 
I assume you haven't been able to incorporate Alex's suggestion yet. Let me 
know if my assumption is wrong and there is something else for me to test.
	I also think the reporting is cleaned up a bit over 2.8.0. Before I was 
getting temperature readings reported for the adapter and the chip, in 2.8.1 
it is much nicer (unless I had something configured wrong before).
	What is the meaning/purpose of tcrit over temp_high?

Lamar
