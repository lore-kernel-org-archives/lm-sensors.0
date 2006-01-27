From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Fri, 27 Jan 2006 20:15:30 +0000
Subject: [lm-sensors] Patch: abituguru driver version 1.1.1
Message-Id: <43DA7F62.7060200@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <43AD5940.1090900@hhs.nl>
In-Reply-To: <43AD5940.1090900@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

Rudolf Marek wrote:
> Hello Hans,
> 
> lm-sensors kernel patch: nobody cared!
> 
> I will try to review your work.
> Here we go. Quite big driver. I will now give some remarks that are general for the driver:
> 

First of all many many thanks for taking the trouble to review my driver.

> 1) CodingStyle is sometimes different than what you did in a driver, typically no spaces between operators
Hmm, I've read codingstyle (again) and it says _nothing_ about this, the
examples though do have spaces around all the operators, I assume this
is what you mean I've added space's to most places now.

> 2) we need dev_dbg dev_warn etc structures
Agreed, done.

> 3) history belongs to do documentation and cannot be acceptred in the driver by mainline kernel folks
Moved to a ChangeLog file.

> 4) we need a "datasheet" for uGuru, something that Olle already wrote. Please extend it and make it part
>    of documentation. It was very hard to read the driver without knowing what bank registers are doing
Grumble, its reverse engineered, the code is the documentation. I've
tried to make the code as clear as possible (really I did). Anyways I've
Olle's docs I'll extend them.

> 5) You should consider separating some arrays to structures or unions, it makes very difficult to understand what is going on, when the names for
>     referencies and actual values are similar.
There's a comment above all the show/store functions how the 2
sensor_device_attribute_2 parameters (nr and index) are used to address
the arrays. I need to use arrays to keep the show/store functions
somewhat generic. Actually before you someone else did a quick scan
review and he asked if I couldn't make them even more generic and thus
halve the amount of them as I now have a bank1 and bank2 version of
each. I refused because I believe the current version of the code
strikes a good balance between:
-readability
-reducing code duplication
-memory usage

> 6) Try to use some macros for repetitive code. (or for conversion of values, not neccessary for whole bunch of functions),
>    it may happen that the macro will explain what the array magic reference is doing ;)

I've taken a look at the conversion code, but there is hardly any
duplication, its all (subtly) different.

> 7) sync to mainstream lm-sensors technology -> mutex stuff and maybe to reflect the ISA and sysfs changes?

I'll move over to the new mutex stuff, I couldn't have done that in my
last version since that was posted to the list before the mutex change.
What ISA and sysfs changes do you mean?

> 8) I think comments are important especially when there is no datasheet, please can you add some? Like what for are those generic functions
>    etc etc...
> 
I've added comments to the generic functions and I'll try to create a
small datasheet really I promise.

> The alarms proposal sounds good to me, but I would like others here come up with the comments.
> 
Good to hear it sounds good, can you poke the others a bit to take a
look (I know they should be reading this its on the list) .

> Please check my comments in the driver.
> 

I've responded to your comments below (except the dev_dbg stuff, all the
printk's have been replaced).


> I hope this helps.

Sure does, I hope you like the new version, see attachment.

Thanks & Many more Thanks & Regards,

Hans


