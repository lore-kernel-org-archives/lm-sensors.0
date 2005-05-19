From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:23:49 +0000
Subject: help?
Message-Id: <3E6A7AD0.3020109@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.44.0302252341500.5703-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0302252341500.5703-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Your eeproms are DDR.
I don't know why they aren't recognized in 'sensors', unless your 'sensors' version
is 2.6.3 or older (we added DDR support in 2.6.4).
The eeproms are "serial presence detect" memory (one per DDR memory DIMM)
which store configuration data about your DDR.
They have nothing at all to do with your sensors other than they are on
the same I2C bus.


Claudio Destri wrote:
> Attached is the output of decode-dimms.pl
> Just to see if I understand anything of all this: are these two eeprom
> chips the memory banks holding the programs that run the physical sensors?
>  
> 
