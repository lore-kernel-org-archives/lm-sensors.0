From: sascha@akv-soft.de (Sascha Volkenandt)
Date: Thu, 19 May 2005 06:24:06 +0000
Subject: EEPROM write support
Message-Id: <200307221931.02558.sascha@akv-soft.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello list,

I've just connected an old serial EEPROM to my i2c-bus, to see what else can 
be done with this bus. My question is, why is there no write support (yet)? 
Mere protection? I've added a basic write functionality myself, and it 
works pretty fine (the chip didn't blow and presents the written data on 
next real read-out).

I've also found some other I2C-Chips on the board I have that one from, 
mostly Audio and Video processors also found in other packages. Are those 
drivers intentionally not part of lm_sensors but instead their respective 
driver packages? I'm thinking about abusing the audio- and video-switches 
inside my machine :-)

Greetings,
Sascha
