From: clepple@ghz.cc (Charles Lepple)
Date: Thu, 19 May 2005 06:24:08 +0000
Subject: error: "SMBus collision!"/"sending abort" in 2.6.0test2
Message-Id: <C795CB0D-C30F-11D7-BB43-003065DC6B50@ghz.cc>
List-Id: <lm-sensors.vger.kernel.org>
References: <1D98A118-C22E-11D7-BB43-003065DC6B50@ghz.cc>
In-Reply-To: <1D98A118-C22E-11D7-BB43-003065DC6B50@ghz.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wednesday, July 30, 2003, at 11:56  PM, Mark M. Hoffman wrote:

>> It's an AMD 76x bus controller (i2c-amd76x), and both a W83627HF and a
>> W83782D chip controlled by the w83781d driver.
>
> Ummm...  Google comes up empty on "i2c-amd76x"... do you mean 
> i2c-amd756?

i2c-amd756 (confusion due to excessive hacking on amd76x_pm, which was 
the motivation for getting lm_sensors working).

from lsmod:

$ lsmod
Module                  Size  Used by
processor              14888  0
amd76x_pm               6300  0
button                  6104  0
ohci_hcd               19072  0
usbcore               112988  3 ohci_hcd
w83781d                35584  0
i2c_sensor              3200  1 w83781d
i2c_amd756              5700  0
i2c_core               24648  3 w83781d,i2c_sensor,i2c_amd756
eepro100               30796  0
mii                     5120  1 eepro100
rtc                    13892  0

>> This setup requires the crazy init=0 and force_subclients deal that
>> other 760MP chipset users have reported in the trouble ticket area.
>>
>> Driver version is 2.7.0 (20021208). I haven't gotten around to making
>> 2.8.0 work with the 2.6 kernel.
>
> Now I'm lost:  How could you be using w83781d.c version 2.7.0 with the
> 2.6 kernel?  Either you hacked it to pieces (needlessly, since it
> was already ported to 2.6) or I am totally not understanding you.

sorry about that. I searched back from the "SMBus collision" error 
message in kern.log, and the first occurrence of "i2c" that I came 
across turns out to be from the last time I booted 2.4.21 (with 
lm_sensors/i2c 2.7.0 as provided by Debian). I kind of expected the 
2.6.0-testX in-kernel drivers to print version numbers as well (or at 
least, some version/date info).

> Please explain in detail what you did to build this system.

First, I got the i2c.tar.gz and lm-sensors.tar.gz files from Debian, 
and compiled 2.4.21 (with ACPI patches, FWIW). Then I downloaded 
2.6.0-test2 and compiled that. I've been flipping back and forth 
between 2.4.21 and 2.6.0-test2, and that led to my confusion.

>>> I would like to try to reproduce this, but not until this weekend.
>>> Would running 2-3 shell scripts simultaneously which cat the /sys
>>> values to /dev/null be good enough?

Now I'm wondering if there needs to be writing involved before things 
break. I have between 15 and 20 'cat random_sensor_file' commands 
running at the moment (all within 'while true; do ... done' loops), and 
things seem to be working. Load average is sitting near 17, but abort 
messages, and the values seem to be changing normally.

Sorry to bug you folks with such sketchy details... I'll let you all 
know if things break again.

-- 
Charles Lepple <clepple@ghz.cc>
http://www.ghz.cc/charles/
