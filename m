From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:25:19 +0000
Subject: Adding S4882 support to the i2c-amd756 driver
Message-Id: <417313CE.4050209@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041017222721.1f12466d.khali@linux-fr.org>
In-Reply-To: <20041017222721.1f12466d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

How does the multiplexing work on the S4882 motherboard?  Is it 
controlled by GPIO pins or is there an I2C mux chip on the I2C bus?

What devices are on the different branches of the I2C bus?

If we could come up with a "wrapper" model of an i2c bus driver for 
these mux situations that seems to me to be the ideal.  Such a wrapper 
would capture the knowledge of how to mux the bus and what branch of the 
mux is currently selected.  It would register multiple "virtual" i2c 
busses and mark the "parent" i2c bus as no-probe and in general attempt 
to prevent anything from accessing the parent bus directly.

Then our normal sensor drivers would just operate on the "virtual" 
busses directly and the wrapper would take care of changing the mux as 
required in an *atomic* way so that accesses are made to the different 
busses correctly.

:v)

Jean Delvare wrote:

>Hi all,
>
>As mentioned some days ago, I am in the process of adding support for
>the Tyan S4882 motherboard to lm_sensors.
>
>The support for the LM63 monitoring chip is already in, nothing
>particular to say about that.
>
>The SMBus support is a bit trickier though, since the board uses
>multiplexing. For now, I added support directly into the i2c-amd756
>driver. Since it increases the size of the driver, I made the extra code
>optional (will show as an option when configuring the kernel, or can be
>manually switched on and off when compiling directly in the lm_sensors
>tree; default is to include support).
>
>The size isn't necessarily a problem, since the driver is small to start
>with, and the overhead is small as well (in absolute size, that is).
>However, Mark M. Hoffman objected that in the interest of
>maintainability, separating the S4882-specific code would be better. I'm
>all for that, but my attemps to do so did all fail so far.
>
>* Composite module
>I don't know how this can be done in the lm_sensors tree. Hint anyone?
>
>* Separate module
>My initial attempt to have a separate i2c-amd756-s4882 module works in
>that the code belongs to a different file. However, both modules will be
>loaded in all cases, whether the board is a S4882 or not, because the
>main module has references to functions belonging to the extra module. I
>think it might be a little confusing for the user. The correct approach
>would be to have three modules: 1* main code, 2* pci detection for
>regular boards and 3* pci detection + extra code for the S4882. Having
>three different modules sound overkill. Also, this would probably
>involve renaming files and modules, which will make things even more
>confusing for everyone, and significant changes to the original code.
>I'm not going into that.
>
>So I think I will stick to my original plan to simply include the extra
>code in the main driver. If anyone object, please tell me how I can
>either do a composite module in the lm_sensors tree (one single module
>made of two source files), or any other way to have things done more
>cleanly.
>
>Note: All this is for 2.4/CVS only. For 2.6, Mark M. Hoffman is working
>on a completely different approach for multiplexing support, and I will
>wait for his proposal and build my work on top of that.
>
>Thanks.
>
>  
>

