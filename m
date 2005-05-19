From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:25 +0000
Subject: New driver for PCF8591
Message-Id: <3BEEF85B.8D6032CA@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <E162vWB-0000d5-00@localhost>
In-Reply-To: <E162vWB-0000d5-00@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

#define I2C_DRIVERID_PCF8591 1030

I added an entry on the new drivers page for you.

Good luck. Let us know if you need any help.

mds



Aurelien Jarno wrote:
> 
> Hello,
> 
> I would like to write a new driver for the PCF8591. It is an 8-bit A/D and
> D/A converter (4 analog input and one analog ouptpu) for the I2C bus produced
> by Philips Semiconductors.
> 
> According to the website in the "New Drivers" section, nobody has started to
> write a driver for this chip. Please tell me if it is wrong.
> 
> I have read the new_drivers file in the lm-sensors package and I have seen I
> am needing an ID reserved in i2c-id.h. Could you provide me one ?
> 
> Thanks
> 
> Aurelien Jarno
