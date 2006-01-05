From: jim.cromie@gmail.com (Jim Cromie)
Date: Thu, 05 Jan 2006 04:52:45 +0000
Subject: [lm-sensors] hwmon-sensor-attr-array-2.patch
Message-Id: <43BCA61D.3060607@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <43B306FB.9040301@gmail.com>
In-Reply-To: <43B306FB.9040301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hans de Goede wrote:


what the hey, Ill give it a cursory look.

dont feel the need to ack whatever I say here (I havent started yet),
unless you want to disagree.

I assume Jean will eventually get to it, but perhaps I can save him a 
few words.
Hopefully Im not so far off base that he spends them correcting me ;-)


1.  strip trailing whitespace :-O
    Im just saying it preemptively.




strip macro eventually.

>/* This is needed untill this gets merged upstream */
>#ifndef SENSOR_ATTR_2
>#define SENSOR_ATTR_2(_name, _mode, _show, _store, _nr, _index)	\
>	{ .dev_attr = __ATTR(_name, _mode, _show, _store),	\
>	  .index = _index,					\
>	  .nr = _nr }
>#endif
>
>  
>

>/* Debugging output level:
>   0 no debug output
>   1 log errors with printk
>   2 also log sensors type probing info
>   3 log retryable errors
>   This is at 2 for now, since this driver is still in the testing fase */
>#define ABIT_UGURU_DEBUG_LEVEL	2
>  
>
make this a module-param ?
how much object code does it add ?
maybe a param, which is also gated by ifdefs
(or a debug_() macro to hide ifdefs) ?

see dev_dbg, for a start, though I think youll want to
wrap it so that you can pass in a level 1,2,3,
while keeping 1 ifdef to remove the debug-code entirely.

$ grep dev_dbg pc87360.c
                dev_dbg(&new_client->dev, "Using %s reference voltage\n",
                                dev_dbg(&client->dev, "Forcibly "
                                dev_dbg(&client->dev, "Forcibly "
                                        dev_dbg(&client->dev, "Skipping "
                                        dev_dbg(&client->dev, "Forcibly "






>/* For the Abit uGuru, we need to keep some data in memory.
>   The structure is dynamically allocated, at the same time when a new
>   abituguru client is allocated. */
>  
>
do you foresee / have you tried  multiple chips ?


>/* Put the uguru in ready for input state, this code assumes that
>   the uguru is not already in this state.
>   It is the callers responsibility to make sure it isn't! */
>  
>

what do you save by making this assumption ?
yes its static, so less ripe for abuse, but if its 1 flag ..






>		/* The first try the uguru normally will be ready for the first
>		   input and thus in ABIT_UGURU_STATUS_INPUT state. If however
>		   something went wrong previously it might not be, so then we
>		   try to force it into ready state.
>  
>

is this forcing something the user should have to explicitly enable ?



>/* Following are the sysfs callback functions. These functions use
>   sensor_device_attribute_2->nr and sensor_device_attribute_2->index
>   in the following ways:
>		nr selects 			index selects
>_value/pwm_*	NA				sensor/pwm *
>_setting	auto/min/max       (offset)	sensor/pwm
>_alarms/_mask	beep/shutdown/flag (bitmask)	sensor_type (volt/temp) **
>
>   *)  Except for pwm_setting which uses nr and index as _setting
>   **) NA for bank2 as bank2 only contains fan sensors */
>  
>

following are nearly identical

>static ssize_t show_bank1_value(struct device *dev,
>	struct device_attribute *devattr, char *buf)
>
>static ssize_t show_bank1_setting(struct device *dev,
>	struct device_attribute *devattr, char *buf)
>
>static ssize_t show_bank2_value(struct device *dev,
>	struct device_attribute *devattr, char *buf)
>
>  
>
+ others below I think.   
it looks like attr->index, and bank 1,2  could drive a constants & formula
lookup to provide many calcs reachable by 1/few handers.


Im beginning to think you could make good use of SENSOR_ATTR_4,
which Jean blue-sky'd, but you could make concrete easily.

with it, you could squeeze these many handlers down to a few,
 doing scale and offset lookups and calcs, forex.



All right, Im fresh out of insights

hth
jimc


PS.  what boxes have this chip in them ?
/me thinks it might be in comments.
/me should just look myself, instead of asking :-O

