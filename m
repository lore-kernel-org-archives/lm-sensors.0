From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 18 Feb 2008 19:45:05 +0000
Subject: Re: [lm-sensors] Preparing patches for pca9552, ad5259, and bq27350
Message-Id: <20080218204505.71690ee9@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <FD2217BC-9A9C-4CFE-843F-15F1600B4CCE@codetastic.com>
In-Reply-To: <FD2217BC-9A9C-4CFE-843F-15F1600B4CCE@codetastic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Matthew,

On Mon, 18 Feb 2008 10:54:55 -0800, Matthew Bosworth wrote:
> Hi everyone,
> 
>    I've developed some i2c chip drivers that I'd like to contribute.   
> They're working in our environment (Atmel at91 (ARM)  eval board), and  
> I'm currently checking them against the kernel coding standards.
> 
>    Specifically, the chips are :
> 
> Phillips PCA9552 16-bit I2C-bus LED driver with programmable blink rates
> Analog Devices AD5259 Nonvolatile, I2C-Compatible 256-Position,  
> Digital Potentiometer
> TI BQ27350  Single Cell Li-Ion Battery Manager With Impedance Track  
> Fuel Gauge Technology
> 
> Feel free to put my name on the 'New Drivers' page, so no one else  
> needs to start on them.
>
> I have one question that I couldn't find in the docs anywhere.  When I  
> provide a patch, what kernel revision / git repository should I be  
> patching against?   I've been working in a Timesys 2.6.22.9 kernel but  
> I'm happy to merge them with another repo and create patches from there.

These devices do not seem to have anything to do with hardware
monitoring, do they? If not, you're using the wrong mailing list, try
the i2c list instead.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
