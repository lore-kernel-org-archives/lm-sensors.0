From: Jonathan Cameron <Jonathan.Cameron@gmail.com>
Date: Tue, 20 May 2008 10:04:01 +0000
Subject: [lm-sensors] Accelerometer, Gyros and ADC's etc within the kernel.
Message-Id: <4832A211.4040206@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: LM Sensors <lm-sensors@lm-sensors.org>, spi-devel-general@lists.sourceforge.net

This email is basically a request for opinions on how and where such sensors
should be integrated into the kernel.

To set the scene...

Increasing numbers of embedded devices are being supplied attached MEMS
devices (www.xbow.com imote2 etc). Along with more traditional sensors such
as ADC's not being used for hardware monitoring, these do not really 
seem to
fit with in an particular subsystem of the kernel.  A previous 
discussion on
lkml in 2006 considered the accelerometers to be found within some laptop
hard drives, but I haven't been able to track down any more general 
discussions
of such non hardware monitoring sensors.

The obvious possibilities are:

* To place the various drivers within the spi / i2c etc subsystems as 
relevant.

* To place within the hwmon subsystem as this is probably closest.
(there is already at least one straight ADC driver in hwmon)

* To create a new subsystem, or perhaps merely sysfs class to contain these
  elements.

Typical requirements within an application include simply polling for 
current
readings, and using device triggered interrupts to grab data 
continuously to a
ring buffer, for collection by suitable userspace code.  Obviously it 
would be
desirable to standardize sysfs controls for various calibration 
parameters as
much as possible across the various devices.

Any other suggestions welcome!

To illustrate the sort of devices here are a few I have drivers written 
for or will
shortly be writing  (some submitted to hwmon and spi mailing lists, some 
not
finished as of yet)

ST Micro LIS3L02DQ 3D accelerometer.  SPI device, no buffering, 
interrupt pin
raised high on new data being available. Currently the driver assumes, if
interrupts are enabled, that this is connected to a specified gpio.
(http://www.st.com/stonline/books/pdf/docs/10175.pdf)

VTI SCA3000 E05 3D accelerometer equiped with substantial ring buffer. SPI
device.  Can operate either in buffered or direct mode.  In buffered 
mode, interrupts
can be used to indicate when the ring buffer is 3/4 full triggering a 
download to
a larger ring buffer in the kernel if necessary.
(http://www.vti.fi/en/products-solutions/products/accelerometers/sca3000-accelerometers/)

Analog Devices ADIS16350 combined 3D accelerometer and gyro unit.  SPI 
device.
(http://www.analog.com/en/prod/0,,764_801_ADIS16350%2C00.html)

Maxim MAX1363, MAX1238 ADC's.  I2C devices. Some SPI ADC's 
(www.analog.com for
examples)

Would be nice if practical to allow the framework to include RS232 
devices such
as those from www.xsens.com, www.isense.com and others.

--
Jonathan Cameron



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
