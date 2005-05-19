From: jap@iki.fi (Jaakko Ala-Paavola)
Date: Thu, 19 May 2005 06:25:32 +0000
Subject: new bus driver
Message-Id: <Pine.LNX.4.61.0501251925070.26861@zebra.tky.hut.fi>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.61.0501251912150.26717@zebra.tky.hut.fi>
In-Reply-To: <Pine.LNX.4.61.0501251912150.26717@zebra.tky.hut.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 25 Jan 2005, Jaakko Ala-Paavola wrote:
> I'm planning to implement a bus driver for a simple homebrew 
> serial port I2C-adapter:

I forget to explain motivation for such a project. The goal is not to 
monitor PC hardware, but to communicate with external devices. For 
example, the are number of microcontrollers equiped with I2C interface. 
Thus such a self-made adapter that costs only few dollars would be handy 
for a electronics hobbyist. Nowadays new PCs, especially laptops, do not 
have serial port, but a low cost USB-Serial converter in conjuction with 
the device does the job.

Jaakko

> http://vodka.tky.hut.fi/~jap/Electronics/I2C/SerialAdapter/index.html
> 
> The original design is mine, but I just got confirmation from a hacker in 
> Italy that the device actually does work. Unfortunately the guy wrote 
> the driver for Windows only. Thus I decided to implement one for linux.
> 
> I checked the list of supported bus drivers and didn't found anything 
> related to serial port. Do you feel that kind of project usefull?
> 
> BR
> Jaakko Ala-Paavola
> 
> 
