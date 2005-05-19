From: todd.c.davis@intel.com (Davis, Todd C)
Date: Thu, 19 May 2005 06:24:46 +0000
Subject: 2.6.4-rc2-mm1: IPMI_SMB doesnt compile
Message-Id: <F274AE5A8F65A848906BEB9DDFC7674C0E83DD@hdsmsx403.hd.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040310185105.GS14833@fs.tum.de>
In-Reply-To: <20040310185105.GS14833@fs.tum.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Corey Minyard <minyard@acm.org>, Adrian Bunk <bunk@fs.tum.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, greg@kroah.com, sensors@stimpy.netroedge.com, "Simon G. Vogl" <simon@tk.uni-linz.ac.at>

The problem that is being addressed here is the need to avoid process
switching when sending IPMI messages over the SMBus/I2C bus. When the
kernel has panic'ed or is shutting down bus transactions need to
complete so the i2c bus drivers need to spin rather than calling
schedule. 

The i2c_spin_delay is a flag that supports a revised inline function
i2c_delay() that was in i2c.h at one time.

static inline void i2c_delay(signed long timeout)
 {
	if( i2c_spin_delay ) {
		int i;
		for( i=0 ; i<100 ; i++ )
			udelay(timeout*(1000000/HZ/100));
	} else {
		set_current_state(TASK_INTERRUPTIBLE);
		schedule_timeout(timeout);
	}
 }

Without this change i2c bus drivers will hang panic threads and short
circuit (fail) bus transactions during shutdown due to a pending signal.

I don't care how the exports are handled. It is the functionality that
is important here.

Todd C. Davis
These are my opinions and absolutely not official opinions of Intel
Corp.
 
-----Original Message-----
From: Corey Minyard [mailto:minyard@acm.org] 
Sent: Wednesday, March 10, 2004 2:12 PM
To: Adrian Bunk
Cc: Andrew Morton; linux-kernel@vger.kernel.org; Davis, Todd C;
greg@kroah.com; sensors@stimpy.netroedge.com; Simon G. Vogl
Subject: Re: 2.6.4-rc2-mm1: IPMI_SMB doesnt compile

Adrian Bunk wrote:

>The patch to i2c-core.c is strange:
>
>
>  
>
>>--- linux-v31/drivers/i2c/i2c-core.c	2004-02-19 19:31:07.000000000
-0600
>>+++ linux/drivers/i2c/i2c-core.c	2004-03-10 09:48:08.000000000
-0600
>>@@ -1256,6 +1256,12 @@
>> 	return (func & adap_func) = func;
>> }
>> 
>>+int i2c_spin_delay;
>>+void i2c_set_spin_delay(int val)
>>+{
>>+	i2c_spin_delay = val;
>>+}
>>+
>> EXPORT_SYMBOL(i2c_add_adapter);
>> EXPORT_SYMBOL(i2c_del_adapter);
>> EXPORT_SYMBOL(i2c_add_driver);
>>@@ -1292,6 +1298,8 @@
>> 
>> EXPORT_SYMBOL(i2c_get_functionality);
>> EXPORT_SYMBOL(i2c_check_functionality);
>>+EXPORT_SYMBOL(i2c_set_spin_delay);
>>+EXPORT_SYMBOL(i2c_spin_delay);
>> 
>> MODULE_AUTHOR("Simon G. Vogl <simon@tk.uni-linz.ac.at>");
>> MODULE_DESCRIPTION("I2C-Bus main module");
>>...
>>    
>>
>
>
>You can either add get/set functions and export them (more an OO 
>paradigm) or export the variable.
>
>If you export the variable, it's quite useless to add such a set 
>function since everyone can set the variable directly.
>
I think the point is that lower-level drivers need to use this variable 
(because of its use in the include file), but it's better to set it with

a function from external code.

Todd, am I correct here?

-Corey

