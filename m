From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Sat, 28 Jan 2006 10:20:53 +0000
Subject: [lm-sensors] Patch: abituguru driver version 1.1.1
Message-Id: <43DB4585.3010404@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <43AD5940.1090900@hhs.nl>
In-Reply-To: <43AD5940.1090900@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

One last reply to a remark which I mist yesterday:

>> 	/* After this the ABIT_UGURU_DATA port should contain
>> 	   ABIT_UGURU_STATUS_INPUT */
>> 	while(inb_p(client->addr+ABIT_UGURU_DATA) != ABIT_UGURU_STATUS_INPUT){
>> 		timeout--;
>> 		if (timeout = 0) {
>> #if ABIT_UGURU_DEBUG_LEVEL >= 1
>> 			printk(KERN_DEBUG "abituguru: error: state != more input after ready command\n");
>> #endif	
> dev_dbg
>> 			return -EIO;
>> 		}
> Maybe you should also lock access (mutex
> or semaphore, see Linux device drivers third edition as pdf) to the chip in _read _write functions so no other
> concurrect access to achip from different part of driver  could occur.
> 

This is already taken care of. The detect_sensor_type function where 
this comments was made is called before i2c_client_register, thus none 
of the sysfs show/store will get called, so no race.

All the sysfs show/store functions either call abituguru_update_data 
which does locking, or do the locking themselves directly. This locking 
of the data thus protects against any races involving simultanious use 
of read/write functions.

Regards,

Hans

