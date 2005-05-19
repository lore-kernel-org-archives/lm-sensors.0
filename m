From: toth_andras@chello.hu (=?ISO-8859-1?Q?T=F3th_Andr=E1s?=)
Date: Thu, 19 May 2005 06:24:09 +0000
Subject: #1353 still error!!
Message-Id: <3F2A3E70.8090907@chello.hu>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F28DE38.70801@chello.hu>
In-Reply-To: <3F28DE38.70801@chello.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>
>
>So I have to repeat myself. Sensors-detect can't detect your ASB100
>until it is able to load the driver for the I2C bus your ASB100 is on.
>You can see in the log you sent:
>
>Load `i2c-i801' (say NO if built into your kernel)? (YES/no):
>/lib/modules/2.4.18-4GB/kernel/drivers/i2c/busses/i2c-i801.o: 
>init_module: No such device
>Hint: insmod errors can be caused by incorrect module parameters, 
>including invalid IO or IRQ parameters
>/lib/modules/2.4.18-4GB/kernel/drivers/i2c/busses/i2c-i801.o: insmod 
>/lib/modules/2.4.18-4GB/kernel/drivers/i2c/busses/i2c-i801.o failed
>/lib/modules/2.4.18-4GB/kernel/drivers/i2c/busses/i2c-i801.o: insmod 
>i2c-i801 failed
>Loading failed... skipping.
>
>The problem is *here* and as long as we can't solve it, we won't go any
>further.
>
>So I ask my question again: ANY MESSAGE IN THE LOGS?
>

I'd like to apologize, it was my fault, I'm sorry, I didn't understand 
it for the first time.
I've did the sensors-detect again, then I checked the syslog file, which 
writes this line ONLY:

Aug 1 12:09:40 Proxima kernel: i2c-i801 version 2.8.0 (20030714)

Nothing more, errors are only in sensors-detect (those I wrote twice: 
insmod failed).
I checked it twice, it doesn't write anymore errors.
It says: "Hint: insmod errors can be caused by incorrect module 
parameters, including invalid IO or IRQ parameters" . Does this mean 
that I need to change something in configuration files or in BIOS ? Or 
do I need to compile a new kernel with this module compiled in?

Sorry once more...

Thank you for your kind help!
Best regards,
Toth Andras

