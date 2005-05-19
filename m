From: minyard@acm.org (Corey Minyard)
Date: Thu, 19 May 2005 06:24:46 +0000
Subject: 2.6.4-rc2-mm1: IPMI_SMB doesnt compile
Message-Id: <404F687A.7040301@acm.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040307223221.0f2db02e.akpm@osdl.org> <20040309013917.GH14833@fs.tum.de> <404F3BC3.2090906@acm.org> <20040310185105.GS14833@fs.tum.de>
In-Reply-To: <20040310185105.GS14833@fs.tum.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, "Davis, Todd C" <todd.c.davis@intel.com>, greg@kroah.com, sensors@stimpy.netroedge.com, "Simon G. Vogl" <simon@tk.uni-linz.ac.at>

Adrian Bunk wrote:

>The patch to i2c-core.c is strange:
>
>
>  
>
>>--- linux-v31/drivers/i2c/i2c-core.c	2004-02-19 19:31:07.000000000 -0600
>>+++ linux/drivers/i2c/i2c-core.c	2004-03-10 09:48:08.000000000 -0600
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
