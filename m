From: jcromie@divsol.com (Jim Cromie)
Date: Mon, 27 Jun 2005 17:29:55 +0000
Subject: [Re: patch for pc87366_gpio]  Was: [lm-sensors] code question on
Message-Id: <42C01B52.300@divsol.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jim Cromie wrote:

> Jean Delvare wrote:
>
>>
>> Search for request_region()/release_region() in pc87360.c.
>>
> thanks.
>
> Got it working. Now writes pins (problem was not reservation related)
> Patch-set attached, comments welcome.


Apologies, for not sending doc on those patches, and for not changing 
subject on last send.
Ill post to Kernel-Mentors too, but Im hoping folks here can try it on a 
real chip.

tia
jimc




[jimc@harpo lxbuild]$ more notes-v2-scx

I have a soekris net4801 - it has a GEODE (sc1100) cpu and a pc87366
Super-IO device.  Both those parts were made by Natsemi (GEODE is now
AMD, pc87366 now Winbond), but both have a GPIO unit in them.

The GPIO unit is similar for both parts, and the scx200_gpio module
currently works on the pins in the geode.  Ive extended it to work for
the Super-IO GPIOs too.

Ive split scx200_gpio into 2; nsc_gpio has common file-operations
methods, scx200_gpio now contains access methods specific to the
pci-device interface on that part.

pc87360_gpio also uses nsc_gpio, and adds its own access methods for
the Super-IO, ISA interface.


All testing was done by watching LED and syslogs, while watching this
script run:

loudly() { echo "doing $*"; $* }
loudly rmmod scx200_gpio pc87366_gpio nsc_gpio scx200
loudly modprobe pc87366_gpio
loudly modprobe scx200_gpio
echo 1 > /dev/led
sleep 1
echo 0 > /dev/led
sleep 1
echo 1vvvvvvvvvvvvvvvvvvc0 > /dev/led
loudly cat /proc/devices
echo Ovc > /dev/io-red          # output enable
echo Ovc > /dev/io-brown        # output enable
echo 0vc > /dev/io-red          # drive low
echo 0vc > /dev/io-brown        # drive low
echo 1vc > /dev/io-red          # drive hi
echo 1vc > /dev/io-brown        # drive hi
echo ovc > /dev/io-red          # output disable
echo ovc > /dev/io-brown        # output disable


I did additional electrical tests as well (grounding a pulled-up
input, seeing cat /dev/io-red change accordingly), and multi-meter
tests of output.


Separate messages will follow to describe the N patches, this
introduces them quickly, as an overview.


diff.scx-01-dump-diet                   reduce size of scx200_gpio_dump()
diff.scx-02-init-shadow-refactor        inline code -> function, prep 
migration
diff.scx-03-viewpins                    new write 'command',  error checks
diff.scx-04-api26                       __devinit -> __init, 
pci_register_driver
diff.scx-05-access-vtable               add, intialize access methods vtable
diff.scx-06-vtable-calls                use access methods vtable
diff.scx-07-nscgpio-shell               add empty common module, alter 
makefile
diff.scx-08-migrate-fops                move common file-ops, export, 
add prototypes
diff.scx-09-cleanup-fops                change file-op fn names to match 
new home
diff.scx-10-pc87366                     new module
diff.scx-11-common-dump                 move scx200_gpio_dump to 
nsc_gpio.c, call it
diff.scx-12-print-formats               consistent printk formats in 
gpio_write
diff.scx-13-pin-config-view             improve viewpins: c=pin-config, 
v=pin-value
diff.scx-14-quiet-getset                remove getset debugging prints


1. diff.scx-01-dump-diet

This patch shrinks scx200_gpio_dump() in arch/i386/kernel/scx200.c by
recoding series of if-then-elses to conditional expressions within
single printk.

By consolidating all printks into one, with conditional expressions.
The function shrinks by this amt, approximately;

new:    000000a0 00000089 T scx200_gpio_dump
old:    000000a0 0000013d T scx200_gpio_dump


the only difference between new and old is before 'EDGE', where theres
now 2 spaces where 'LOCKED' would be printed if the pin config were
locked down.

