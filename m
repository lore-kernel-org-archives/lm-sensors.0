From: jap@iki.fi (Jaakko Ala-Paavola)
Date: Thu, 19 May 2005 06:25:32 +0000
Subject: new bus driver
Message-Id: <Pine.LNX.4.61.0501251912150.26717@zebra.tky.hut.fi>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi, 
I'm planning to implement a bus driver for a simple homebrew 
serial port I2C-adapter:

http://vodka.tky.hut.fi/~jap/Electronics/I2C/SerialAdapter/index.html

The original design is mine, but I just got confirmation from a hacker in 
Italy that the device actually does work. Unfortunately the guy wrote 
the driver for Windows only. Thus I decided to implement one for linux.

I checked the list of supported bus drivers and didn't found anything 
related to serial port. Do you feel that kind of project usefull?

BR
Jaakko Ala-Paavola
