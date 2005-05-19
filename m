From: ctusar@videon-central.com (Cory Tusar)
Date: Thu, 19 May 2005 06:25:51 +0000
Subject: Writing new driver for FM3104 on Cirrus 9301 processor
Message-Id: <425D0A82.4060206@videon-central.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200504130348.j3D3mOi0012882@serv0.rtunet.com>
In-Reply-To: <200504130348.j3D3mOi0012882@serv0.rtunet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Benny Chen wrote:
> Hi Guys,
> I have gone through much of the doco and really need your help. I am about
> to embark on writing a driver for the RTC and Watch Dog timer for our
> system.  I have some questions and hopefully you can help.
>  
> In our system, the FM3104 chip?s SCL and SDA line are connected to the EECLK
> and EESDA (like GPIO) line on the processor.  Hence, I would need to use
> some bit bang algo to talk to the chip.  But I would want to maximise the
> use of existing code in the i2c directory but don?t know what I should be
> writing.    

There is already an existing EP93xx GPIO I2C adapter driver present in 
linux-cirrus-2.6 (I am unsure about 2.4).  I can verify it works on 
EP9301, EP9312, and EP9315.  Yes, it uses the bit-bang algo.

http://members.inode.at/m.burian/ep93xx/index.html

> 1.	For both the RTC and Watch dog drivers, do I need to write both the
> adapter driver and Driver driver  or just a driver like the ds1307.c?

Most likely, just the client driver.

> 2.	Which existing src would be a good template for me?

ds1337.c looks to be a fairly good example of implementing an integrated 
i2c client / character driver.

> 3.	The DS1307. c code, it do not have an i2c_adapter structure defined,
> Hence, how do it knows what algo it would use to talk to the DS1307 chip? 

Read and understand "Attaching to an adapter" and "The detect client 
function" in Documentation/i2c/writing-clients.  The algorithm used is a 
property of the adapter itself.

-Cory


-- 
Cory T. Tusar
Embedded Systems Engineer
Videon Central, Inc.
2171 Sandy Drive
State College, PA 16801
(814) 235-1111 x316
(814) 235-1118 fax

"Debugging is twice as hard as writing the code in the first place.
   Therefore, if you write the code as cleverly as possible, you are,
     by definition, not smart enough to debug it."  --Brian W. Kernighan