>> /*
>>     This driver supports the sensor part of the custom Abit uGuru chip found
>>     on Abit uGuru motherboards. Currently it has been tested on an Abit KV8
>>     Pro, AV8, AX8 and AN8-SLI. The openguru program this driver is based on
>>     has also been successfully tested on: Abit AV8 3rd Eye, AN8 Ultra and AN7.
>>     
>>     Unfortunatly there are no specs for this chip, this driver is based on the
>>     (reverse enginered) openguru program by Olle Sandberg <ollebull at gmail.com>.
>>     You can find the first version of his program which only supports reading
>>     the sensors not the min/max values at:
>>     http://hem.bredband.net/b330708/oguru/oguru.tar.gz
>>     I would like to express my thanks to Olle, this driver couldnot have been
>>     written without his efforts.
>>     
>>     Because of the lack of specs only the sensors part of the uGuru is
>>     supported. A word of caution to those who want to experiment and see if
>>     they can figure the voltage / clock programming out, I tried reading and
>>     only reading banks 0-0x30 with the reading code used for the sensor banks
>>     (0x20-0x28) and this resulted in a permanent reprogramming of the voltages,
>>     luckily I had the sensors part configured so that it would shutdown my
>>     system on any out of spec voltages which proprably safed my computer (after
>>     a reboot I managed to immediatly enter the bios and reload the defaults).
>>     This probably means that the read/write cycle for the non sensor part is
>>     different from the sensor part.
>>     
>>     This driver used via686a.c as a skeleleton since that is an ISA only chip
>>     like the Abit uGuru (AFAIK).
> 
> This info should go to Documentation/hwmon/uguru file. I asked Olle also for a one with
> register set. Please can you move all info there and create there simple datasheet?
> 

Will do.

> 
>> */
>> /*  History:
>>     
>>     version 1.1.1:
>>     -Show voltages ona 0-3493 mV scale instead of as a registervalue multiplied
>>      by 1000.
>>     -Change all the sysfs stuff from struct sensor_device_attribute to
>>      sensor_device_atribute_2 make settings array 2 dimensional as it ought to
>>      be and use index and nr to address the settings array. Remove all the
>>      glue functions for mask stuff and use attr->nr as mask.
>>     -Split alarms_in in alarms_in_low and alarms_in_high, same
>>      for alarms_mask_in.
>>     -Undo 1.1.0 change of not reading the settings in abituguru_update for
>>      bank1 settings, as the settings are needed to differentiate between low
>>      and high alarms.
>>     -Rename pwm sysfs files to match sysfs-interface file from the kernel
>>      Documentation, rename mask files to match sysfs-interface-proposal.
>> */
> 
> Kernel folks do not like this kind of history in the file because it tends to be outdated.
> Maybe we can put it into a docs for a record?
> 

Done

> 
>> #include <linux/module.h>
>> #include <linux/slab.h>
>> #include <linux/pci.h>
>> #include <linux/jiffies.h>
>> #include <linux/i2c.h>
>> #include <linux/i2c-isa.h>
>> #include <linux/hwmon.h>
>> #include <linux/hwmon-sysfs.h>
>> #include <linux/init.h>
>> #include <asm/io.h>
>>
>> /* This is needed untill this gets merged upstream */
>> #ifndef __SENSOR_DEVICE_ATTR2
>> #define __SENSOR_DEVICE_ATTR2(_name,_mode,_show,_store,_index,_nr)	\
>> {	.dev_attr =	__ATTR(_name,_mode,_show,_store),		\
>> 	.index =	_index,						\
>> 	.nr =		_nr						\
>> }
>> #endif
> I think this is already there
> 
[hans at shalem linux-2.6.15.x86_64]$ grep -r SENSOR_ATTR2 include
[hans at shalem linux-2.6.15.x86_64]$

Nope.

>> #define ABIT_UGURU_BEEP_ENABLE			0x08 /* beep if alarm */
>> #define ABIT_UGURU_SHUTDOWN_ENABLE		0x80 /* shutdown if alarm */
>> /* uGuru fan PWM (speed control) flags */
>> #define ABIT_UGURU_FAN_PWM_ENABLE		0x80 /* enable speed control */
>> /* Values used for conversion */
>> #define ABIT_UGURU_FAN_MAX	15300 /* RPM */
>> /* Bank1 sensor types */
>> #define ABIT_UGURU_IN_SENSOR	0
>> #define ABIT_UGURU_TEMP_SENSOR	1
>> #define ABIT_UGURU_NC		2
> 
> I hope this are aligned to same tab.
> 

They are now.

