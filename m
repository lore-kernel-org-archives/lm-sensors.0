From: phil@edgedesign.us (Philip Edelbrock)
Date: Thu, 19 May 2005 06:24:20 +0000
Subject: Query
Message-Id: <3F81D69B.5060901@edgedesign.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <1065472677.10222.1.camel@localhost.localdomain>
In-Reply-To: <1065472677.10222.1.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

First, you can scan the bus to see which addresses have devices which 
respond to an I2C command.

The datasheets show what possible addresses a device can be configured 
to be located at.  Also, blocks of addresses usually are used by certain 
types of chips (like 0x50-0x5F and 0x30-0x3F are usually eeproms, 0x2D 
is usually a system hardware monitoring chip, 0x69 is usually a clocking 
chip, etc.)

To confirm the identity, we do some specific query (again as specified 
by the datasheet) which can be used as a test.  For example, some chips 
have specific registers which will always contain some specific values 
to identify things like vendor, chip ID, and die rev.

So, if you are looking for a specific device and want to see if it is at 
a particular address, you'll have to try to communicate with it as per 
the datasheet to see if it responds in a way that you would expect.

Unfortunately, there is no clear cut way of knowing what a chip is 
before talking with it (unlike other bus protocols, like PCI).

Does this help?


Phil

Ashwin Nayak wrote:

>Hi,
>	What I would like to know is how you guys can tell at which address
>which hardware is located. Like you guys say that the pll is at address
>0x69 etc.How can I tell if the device that I am looking for is at a
>particular address.
>
>Ashwin
>
>
>
>  
>