May 26 18:44:05 soekris kernel: scx200_gpio: GPIO-21: 0x00000002 TS PP 
PUD  EDGE LO
May 26 18:44:05 soekris kernel: scx200_gpio: GPIO-21: 0x00000000 TS OD 
PUD  EDGE LO
May 26 18:44:05 soekris kernel: scx200_gpio: GPIO-21: 0x00000004 TS OD 
PUE  EDGE LO


2. diff.scx-02-init-shadow-refactor

in arch/i386/kernel/scx200.c, scx200_probe() has code to initialize
GPIO shadow registers from the hardware.  this patch factors that code
out of scx200_probe(), and into its own function.

This declutters for possible migration of function into scx200_gpio.c


3. diff.scx-03-viewpins

Extends scx200_gpio_write to respond to several new 'command' which
are characters written to the device-file.  'v' now causes
scx200_gpio_dump to print pin configuration to syslog.

Patch also removes ifdef around scx200_gpio_dump in scx200.c, and
exports it for use in scx200_gpio.

Purpose is so that when users alter configuration settings on a pin,
they can cause each change to be logged to /var/log/syslog (or whatever)

doing: modprobe scx200_gpio
scx200: NatSemi SCx200 Driver
scx200: GPIO base 0x6100
scx200: Configuration Block base 0x6000
scx200: GPIO-20: 0x00000003 OE PP PUD  EDGE LO
scx200: GPIO-20: 0x00000003 OE PP PUD  EDGE LO

soekris:~/pinlab# echo TvtvPvpvOvov > /dev/led
scx200_gpio: GPIO20 output is push pull
scx200: GPIO-20: 0x00000003 OE PP PUD  EDGE LO
scx200_gpio: GPIO20 output is open drain
scx200: GPIO-20: 0x00000001 OE OD PUD  EDGE LO
scx200_gpio: GPIO20 pull up enabled
scx200: GPIO-20: 0x00000005 OE OD PUE  EDGE LO
scx200_gpio: GPIO20 pull up disabled
scx200: GPIO-20: 0x00000001 OE OD PUD  EDGE LO
scx200_gpio: GPIO20 output enabled
scx200: GPIO-20: 0x00000001 OE OD PUD  EDGE LO
scx200_gpio: GPIO20 output disabled
scx200: GPIO-20: 0x00000000 TS OD PUD  EDGE LO

Once this patch is in, another can remove the unconditional printks
(the intervening lines) that notify of each pin-config change, since
user can just add 'v' to every command they want.


4. diff.scx-04-api26

call pci_register_driver() from module init.  Note that
pci_unregister_driver was already used in original

Change some __devinit to __init, since the pci device is on-chip with
the CPU, it cant be usefully hotplugged.


5. diff.scx-05-access-vtable

create new header-file nsc_gpio.h, with gpio_access_methods vtable.
In scx200_gpio.c, create and initialize the vtable with the access
methods defined in scx200_gpio.h


6. diff.scx-06-vtable-calls

alter scx200_gpio.c:open() to set file->private_data with addr of
vtable added in previous patch.

use the private_data to invoke the access-methods in read(), write(),
release()


7. diff.scx-07-nscgpio-shell

create empty module to eventually hold common file-operations
routines, which will be moved verbatim from scx200_gpio in next patch.
Empty module includes commented out EXPORT-SYMBOLs in prep for the
move below.  Add it to Makefile


8. diff.scx-08-migrate-fops

move the functions.  uncomment the exports.
add function signatures to header-file.


9. diff.scx-09-cleanup-mv

do post-move cleanup;
  rename the functions consistent with new home.
  change vtable init to match.


10. diff.scx-10-pc87366

add new driver module, pc87366_gpio:
  use common file-operations, as done for scx200_gpio
  define access_methods, initialize vtable with them

some tests, and resulting output:
(the O/o - is output enable/disable, the 0/1 - is write zero/one)

echo Ovc > /dev/io-red
echo Ovc > /dev/io-brown

echo 0vc > /dev/io-red
echo 0vc > /dev/io-brown
echo 1vc > /dev/io-red
echo 1vc > /dev/io-brown

echo ovc > /dev/io-red
echo ovc > /dev/io-brown


