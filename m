From: mkgu_2005@yahoo.ca (MK GU)
Date: Tue, 01 Nov 2005 11:49:20 +0000
Subject: [lm-sensors] Helps: how to use i801--SMBus functions via i2c-dev
Message-Id: <20051101104855.41881.qmail@web31214.mail.mud.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dear Sir,
 
I am new to Linux and Device driver programming. I am trying to write a device driver software module to access the ICH6 SMBus controller on the motherboard of our PC running Linux 2.6.10 kernel. I configured my 2.6.10 kernel to have I2C built-in support and your i801 module loaded. Then I loaded the i2c-dev interface module and wrote a short application software to test the functions for SMBus. After my application opened the /dev/i2c device, I received messages saying "i2c-adaptor: i2c-0 -- I2C level transfer not support" when my application software called the read and write function of the i2c-dev module. Further tracking inside the i2c-dev module shew that the algorithm parameter adap->algo->master_xfer = NULL. That means the i801 driver was not properly loaded by the i2c-dev module.
 
Could you advise how I can make use of the i801 module and your i2c-dev module to access the ICH6 SMBus controller?
 
Thanks a lot in advance.
Michael Gu
 


		
---------------------------------
Find your next car at Yahoo! Canada Autos
