From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sat, 18 Jun 2005 21:34:41 +0000
Subject: [lm-sensors] Configuring I2C on a Thinkpad T42
Message-Id: <42B47731.4080000@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <42AF040C.8090109@earthlink.net>
In-Reply-To: <42AF040C.8090109@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi

> I have a Thinkpad T42, and as far as I can tell, it has an Intel 82801
> SMBus (which I gather from the output of lspci), and a National
> Semiconductor PC87591 sensors chip (which I read at
> http://archives.andrew.net.au/lm-sensors/msg31277.html).

I think we do not have the driver for this chip yet.

> I'm not completely new to Linux, but I don't know much about I2C,
> although I've read some of the basics.  From what I understand, I2C can
> be used by lm-sensors, and possibly by ACPI. 

Lm-sensors talk to chips directly. ACPI is a framework between operation system and hardware. It used for powermanagent and
also temps/fans control in notebooks.

> I've read ominous things about lm-sensors in regards to Thinkpads (at
> http://www.thinkwiki.org/wiki/Problem_with_lm-sensors), but I don't know
> if this means that I should abandon trying to get any benefit from the
> I2C bus.

There is a security EEPROM connected to i2c which will be corrupted if you scan the bus. BIOS will disallow to start the
notebook and your motherboard will need to be replaced.

> Here's a few questions I have:
> 
>    1. Do I need to have the kernel configured for /both/ hardware bus
>       support /and/ sensors chip support to get any value out of I2C, or
>       is it possible there are other devices on the bus that might be of
>       service?

You need the bus driver to talk to devices connected to a bus. You can just abstract the I2C bus as a network connected chips
every chip with some address. Each chip has some accessible registers which chip drivers understand.

>    2. Is there any great way to confirm that Thinkpad T42's actually
>       have a NS PC87591 sensors chip?  I was hesitant to run the
>       sensors-detect on my Thinkpad because of sharp warnings I found
>       on-line.


This is EXTREMLY DANGEROUS !!!!!!!!!!!!
I think you can run it ONLY IF you delete i2c-i801 module AND DO NOT ALLOW to SCAN i2c/SMBUS. (or compile kernel WITHOUT i2c bus drivers
support)

****************************************
If you will ALLOW it YOUR MOTHERBOARD IS LIKELY needed to be replaced ant it will COST you a LOT of money.
****************************************

DO NOT TRY IT if ACPI works for you.

acpi -V

should show the temps. And that is what you need ;)


>    3. If I can't use lm-sensors on a Thinkpad, does ACPI rely at all on
>       I2C?  If so, what kind of configuration do I need to set that up
>       (kernel-wise or user-space-wise)?

It may use I2C to get battery status etc... If you want to use ACPI you should configure your kernel see ACPI-HOWTO for details.

>    4. How should I test that I2C is working when everything's all set up?

Do not try to play with I2C on you thinkpad.

> I appreciate any feedback you can provide, even if just pointing me
> towards other resources.

Try google to find something about I2C you can start at Philips web site.

Regards

Rudolf


