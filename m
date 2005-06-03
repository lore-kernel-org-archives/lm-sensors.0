From: johnpol@2ka.mipt.ru (Evgeniy Polyakov)
Date: Fri, 03 Jun 2005 23:34:04 +0000
Subject: [lm-sensors] [0/6] New w1 features.
Message-Id: <20050604013008.05d3bc87@zanzibar.2ka.mipt.ru>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Ben Gardner implemented new features for w1 core
while writing a driver for the DS2482 (an i2c to w1 bridge):

1. added a new I/O function: triplet
A triplet reads two bits and writes a direction bit.  The DS2482
implements this in hardware.
I modified w1_search() to use w1_triplet() at its core.

2. cleaned up the I/O functions to separate emulated vs native w1
support.
A w1 bus master must be able to do one of:
  a. Set and sample the line via write_bit() and read_bit()
  b. Support reset_bus() and touch_bit()
Function set (a) is only needed for emulated devices (ie, a parallel
port).
He hid w1_read_bit() and w1_write_bit() behind w1_touch_bit(), and
changed functions to call touch_bit() instead or read/write_bit().
 
3. Searching is fairly slow - it requires about 200 w1 bit cycles per
device, multiplied by the number of devices on the bus.
He modified the w1_process() to NOT periodically search the bus.
A sysfs entry was added to request a search. (w1_master_search).
To request a search, echo anything into w1_master_search and it'll run
another search.

4.He added a default family so that a slave device will get reported even
if there isn't a driver for that family.

5. He wrote good documentation.

6. I wrote reconnect feature: if on start there are no
registered families all new devices will have defailt family,
later when driver for appropriate family is loaded, slaves,
which were faound earlier, will still have defult family instead 
of right one. Reconnect feature will force control thread to 
run through all master devices and all slaves found 
and search for slaves with default family id and try to reconnect
them.

Signed-off-by: Ben Gardner <bgardner@wabtec.com>
Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>

	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt
