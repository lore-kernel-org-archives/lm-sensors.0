From: jim.cromie@gmail.com (Jim Cromie)
Date: Fri, 31 Mar 2006 21:10:51 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: new vt1211 driver
Message-Id: <442D9ADB.5030303@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0602251324o560dcd61oc55dc703f452a570@mail.gmail.com>
In-Reply-To: <191fb4ca0602251324o560dcd61oc55dc703f452a570@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Rudolf Marek wrote:
> Juerg Haefliger wrote:
>   
>
>>> I'm proposing that some of funcs can be done via macro or 2D array. This
>>> might help to shrink the source code a bit.
>>>       
>> I had it this way in the begining but threw it out for some reasons I
>> can't remember anymore. I'll take a look at it again.
>>     
>
> Maybe Jean have some idea about it too? Or others?
>
>
>   


you might want to initialize 1-D arrays with a series of SENSOR_ATTR_2's

+static struct sensor_device_attribute_2 fan_input[] = {
+       SENSOR_ATTR_2(fan1_input, S_IRUGO, show_fan_input, NULL, 
fn_fan_input, 0),
+       SENSOR_ATTR_2(fan2_input, S_IRUGO, show_fan_input, NULL, 
fn_fan_input, 1),
+       SENSOR_ATTR_2(fan3_input, S_IRUGO, show_fan_input, NULL, 
fn_fan_input, 2),
 };

there are 2 members that you can use to specify indexes;   (paste from 
macro defn)
+         .index = _index,                                      \
+         .nr = _nr

in your callback routine, you obtain those values, and decide what to do 
on that basis.

static ssize_t show_fan_input(struct device *dev, struct 
device_attribute *devattr, char *buf)
 {
       struct sensor_device_attribute_2 *attr = 
to_sensor_dev_attr_2(devattr);
       int idx = attr->index;
       int nr = attr->nr;
    /* how you decide here */
}

By convention, index tells your driver which hardware unit to read.

is offset into the array of sensors as seen in userspace
IE how it appears in sysfs:  /sys/bus/i2c/devices/9191-6620/* on my box.
Drivers typically number their sensors starting from 0 or 1, (I think 
this is to
match the numbering used in the tech-docs, which simplifies driver 
maintenance).
Anyway, if your driver numbers, say FANs, starting at 1, you'd put that 
offset
in the fan-input declaration pasted above. 

The .nr field really has no convention yet - you can encode whatever you 
like
into the value, and use it in your callback.  Ive used nr in a recently 
proposed patch
( hwmon-pc87360-sysfs-combo-callbacks.patch ),  to tell the callback what
attribute of the indexed sensor was requested, so my /* how you decide 
here */
looks like this:

+       switch(nr) {
+       case fn_fan_input:
+               res = FAN_FROM_REG(data->fan[idx],
+                                  FAN_DIV_FROM_REG(data->fan_status[idx]));
+               break;
+       case fn_fan_min:
+               res = FAN_FROM_REG(data->fan_min[idx],
+                                  FAN_DIV_FROM_REG(data->fan_status[idx]));
+               break;
+       case fn_fan_status:
+               res = FAN_STATUS_FROM_REG(data->fan_status[idx]);
+               break;
+       case fn_fan_div:
+               res = FAN_DIV_FROM_REG(data->fan_status[idx]);
+               break;
+       default:
+               printk(KERN_ERR "unknown attr fetch\n");


IOW, decoding nr lets your callback do almost anything (2**8 choices),
and you can reduce the number of discrete callbacks accordingly.
We rely on programmers good judgment to not try combining
floor-wax with dessert-topping ;-)


Is this along the lines of what you were contemplating ?