pc87366_gpio open 11
pc87366_gpio: addr:6604 cur:df bit-pos:3 cur-bit:d7 + new:0 -> bit-new:0
pc87366_gpio: gpio_set(minor:11 port:1 bit:3) df -> d7
pc87366_gpio: wrote d7, read: d7
nsc_gpio: GPIO-11: 0x00000045 OE OD PUE  EDGE LO DEBOUNCE
nsc_gpio: GPIO-11 bad setting: chr<0x63>
pc87366_gpio open 10
pc87366_gpio: addr:6604 cur:d7 bit-pos:2 cur-bit:d3 + new:0 -> bit-new:0
pc87366_gpio: gpio_set(minor:10 port:1 bit:2) d7 -> d3
pc87366_gpio: wrote d3, read: d3
nsc_gpio: GPIO-10: 0x00000045 OE OD PUE  EDGE LO DEBOUNCE
nsc_gpio: GPIO-10 bad setting: chr<0x63>
pc87366_gpio open 11
pc87366_gpio: addr:6604 cur:d3 bit-pos:3 cur-bit:d3 + new:1 -> bit-new:8
pc87366_gpio: gpio_set(minor:11 port:1 bit:3) d3 -> db
pc87366_gpio: wrote db, read: db
nsc_gpio: GPIO-11: 0x00000045 OE OD PUE  EDGE LO DEBOUNCE
nsc_gpio: GPIO-11 bad setting: chr<0x63>
pc87366_gpio open 10
pc87366_gpio: addr:6604 cur:db bit-pos:2 cur-bit:db + new:1 -> bit-new:4
pc87366_gpio: gpio_set(minor:10 port:1 bit:2) db -> df
pc87366_gpio: wrote df, read: df
nsc_gpio: GPIO-10: 0x00000045 OE OD PUE  EDGE LO DEBOUNCE
nsc_gpio: GPIO-10 bad setting: chr<0x63>
pc87366_gpio open 11
nsc_gpio: GPIO11 output disabled
nsc_gpio: GPIO-11: 0x00000044 TS OD PUE  EDGE LO DEBOUNCE
nsc_gpio: GPIO-11 bad setting: chr<0x63>
pc87366_gpio open 10
nsc_gpio: GPIO10 output disabled
nsc_gpio: GPIO-10: 0x00000044 TS OD PUE  EDGE LO DEBOUNCE
nsc_gpio: GPIO-10 bad setting: chr<0x63>

The bad setting: lines are feedback that the driver didnt understand 'c' 
yet.


11. diff.scx-11-common-dump

refactor {scx200,pc87366}_gpio_dump, moving the common printk() to
nsc_gpio_dump, leaving just the (access-method dependent) config fetch
remaining.


diff.scx-11-common-dump                 move scx200_gpio_dump to 
nsc_gpio.c, call it

12. diff.scx-12-print-formats

Cosmetic changes; shorten 8char hex-print to 2, matching byte of config 
data.
More consistent printk formats in gpio_write.

13. diff.scx-13-pin-config-view

Tweak improve viewpins commands'

'c' show pin-config (was v)
'v' show pin-value (will show driven, read)

this cleans up the 'bad setting' seen in earlier sample output


14. diff.scx-14-quiet-getset

Remove pin-set/get debugging prints seen above.
Also silences open()s printk.

nsc_gpio: GPIO-11 is 0
nsc_gpio: GPIO-11: 0x45 OE OD PUE  EDGE LO DEBOUNCE
nsc_gpio: GPIO-10 is 0
nsc_gpio: GPIO-10: 0x45 OE OD PUE  EDGE LO DEBOUNCE
nsc_gpio: GPIO-11 is 1
nsc_gpio: GPIO-11: 0x45 OE OD PUE  EDGE LO DEBOUNCE
nsc_gpio: GPIO-10 is 1
nsc_gpio: GPIO-10: 0x45 OE OD PUE  EDGE LO DEBOUNCE
nsc_gpio: GPIO-11 output disabled
nsc_gpio: GPIO-11: 0x44 TS OD PUE  EDGE LO DEBOUNCE
nsc_gpio: GPIO-10 output disabled
nsc_gpio: GPIO-10 is 1
nsc_gpio: GPIO-10: 0x44 TS OD PUE  EDGE LO DEBOUNCE


