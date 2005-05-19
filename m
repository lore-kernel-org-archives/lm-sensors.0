From: grant_nospam@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:43 +0000
Subject: Query on apparently 'disconnected' sysfs interfaces
Message-Id: <pa6k311f7c2hhul35cifmso9g54ovrnu8c@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greetings,

For the time being I'm stuck on what was expected to be trivial 
completion of a driver port simply because there is something 
confusing me in the source tree.

Instead I seek to clarify current practice vs documentation vs my 
understanding of lm_sensors and l-k drivers.  

Problem: There are many examples of disconnected code fragments 
in the sysfs interface area.

Possibilities?  I'm missing an obscure indirection, cruft in code, 
something else I've not yet thought of.  Also, I'm no preprocessor 
expert, still picking up what the macros are doing from context. 

Given (## = my thoughts) so few drivers are inconsistent, here's 
one example:

grant@peetoo:/usr/src/linux-2.6.11-mm4x$ grep -r show_temp_input *

## attributes defined but not used?
drivers/i2c/chips/max1619.c:static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp_input1, NULL);
drivers/i2c/chips/max1619.c:static DEVICE_ATTR(temp2_input, S_IRUGO, show_temp_input2, NULL);
drivers/i2c/chips/lm75.c:static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp_input, NULL);

## cruft, only one reference?
drivers/i2c/chips/lm77.c:                  show_temp_input, NULL);

## seems correct -- one attribute for one use
drivers/i2c/chips/lm80.c:static ssize_t show_temp_input1(struct device *dev, char *buf)
drivers/i2c/chips/lm80.c:static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp_input1, NULL);

## more attributes defined but not used?
drivers/i2c/chips/lm83.c:static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp_input1, NULL);
drivers/i2c/chips/lm83.c:static DEVICE_ATTR(temp2_input, S_IRUGO, show_temp_input2, NULL);
drivers/i2c/chips/lm83.c:static DEVICE_ATTR(temp3_input, S_IRUGO, show_temp_input3, NULL);
drivers/i2c/chips/lm83.c:static DEVICE_ATTR(temp4_input, S_IRUGO, show_temp_input4, NULL);
drivers/i2c/chips/lm90.c:static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp_input1, NULL);
drivers/i2c/chips/lm90.c:static DEVICE_ATTR(temp2_input, S_IRUGO, show_temp_input2, NULL);
drivers/i2c/chips/adm1021.c:static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp_input, NULL);
drivers/i2c/chips/gl518sm.c:static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp_input1, NULL);

## missing attribute?
drivers/i2c/chips/fscher.c:static ssize_t show_temp_input(struct fscher_data *data, char *buf, int nr)
drivers/i2c/chips/fscpos.c:static ssize_t show_temp_input(struct fscpos_data *data, char *buf, int nr)

My problem at this point is seeing how the driver interfaces to 
sysfs -- finding many exceptions to the 'norm', thus now it seems 
I must find what the non-documented 'norm' actually is, before 
bothering writing to an indeterminate (in my mind) interface.

Is it worth documenting inconsistencies while I try to fathom 
current practice vs documentation?

Are there tools written to perform this or similar checking?
I'd really dislike re-inventing this stuff.  

Another thing I tried was diff'ing -mm4 against -ac4, showed 
where many obvious improvements have been made in -mm4 tree.
Then I got side-tracked back into my current problem space, 
sysfs interface seems not fully documented and/or me confused.  

Cheers,
Grant.

