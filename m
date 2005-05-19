From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:13 +0000
Subject: request for official I2C_DRIVERID
Message-Id: <20040903105610.M57046@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4136DC8D.1090905@penguin-breeder.org>
In-Reply-To: <4136DC8D.1090905@penguin-breeder.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I'm maintaining a driver for so called "application buttons", a set 
> of buttons, led & lcd used in some fujitsu-siemens notebooks. These buttons
> can be read using the smbus, thus I'm using the i2c system.
> 
> Currently, I'm using a private ID, but since the driver is now in
> existance for about two years, I'd like to step forward and get an
> official ID.
> 
> The driver is available from http://apanel.sourceforge.net/ it supports
> various versions of i2c on linux 2.4 and 2.6. I'm currently using
> 
> #define I2C_DRIVERID_APANEL 0xF000
> 
> Could you please assign me an official ID?

You don't seem to be using it anywhere, are you? Thus you can simply omit it.
ID is not mandatory for i2c clients, and actually we are thinking of getting
rid of them since nobody seems to need it.

-- 
Jean Delvare
http://khali.linux-fr.org/
