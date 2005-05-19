From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:05 +0000
Subject: [PATCH 2.6] Documentation for i2c-parport
Message-Id: <20040709195438.7d3cd8f3.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040707081936.5f48db6a.khali@linux-fr.org>
In-Reply-To: <20040707081936.5f48db6a.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > This also raises a question about Documentation/i2c/i2c-pport.
> > Should we keep a document about a driver which is not in the kernel
> > tree (and hasn't even been ported to 2.6 yet)?
> 
> No we should not.  Care to send a patch to delete it?

I'm not sure, I think this job is beyond me ;)

Signed-off-by: Jean Delvare <khali at linux-fr dot org>

Erm, do I really have so sign-off a patch which does not add any line?
:)

diff -ruN linux-2.6.7-mm5/Documentation/i2c.orig/i2c-pport linux-2.6.7-mm5/Documentation/i2c/i2c-pport
--- linux-2.6.7-mm5/Documentation/i2c.orig/i2c-pport	Sun Apr  4 05:36:54 2004
+++ linux-2.6.7-mm5/Documentation/i2c/i2c-pport	Thu Jan  1 01:00:00 1970
@@ -1,45 +0,0 @@
-Primitive parallel port is driver for i2c bus, which exploits 
-features of modern bidirectional parallel ports. 
-
-Bidirectional ports have particular bits connected in following way:
-   
-                        |
-            /-----|     R
-         --o|     |-----|
-      read  \-----|     /------- Out pin
-                      |/
-                   - -|\
-                write   V
-                        |
-                       ---  
-
-
-It means when output is set to 1 we can read the port. Therefore 
-we can use 2 pins of parallel port as SDA and SCL for i2c bus. It 
-is not necessary to add any external - additional parts, we can 
-read and write the same port simultaneously.
-	I only use register base+2 so it is possible to use all 
-8 data bits of parallel port for other applications (I have 
-connected EEPROM and LCD display). I do not use bit Enable Bi-directional
- Port. The only disadvantage is we can only support 5V chips.
-
-Layout:
-
-Cannon 25 pin
-
-SDA - connect to pin 14 (Auto Linefeed)
-SCL - connect to pin 16 (Initialize Printer)
-GND - connect to pin 18-25
-+5V - use external supply (I use 5V from 3.5" floppy connector)
-      
-no pullups  requied
-
-Module parameters:
-
-base = 0xXXX
-XXX - 278 or 378
-
-That's all.
-
-Daniel Smolik
-marvin@sitour.cz


-- 
Jean Delvare
http://khali.linux-fr.org/
