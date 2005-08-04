From: jcromie@divsol.com (Jim Cromie)
Date: Thu, 04 Aug 2005 01:45:43 +0000
Subject: [lm-sensors] [patch pc87360 reroll 0/6] sensor-dev-attr rework per
Message-Id: <42F15703.4010909@divsol.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


after stepping back from the 23 patches, it seems theres too many little 
pieces.
So heres a reroll, treating the 5 sensor-types together, since thats 
pretty much
how the code treats them now. (ie repeated patterns).

Hopefully it will all look a bit more rational & discussable now (ie 3rd 
time's the charm)
This time, patches are against 13-rc4-mm1

1.     Yani  form  change.
a.    declare  SENSOR_DEVICE_ATTR, not DEVICE_ATTR
b.    in device_create_file() calls, pass &dev_attr member of the 
sensor-dev-attr type.
c.    in sensor-attr-[gs]etter callback-functions,
     use to_sensor_dev-attr to get sensor_dev_attr *attr
     use attr->index instead of offset
d.   include hwmon-sysfs.h, needed for a.

Note that this isnt a global replace.  Only those attrs that would 
benefit from
having an index have been converted; ie those which are macro-repeated.
  

2.  function renames (preparation for de-macro-ization of getter-setter 
callbacks)
    avoid name-clashes when we de-macro-ize later.

    Currently we have:

    423 #define show_and_set_therm(offset) \
    424 static ssize_t show_temp##offset##_input(struct device *dev, 
struct device_attribute *attr, char *buf    424 ) \
    425 { \

    537 #define show_and_set_temp(offset) \
    538 static ssize_t show_temp##offset##_input(struct device *dev, 
struct device_attribute *attr, char *buf    538 ) \
    539 { \

these are distinguished purely by the ##offset## in the callback name,
which will go away in next patch, so we get ready by changing temp to therm
in the show_and_set_therm macro.

2nd situation is similar, this time with one of the fan callbacks and a 
fan-helper function.

    248
    249 static ssize_t set_fan_min(struct device *dev, const char *buf,
    250         size_t count, int nr)
    251 {

    302 } \
    303 static ssize_t set_fan##offset##_min(struct device *dev, struct 
device_attribute *attr, const char *b    303 uf, \
    304         size_t count) \


3.  convert macro-repeated callback-fns to single declaration
    theyre already using attr->index (patch 1)
    so this is as close as possible to a white-space patch.

4.  callback-fn offset de-skew
    temp, therm, fan, pwm callbacks all have an offset skew in the code
    which accommodates attribute numbering conventions under
    /sys/bus/i2c/devices/9191-6620/   (ie they start at 1)

    here, we move that skew into the declaration, and out of the functions
    (except for therm, where we simpify from 2 skews to 1)
    The declarative skew is clearer, less error-prone, and more efficient.


And for further discussion, as needed...

array initializations

5.  refactor SENSOR_DEVICE_ATTR into declaration = initialization-expression
    __SENSOR_DEVICE_ATTR() expands to init-expr

this imitates  __ATTR in include/linux/device.h,
but is needed cuz of new .index member ( otherwize __ATTR would suffice)

    352 #define DEVICE_ATTR(_name,_mode,_show,_store) \
    353 struct device_attribute dev_attr_##_name = 
__ATTR(_name,_mode,_show,_store)

6.    explicit array initializations

a.   declare arrays, initialize them with repeated __SENSOR_DEVICE_ATTR's
b.   loop over calls to device_create_file()

b  could be done separately, but it seems silly -
    all the calls need to be touched for a anyway, might as well do so 
just once.
    and its not like youd declare an array wo planning to use it.

This patch is motivated/justified by comments from GregKH, in msg 11 of:

http://groups-beta.google.com/group/linux.kernel/browse_frm/thread/fa10a47a3c843d08/2a1465afa2f83afe?q=dynamic+sysfs+callbacks&rnum&hl=en#2a1465afa2f83afe

 > > No, I hate HEAD and TAIL macros.  This really isn't buying you much
 > > code savings, you could do it yourself with the __ATTR() macro
 > > yourself with the same ammount of code I bet...

Hm, which makes me want to go look at trying to convert those attributes
to an array right now...



SO.  all 6 patches compile clean, and test ok, modulo the untestable 
temp stuff on my soekris.

tfyc,
Jim Cromie
