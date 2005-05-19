From: garman@raw-sewage.net (Matt Garman)
Date: Thu, 19 May 2005 06:25:27 +0000
Subject: what exactly does DISCONNECT mean?
Message-Id: <20041227070416.GA7771@raw-sewage.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


The output of "sensors" looks like this:

lm90-i2c-2-4c
Adapter: SMBus nForce2 adapter at 5100
M/B Temp:    +28 C  (low  =    +0 C, high =   +70 C)   
CPU Temp: +127.0 C  (low  =  +0.0 C, high = +70.0 C)   DISCONNECT
M/B Crit:    +85 C  (hyst =   +75 C)                   
CPU Crit:    +85 C  (hyst =   +75 C)                   

I'm not sure what "DISCONNECT" means, exactly.  
The output of "sensors" looks like this:

lm90-i2c-2-4c
Adapter: SMBus nForce2 adapter at 5100
M/B Temp:    +28 C  (low  =    +0 C, high =   +70 C)   
CPU Temp: +127.0 C  (low  =  +0.0 C, high = +70.0 C)   DISCONNECT
M/B Crit:    +85 C  (hyst =   +75 C)                   
CPU Crit:    +85 C  (hyst =   +75 C)                   

I'm not sure what "DISCONNECT" means, exactly... my guess is that
lm-sensors is not getting any kind of meaningful response from the
hardware.

For what it's worth, the CPU Temp reading in the BIOS also shows
127.0 degrees C.  So at least it's consistent :)

But if a sensor is truly "not connected", do you happen to know
where I can "connect" the sensor, i.e. remedy this problem?  Can
this kind of thing be fixed in software, the BIOS or on the board
itself, or is this sensor just broken?  ...or does it all depend on
my particular hardware?

If it helps, the board is a brand-new Chaintech 7NIF2 "Summit".
Everything else appears to be working correctly.

If you have any insights or suggestions, I'd appreciate it!

Thank you,
Matt

-- 
Matt Garman
email at: http://raw-sewage.net/index.php?file=email
