From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:58 +0000
Subject: News about PC87366
Message-Id: <20040516104801.568f2ad0.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Sandeep,

Here are the latest news about my pc87360 driver. I've also found some
information about your motherboard.

I couldn't find anything relevant about your exact motherboard reference
(P4B-LA). However, searching the web pointed me to two alternate
references that are probably almost similar: P4U-LA and P4B-MX.

http://h10025.www1.hp.com/ewfrf/wc/genericDocument?lc=en&cc=us&docname=bph07293

http://usa.asus.com/prog/spec.asp?m=P4B-MX

Does any of these motherboard layouts match yours?

There is a BIOS setup screenshot in the P4B-MX manual, presenting two
temperatures, three fan speeds and six voltages. This is a first hint of
what we can expect to obtain from your chip (especially for the
voltages, for which we still don't know the order and conversions).

Do you have any idea of what the VCore voltage should be for your
system? This is the one to start with since it doesn't need any
conversion.

I have been fixing a few incorrectnesses in the driver, updating the
default sensors.conf file, and adding two new features to the driver:

* The "init" module parameter lets you have the driver forcibly enable
more or less monitoring channels of the chip.

* The dynamic fan clock divisor allows the driver to select the best fan
clock divisor for the fan speed and min limit. You don't have to set the
divisor by yourself. At the moment, I've left that second possibility
(the fan_div file is still there and writable) for testing purposes, but
it will be gone before I release the driver.

I would like you to get the latest CVS version and do the following
things:

1* Copy etc/sensors.conf.eg to /etc/sensors.conf. It is important that
you have an up-to-date configuration file with no ignore lines for the
following tests.

2* Compile the driver with DEBUG enabled.

3* Get my dumper script from
http://jdelvare.net1.nerim.net/sensors/pc87366/dump-pc87366.sh
and run it from an empty directory. It'll dump the contents of your chip
and build a tarball with the results.

4* Load the driver with "modprobe pc87360". Run sensors -s && sensors,
save the output somewhere.

5* Unload the driver, reload with "modprobe pc87360 init=3". This will
forcibly enable all temperature and voltage channels. Run sensors again.

6* Run the dumper script again, in a different empty directory so that
it doesn't overwrite the previous files.

And of course send me all the generated files.

As for the auto fan clock divider selection, you should observe the
following phenomenons:

1* Dividers auto adjust. If you write dividers with "echo X Y Z >
fan_div", running sensors will shift them if needed, one step each time,
until the driver likes what it gets.

2* Setting a fan min that does not fit with the current divisor will
increase the divisor as needed. For example, if you try "echo 800 >
fan2", the divisor should become 4, automatically. And it should stay
that way until you change to a higher min limit.

In any case, min fan settings should be preserved (unless you are
writing a new one, of course).

Don't bother trying PWM, I have not changed anything there. I think
there's something weird on your board that I cannot fix by the mean of
software :( PWM seems to be working as intended for my other tester.

I think that's all. Thanks a lot for testing!

-- 
Jean Delvare
http://khali.linux-fr.org/
