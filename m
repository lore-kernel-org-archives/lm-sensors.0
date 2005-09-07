From: jim.cromie@gmail.com (Jim Cromie)
Date: Wed, 07 Sep 2005 07:24:38 +0000
Subject: [lm-sensors] [patch 0/2] pc87360 dynamic sysfs attr arrays - readme
Message-Id: <200509070523.j875NLU4013020@harpo.jimc.earth>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Now that the pc87360 dynamic sysfs attr patches are accepted by Greg,

this presents a 2 patch set to convert sequentially named
sensor_device_attributes to proper arrays.  Doing so saves a few lines
of code (but visually simplifies it), and about 14kb of object-size vs
accepted version.


 sda-array-1/include/linux/hwmon-sysfs.h |   20 +
 sda-array-2/drivers/hwmon/pc87360.c     |  346 ++++++++++++++------------------
 2 files changed, 174 insertions(+), 192 deletions(-)

-rw-rw-r--  1 jimc jimc 241624 Sep  5 06:59 orig/drivers/hwmon/pc87360.ko
-rw-rw-r--  1 jimc jimc 161736 Sep  6 22:58 accepted/drivers/hwmon/pc87360.ko
-rw-rw-r--  1 jimc jimc 147044 Sep  6 22:58 next/drivers/hwmon/pc87360.ko


01

split SENSOR_DEVICE_ATTR* into 2 parts: SENSOR_DEVICE_ATTR*, which
declares a struct sensor_device_attribute variable and initializes it
to the value of __SENSOR_DEVICE_ATTR*, which expands to an
initialization expression.

02

replace uses of SENSOR_DEVICE_ATTR with an explicit declaration of a
struct sensor_devie_attribute array[], and use a number of calls to
__SENSOR_DEVICE_ATTR() to initialize each element.

This allows us to replace long blocks of calls to device_create_file()
with a a single call in a loop over that array.


Discussion of alternatives

the ideal solution to sensor-device-attribute setup has a few
properties:

1. its done at compile-time
2. its declarative (really same thing as 1)
3. it uses arrays, allowing initializtions in loops
4. compact code

current implementation does 1,2, but not 3.

Jean Delvare cooked up a HEAD, TAIL declarative scheme, but Greg KH
didnt like it.

http://groups.google.com/group/linux.kernel/browse_frm/thread/fa10a47a3c843d08/0aaffa4d92acbe0e?q=dynamic+sysfs+callbacks+HEAD+TAIL&rnum=1&hl=en#0aaffa4d92acbe0e

I should note that patch 01 has similarities to Jeans
SENSOR_DEVICE_ATTR_ARRAY_ITEM, but the separate initialization
expression allows its use in a straight array declaration, eschewing
the obfuscation that HEAD, TAIL creates.


My patches above manage to keep properties 1,2,3 but are not
particularly compact.  I do think theyre clear, and really no bigger
than Jeans HEAD, TAIL approach.  Essentially, the size is determined
by the number of initialization-expressions inside the curly brackets.




An alternative is to forego compile-time initialization, and do it
with a helper function that takes an initialized structure as a
template, and does memcpy + fixup to each element.

I see several variations, each with some problems.

A) declare pointers, call helper func to allocate space and initialize
the elements.  

static struct sensor_device_attribute* 
sda_init(struct sensor_device_attribute template, int skew, int size)
{
  int i;
  struct sensor_device_attribute *store = kmalloc(size * sizeof(template),
						  GFP_KERNEL);

  for (i=0; i<size; i++) {
    memcpy(store+i, &template, sizeof(template));
    store[i].index = i;
    snprintf(store[i].dev_attr.attr.name, THE_RIGHT_SIZE, 
	     template.dev_attr.attr.name, i + skew);
  }
  return store;
}

static sensor_device_attribute *sda_fan_input, *sda_fan_status;

static int __init sda_structs_init(void) // called from module-init
{
	struct sensor_device_attribute 
	fan_in   = __SENSOR_DEVICE_ATTR(fan%d_input, S_IRUGO, show_fan_input, NULL, 0),
	fan_stat = __SENSOR_DEVICE_ATTR(fan%d_status, S_IRUGO, show_fan_status, NULL, 2),
	// etc ;

	sda_fan_input  = sda_init(fan_in,   1, 3);
	sda_fan_status = sda_init(fan_stat, 1, 3);
	// etc
}

Initialization is somewhat cumbersome though; each array needs a
template created for it, which is used then thrown away.  (cant pass
an initialization expr in, must be a variable)

Also, the above doesnt allow initializtion w/o allocation, which precludes
re-initialization of part of an array for other purposes.  Its not clear
that this is needed or desirable.

In the above, the template name is expected to be intialized as the
snprintf format, ex "fan%d_input", making the function more generic.
FWIW, the func doesnt really need the skew, it could borrow the index
for that, but well skew is clearer.



B) declare the arrays with desired size, and initialize 1 element,
using __SENSOR_DEVICE_ATTR().  helper-func copies and fixes each

This avoids the temporary template structs, and puts the template
initializer next to the array declaration.  But it does require that
the size used in the calls to sda_init matches the declared size.

With some limitations, this approach also can support heterogeneous
intializations; if >1 elems are initialized in the declaration itself,
the index can be taken as a starting-index, and used to initialize up
from there.  This requires that the elems are done backwards, so that
2nd block of inits is done before the 1st block overwrites the 2nd
template.



A & B are wood-men, (ie strawmen, just a little more robust).  Still
flammable though, and presented mostly as an alternative to the
mechanism provided in the patches.

Ill work up a patch for the the better of A or B (my pref, more
capable, less verbose) if theres interest.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
