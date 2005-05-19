From: frodol@dds.nl (Frodo Looijaard)
Date: Thu, 19 May 2005 06:24:01 +0000
Subject: [jmouro@iol.pt: i2c]
Message-Id: <20030623114433.GA20361@frodo.local>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

----- Forwarded message from jmouro@iol.pt -----

From: jmouro@iol.pt
Subject: i2c
To: frodol@dds.nl
Priority: normal
X-MIME-Autoconverted: from quoted-printable to 8bit by morannon.frodo.local id h5NBA5FE019978
X-Spam-Status: No, hits=0.2 required=5.0 tests=NO_REAL_NAME,SUPERLONG_LINE version=2.20
X-Spam-Level: 

Hello there, 
I'm sorry to bother you, but I'm developing some code that must use the i2c protocol, and perhaps you could explain me some gray areas to me.

The system I'm working in, is an embedded system (MPC860) that must interface 4 SFP modules through I2c bus. This four modules are chip selected by an cpld. This means that the four modules have the same address (hardwired), and only one module at a time receives the i2c clock.


I'm using the /dev interface to access the modules from userspace, but my main questions are related to this : The interface specification of this modules define a 256 byte memory map in EEPROM which is accessible over a 2 wire serial interface at the 8 bit address A0h, and a diagnostic interface that uses the 8 bit address A2h.

How can I change from one address to the other? The specification defines that if a certain flag on the A0h is set , it's necessary to perform an address change sequence before accessing information at the 2 wire serial address A2h. If the bit isn't set the host may simply read from either address, A0h or A2h, using that value in the address byte during the 2 wire communication sequence (how is this done ?).
The address change sequence is defined in the following steps:

1) Host controller performs a Start condition, followed by a slave address of 0b00000000.
-- Note that the R/W bit of this address indicates transfer from host to device (?0?b). 
2) Device responds with Ack 
3) Host controller transfers 0b00000100 (04h) as the next 8 bits of data 
-- This value indicates that the device is to change its address 
4) Device responds with Ack 
5) Host controller transfers one of the following values as the next 8 bits of data: 
--0bXXXXXX00 ? specifies Serial ID memory page 
--0bXXXXXX10 ? specifies Digital Diagnostic memory page 
6) Device responds with Ack 
7) Host controller performs a stop condition 
8) Device changes address that it responds to, based on the Step 5 byte value above: 
--0bXXXXXX00 ? address becomes 0b1010000X (A0h) 
--0bXXXXXX10 ? address becomes 0b1010001X (A2h) 

Is this possible to implement using the dev interface?!

thanks for your attention

mouro
 


----- End forwarded message -----

-- 
Frodo Looijaard <frodol@dds.nl>  PGP key and more: http://huizen.dds.nl/~frodol
Defenestration n. (formal or joc.):
  The act of removing Windows from your computer in disgust, usually followed
  by the installation of Linux or some other Unix-like operating system.