>> /* For the Abit uGuru, we need to keep some data in memory.
>>    The structure is dynamically allocated, at the same time when a new
>>    abituguru client is allocated. */
>> struct abituguru_data {
>> 	struct i2c_client client;
>> 	struct class_device *class_dev;
>> 	struct semaphore update_lock;
> 
> Recently was semaphore converted to Mutexes please can you do that too?
> 

Done.


>> 	char uguru_ready;	/* is the uguru in ready state? */
> Why char? we have u8 u16... or enum...
> 

I took the use of char as boolean type from drivers/hwmom/via686a.c:
char valid in the data struct. An enum is an int and thus wastes 3 bytes
mem (or a factor 4).


>> 	unsigned long last_updated;	/* In jiffies */
>> 	char update_timeouts;	/* number of update timeouts since last
>> 				   successfull update. */
> here too..
That one indeed can be a problem the code will go astray now if there
are more then 128 consecutive timeouts (a sign of some real trouble, but
that should be no reason for the code to misbehave).

Changed to an unsigned char and this wont be incremented when at 255.

>> 	/* Bank 1 data */
>> 	u8 bank1_sensors[2];	/* number of [0] in, [1] temp sensors */
> 
> It makes code quite hard to read with so many referencies. Why not a structure with two fields? Or some other construct
> that has a name?
> 
As described above, these arrays get addressed with ints I cannot do
this with structure member names.

>> 	u8 bank1_address[2][16];/* addresses of [0] in, [1] temp sensors */
> 
> Same here  bank1_addr[16].vaddr .taddr?
> 
Same answer.

>> 	u8 bank1_value[16];
>> 	/* This array holds 16 x 3 entries for all the bank 1 sensor settings
>> 	   (flags,min,max for voltage / flags,warn,shutdown for temp). */
>> 	u8 bank1_settings[16][3];
> 
> Hmm why not the names?
>

Same answer and because I can't pass a struct to abituguru_read/write
without ugly casts and pack attributes etc.

>> 	/* The sysfs attr for the bank1 sensors are generated automaticly */
>> 	struct sensor_device_attribute_2 bank1_attr[16*3];
>> 	/* Maximum value for each sensor used for scaling in mV/milli degrees
>> 	   Celcius. */
>> 	int bank1_max_value[16];
>>
>> 	/* Bank 2 data, the highest number of fans currently know to be
>> 	   attached is 6, thus 6 entries for bank2 */
>> 	u8 bank2_value[6];
>> 	u8 bank2_settings[6][2]; /* flags, min */
> 
> Similar here
> 

Same answer.

>> static int abituguru_wait(struct i2c_client *client, u8 state)
>> {
>> 	int timeout = ABIT_UGURU_WAIT_TIMEOUT;
>>
>> 	while (inb_p(client->addr + ABIT_UGURU_DATA) != state)
> 
> Even short udelay(10) is not needed here?
> 

Notice the inb_p the _p version already includes a short delay. Anyways
this way it works fine for 12 people with many different motherboards now.

 >> 	/* Wait till the uguru is ready */
 >> 	if (abituguru_wait(client, ABIT_UGURU_STATUS_READY)) {
 >> #if ABIT_UGURU_DEBUG_LEVEL >= 1
 >> 		printk(KERN_DEBUG "abituguru: error: timeout exceeded waiting for 
ready state\n");
 > Have you considered dev_dbg?
 >> #endif
 >> 		return -EIO;
 >> 	}
 >>
 >> 	/* Cmd port MUST be read now and should contain 0xAC */
 >> 	while (inb_p(client->addr + ABIT_UGURU_CMD) != 0xAC) {
 >> 		timeout--;
 >> 		if (timeout = 0) {
 >> #if ABIT_UGURU_DEBUG_LEVEL >= 1
 >> 			printk(KERN_DEBUG "abituguru: error: CMD reg doesnot hold 0xAC 
after ready command\n");
 > does not (plus dev_dbg)
 >> #endif
 >> 			return -EIO;
 >> 		}
 >> 	}
 >>
 >> 	/* After this the ABIT_UGURU_DATA port should contain
 >> 	   ABIT_UGURU_STATUS_INPUT */
 >> 	while(inb_p(client->addr+ABIT_UGURU_DATA) != ABIT_UGURU_STATUS_INPUT){
 >> 		timeout--;
 >> 		if (timeout = 0) {
 >> #if ABIT_UGURU_DEBUG_LEVEL >= 1
 >> 			printk(KERN_DEBUG "abituguru: error: state != more input after 
ready command\n");
 >> #endif	
 > dev_dbg
 >> 			return -EIO;
 >> 		}
 >> 	}
 >> 	
 >
 > This three loops leads me to idea that perhaps some send_io_wait func 
could be created, this is just an idea...
 >

I already have abituguru_wait which waits for the uguru to report that 
it has reached a certain state in the communication. Unfortunatly the 
waiting for it to report a certain state in uguru_ready is special, the 
code used todo a single read and check that, but that sometimes fails. 
So now it tries it a couple of times, but with a very low value for 
timeout. Actually the reading of CMD is a mandatory part of the 
communication but the reading of DATA can be skipped and replaced with a 
short sleep.


>>
>> static int abituguru_send_address(struct i2c_client *client,
>> 	u8 bank_addr, u8 sensor_addr, int retries)
>> {
>> #if ABIT_UGURU_DEBUG_LEVEL >= 1
>> 	/* asume caller does errorhandling itself if it has not requested any
>> 	   retries, and thus be quiet. */
>> 	int report_errors = retries;
>> #endif
> 
> hmm I dont like this
> 

I don't like it either, but unfortunatly some uGuru's are known to cause
timeouts quite frequent, using larger timeouts doesn't help, they just
go offline for a second or 2, doing some internal callibration or
whatever. So without this we will printk retryable errors quite often.
This is why the (new) verbose setting of the driver makes a difference
between retryable and fatal errors.

I could make it a param of this function if you think that that's
cleaner? But it will then always have the same value as the retries
param, since either the caller wants us to handle retrying and does do
error reporting, or it does it itself.

>> 	struct abituguru_data *data = i2c_get_clientdata(client);
>>
>> 	for (;;) {
>> 		/* The first try the uguru normally will be ready for the first
>> 		   input and thus in ABIT_UGURU_STATUS_INPUT state. If however
>> 		   something went wrong previously it might not be, so then we
>> 		   try to force it into ready state.
>> 		   If/when the uguru is ready we send the bank address,
>> 		   after this the uguru is no longer "ready". */
>> 		if (!data->uguru_ready && (abituguru_ready(client) != 0))
>> 			return -EIO;
>> 		outb(bank_addr, client->addr + ABIT_UGURU_DATA);
>> 		data->uguru_ready = 0;
>>
>> 		/* Wait till the uguru is ABIT_UGURU_STATUS_INPUT state again
>> 		   and send the sensor addr */
>> 		if (abituguru_wait(client, ABIT_UGURU_STATUS_INPUT)) {
>> 			if (retries) {
>> #if ABIT_UGURU_DEBUG_LEVEL >= 3
>> 				printk(KERN_DEBUG "abituguru: timeout exceeded waiting for more input state, %d tries remaining\n", retries);
>> #endif
>> 				set_current_state(TASK_UNINTERRUPTIBLE);
>> 				schedule_timeout(ABIT_UGURU_RETRY_DELAY);
>> 				retries--;
>> 				continue;
>> 			} else {
>> #if ABIT_UGURU_DEBUG_LEVEL >= 1
>> 				if (report_errors)
>> 					printk(KERN_DEBUG "abituguru: error: timeout exceeded waiting for more input state (bank: %d)\n", (int)bank_addr);
>> #endif
>> 				return -EBUSY;
>> 			}
>> 		}
> 
> What about to put the abitguru_wait to while cycle and get rid of the infinite loop for?
Then I would have to duplicate the abituguru_ready() , outb bank_addr
and mark not ready parts.


>> 	/* And read the data */
>> 	while(bytes_read < count) {
>> 		if (abituguru_wait(client, ABIT_UGURU_STATUS_READ)) {
>> #if ABIT_UGURU_DEBUG_LEVEL >= 1
>> 			printk(KERN_DEBUG "abituguru: error: timeout exceeded waiting for read state (bank: %d, sensor: %d)\n", (int)bank_addr, (int)sensor_addr);
> dev_dbg
>> #endif
>> 			break;
>> 		}
>> 		buf[bytes_read] = inb(client->addr + ABIT_UGURU_CMD);
>> 		bytes_read++;
> WHy not for cycle?

You're right, fixed.

>> 	/* First read the sensor and the current settings */
>> 	if (abituguru_read(client, ABIT_UGURU_SENSOR_BANK1, sensor_addr, &val,
>> 	    1, ABIT_UGURU_MAX_RETRIES) != 1)
> 		return -EIO;
> The return must be on new line, on the other hand I'm not sure how to align best the previous line,
> Please check the CodingStyle
> 

Fixed.

 >> 	
 >> 	/* Test val is sane / usable for sensor type detection. */
 >> 	if ((val < 10u) || (val > 240u)) {
 >
 > Any strong reason why this needs to be in dec and not hex?
 >

Because the value must be 10 or more higher then the minimal value u8 
can represent and 15 or more less then the maximal so this is pure 
normal math, which humans are used doing in decimals.

>> 	/* Now we need 20 ms to give the uguru time to read the sensors
>> 	   and raise the alarm */
>> 	set_current_state(TASK_UNINTERRUPTIBLE);
>> 	schedule_timeout(HZ/50);
> 
> I think precise timeout is not possible with this. What about msleep? Maybe you should also lock access (mutex
> or semaphore, see Linux device drivers third edition as pdf) to the chip in _read _write functions so no other
> concurrect access to achip from different part of driver  could occur.
> 

It must be atleast 20ms more is no problem, this way we yield the CPU
which is a good thing todo since the entire uGuru probing can take more
then a second (using this code, with msleep it might go faster).

 >> 	/* Check for alarm and check the alarm is a volt low alarm. */
 >> 	if (abituguru_read(client, ABIT_UGURU_ALARM_BANK, 0, buf, 3,
 >> 			ABIT_UGURU_MAX_RETRIES) != 3)	
 > 		return -EIO;
 >
 >> 	if (buf[sensor_addr/8] & (0x01<<(sensor_addr%8)) ) {
 >  Missing spaces buf[sensor_addr >> 3] & (1 << (sensor_addr & 0x7 )) 
should work without division
 >

Spaces fixed, &7 will work too, but %8 is more readable and the compiler 
will optimise %8 to &7 for us. (the / 8 could also be replaced by a 
shift if you want to make it really unreadable)

<Large piece of sensor type detect code snipped>
> 
> My question is: Does it really work?
Yes sofar it works 100% for 12 different people on 8 (or so) different
motherboards.

> If yes then wow :) If you change limit will guru do something bad
> to motherboard? Like cutting powerlines/CPU? Perhaps no...
> 
No, because I disable the alarm, beep and shutdown features during the
probe.

>> /* following are the sysfs callback functions */
>> static ssize_t show_bank1_value(struct device *dev,
>> 	struct device_attribute *devattr, char *buf)
>> {
>> 	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
>> 	struct abituguru_data *data = abituguru_update_device(dev);
>> 	if (!data)
>> 		return -EIO;
>> 	return sprintf(buf, "%d\n", (data->bank1_value[attr->index]*
>>                 data->bank1_max_value[attr->index] + 128) / 255);
> 
> /255 -> >>8
> 

That would be / 256, causing rounding errors.

>> 	struct abituguru_data *data = i2c_get_clientdata(to_i2c_client(dev));
>> 	return sprintf(buf,"%d\n",(data->bank2_settings[attr->index][attr->nr]*
>> 		ABIT_UGURU_FAN_MAX + 128) / 255);
>> }
> 
> Maybe some macro for repeated + 128 /255 ?
> 

The macro name would probably be longer then + 128 / 255 and I have
serious doubt of that this will improve readability in general macros
expanding to code rather then to constants make readability less not more.


>> static ssize_t store_bank1_setting(struct device *dev, struct device_attribute
>> 	*devattr, const char *buf, size_t count)
>> {
>> 	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
>> 	struct abituguru_data *data = i2c_get_clientdata(to_i2c_client(dev));
>> 	u8 val = (simple_strtoul(buf, NULL, 10)*255 +
> 
>  * 255 must be with spaces, also shifting 8 bits left should work too
> 
>> 		data->bank1_max_value[attr->index]/2) /
>> 		data->bank1_max_value[attr->index];
> 
> Seems like scaling but quite confusing  /2
> 

No float in kernel, so one must resort to stuff like this to get proper
rounding down / up of values.


>> 	ssize_t ret = count;
>>
>> 	down(&data->update_lock);
>> 	if (data->bank1_settings[attr->index][attr->nr] != val) {
>> 		u8 orig_val = data->bank1_settings[attr->index][attr->nr];
>> 		data->bank1_settings[attr->index][attr->nr] = val;
>> 		if (abituguru_write(&data->client, ABIT_UGURU_SENSOR_BANK1+2,
>> 				attr->index, data->bank1_settings[attr->index],
>> 				3) <= attr->nr) {
>> 			data->bank1_settings[attr->index][attr->nr] = orig_val;
>> 			ret = -EIO;
>> 		}
>> 	}	
>> 	up(&data->update_lock);
> 
> The data are preserved by the lock, so maybe you dont need the orig_val ?
> 

This is a store function thus I overwrite the value stored in data->, if
the write fails I restore data-> so that it is back in its original state.

In a previous version I memcpy'd all the settings to a local buf,
modified that buf, tried to write it and then on success made the same
changes to the copy in data-> . This is cleaner, I understand its a bit
tricky to read though.

>> 	for (i=0; i<data->bank1_sensors[attr->index]; i++) {
> 
> there should be always spaces between some operators, please consult the CodingStyle file in kernel.
> 

IMHO this is your interpretation of CodingStyle I've read it for the
second time today and still can't find this. I do agree with you in the
cases you've commented upon that spaces help and I've added spaces to
most code in the driver.

>> 		u8 address = data->bank1_address[attr->index][i];
>> 		if ( (data->alarms[address/8] & (0x01<<(address%8))) &&
> 
> 1 << is enough. I think I commented already this kind of thing.
> 

1 << will work to, but just like the case where you suggested using hex 
instead of decimal the code was really dealing with numbers and thus 
IMHO decimal is prefarable here we are dealing with bits and bitmasks 
and thus hex is preferable.

>> 		     (data->bank1_settings[address][0] & attr->nr) )
>> 			alarms |= 0x01 << i;
>> 	}
>> 	return sprintf(buf, "%d\n", alarms);
>> }
>>
> 
> This is hard to understand without addtional comments
> 

Comments added.

> 
>> static ssize_t show_bank2_alarms(struct device *dev,
>> 	struct device_attribute *devattr, char *buf)
>> {
>> 	struct abituguru_data *data = abituguru_update_device(dev);
>> 	if (!data)
>> 		return -EIO;
>> 	return sprintf(buf, "%d\n", (int)data->alarms[2]);
>> }
> 
> Is this cast neccessary?

Yes printf and friends are vararg, thus no auto casting gets done and %d 
expects an int not a u8. It might be that gcc does the right thing when 
a function is marked as a printf alike (there is a special attribute for 
this) but without the cast it is not correct C, I'd rather not depend on 
a gcc "feature" when I can write correct C instead.

> 
>> static ssize_t show_bank1_mask(struct device *dev,
>> 	struct device_attribute *devattr, char *buf)
>> {
>> 	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
>> 	struct abituguru_data *data = i2c_get_clientdata(to_i2c_client(dev));
>> 	int i, mask = 0;
>> 	for (i=0; i<data->bank1_sensors[attr->index]; i++) {
>> 		u8 address = data->bank1_address[attr->index][i];
>> 		if (data->bank1_settings[address][0] & attr->nr)
>> 			mask |= 0x01 << i;
> 1<< i
> Maybe it should be unsigned?
> 

There will never be more then 16 sensors and thus 16 bits so the sign 
bit will never get set, thus it doesn't matter. In cases like this I 
prefer normal ints as mixing unsigned and signed can lead to all kind of 
fun casts / type promotions etc by the compiler. Hence you will also see 
me always use things like 10u when working with unsigneds to make sure 
everything stays unsigned since just 10 without the u is always signed 
in C. I can tell you some stories of interesting bugs in software due to 
signed / unsigned mixing but thats a whole other story really.

>> static ssize_t store_bank1_mask(struct device *dev,
>> 	struct device_attribute *devattr, const char *buf, size_t count)
>> {
>> 	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
>> 	struct abituguru_data *data = i2c_get_clientdata(to_i2c_client(dev));
>> 	int i, mask = simple_strtoul(buf, NULL, 10);
>> 	ssize_t ret = count;
>>
>> 	down(&data->update_lock);
>> 	for (i=0; i<data->bank1_sensors[attr->index]; i++) {
>> 		u8 address = data->bank1_address[attr->index][i]; 
>> 		u8 orig_val = data->bank1_settings[address][0];
>> 		if (mask&(0x01<<i))
>> 			data->bank1_settings[address][0] |= attr->nr;
>> 		else
>> 			data->bank1_settings[address][0] &= ~attr->nr;
>> 		if ( (data->bank1_settings[address][0] != orig_val) &&
>> 		     (abituguru_write(&data->client, ABIT_UGURU_SENSOR_BANK1+2,
>> 				address,data->bank1_settings[address],3)<1) ) {
> 
> Is this same value test everywhere?

Yes, I try to avoid unnescesarry writes to the uGuru / unnescesarry ISA 
iocycles.

>> static ssize_t store_bank2_mask(struct device *dev,
>> 	struct device_attribute *devattr, const char *buf, size_t count)
>> {
>> 	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
>> 	struct abituguru_data *data = i2c_get_clientdata(to_i2c_client(dev));
>> 	int i, mask = simple_strtoul(buf, NULL, 10);
>> 	ssize_t ret = count;
>>
>> 	down(&data->update_lock);
>> 	for (i=0; i<6; i++) {
> 
> maybe 6 should be #defined
> 

Good idea, done.

>> 		u8 orig_val = data->bank2_settings[i][0];
>> 		if (mask&(0x01<<i))
>> 			data->bank2_settings[i][0] |= attr->nr;
>> 		else
>> 			data->bank2_settings[i][0] &= ~attr->nr;
>> 		if ( (data->bank2_settings[i][0] != orig_val) &&
>> 		     (abituguru_write(&data->client, ABIT_UGURU_SENSOR_BANK2+2,
>> 				i, data->bank2_settings[i], 2) < 1) ) {
>> 			data->bank2_settings[i][0] = orig_val;
>> 			ret = -EIO;
>> 			break;
>> 		}
>> 	}
>> 	up(&data->update_lock);
>> 	return ret;
>> }
>>
>> /* Fan PWM (speed control) */
>> static ssize_t show_pwm_reg(struct device *dev,
>>         struct device_attribute *devattr, char *buf)
>> {
>> 	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
>> 	struct abituguru_data *data = i2c_get_clientdata(to_i2c_client(dev));
>> 	return sprintf(buf, "%d\n", data->pwm_settings[attr->index][attr->nr] *
>> 		abituguru_pwm_settings_multiplier[attr->nr]);
>> }
>>         
>> static ssize_t store_pwm_reg(struct device *dev, struct device_attribute
>> 	*devattr, const char *buf, size_t count)
>> {
>> 	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
>> 	struct abituguru_data *data = i2c_get_clientdata(to_i2c_client(dev));
>> 	int val = (simple_strtoul(buf, NULL, 10) +
>> 		abituguru_pwm_settings_multiplier[attr->nr]/2) /
>> 		abituguru_pwm_settings_multiplier[attr->nr];
> 
> cannot be this scaling hidden is some macro that it will explain what is happenning?
>

What is there to explain there is a multiplier which depends on which 
setting for pwm we are changing (the setting to change is indicated by 
attr->nr). PWM autopoint coordinates are multiplied by 1, temp autopoint 
coordinate by 1000 before being shown to the user. In this case we're 
going the other way around so we add half the multiplier for proper 
rounding and then divide by the multiplier.

Since some calcs use multipliers, others use max-values and again others 
have no conversion there are many of these not all that hard 
calculations in here which all have subtle differences and because of 
the differences there is little to win by using macros.

>>
>> 	/* Reserve our 2 ISA addresses */
>> 	if (!request_region(ABIT_UGURU_BASE+ABIT_UGURU_CMD, 1,
>> 		abituguru_driver.name)) {
>> 		dev_err(&adapter->dev, "ISA-address %x already in use!\n",
>> 			ABIT_UGURU_BASE + ABIT_UGURU_CMD);
>> 		err = -EBUSY;
>> 		goto ERROR0;
>> 	}
>> 	if (!request_region(ABIT_UGURU_BASE+ABIT_UGURU_DATA, 1,
>> 		abituguru_driver.name)) {
>> 		dev_err(&adapter->dev, "ISA-address %x already in use!\n",
>> 			ABIT_UGURU_BASE + ABIT_UGURU_DATA);
>> 		err = -EBUSY;
>> 		goto ERROR1;
> 
> Hmm why not to reserve all 0xe0 to 0xe4 ? when it decodes this two...
> 

Thats what I started with, but I saw some patches on the list making 
changes to similar drivers to only claim the IO's really used also that 
makes sense, note that only bit 2 of the address changes, so maybe the 
other bits aren't even hooked up, or used by other parts of the IC which 
contrail things like CPU and RAM voltages.


Wow, you might it all this way thanks for reading and once again thanks 
for reviewing!

Regard (again),

Hans


