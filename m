From: lmsensors@eltofts.homelinux.com (Andy Wright)
Date: Thu, 01 Mar 2007 01:07:56 +0000
Subject: [lm-sensors] Asus P4R800-VM with w83627THF sensor
Message-Id: <45E6276C.1080903@eltofts.homelinux.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <45B2BB3B.4000603@eltofts.homelinux.com>
In-Reply-To: <45B2BB3B.4000603@eltofts.homelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Andy,
>
> On Sun, 21 Jan 2007 01:00:43 +0000, Andy Wright wrote:
>   
>> I'm trying to get lm_sensors working on an asus p4r800-vm motherboard. 
>> OS is Centos 4.4 running Kernel 2.6.9-42.0.3.EL and I have installed the 
>> libsysfs library from the lm-sensors.org website.
>>
>> sensors-detect gives the following;
>>
>> Driver 'w83627hf' (should be inserted):
>>   Detects correctly:
>>   *  ISA bus address 0x0228 (Busdriver 'i2c-isa')
>>       Chip 'Winbond W83627THF Super IO Sensors' (confidence: 9)
>>
>> modprobe i2c-isa succeeds
>>
>> modprobe w83627hf   fails with;
>>
>> FATAL: Error inserting w83627hf 
>> (/lib/modules/2.6.9-42.0.3.EL/kernel/drivers/i2c/chips/w83627hf.ko): No 
>> such device
>>
>> Would anyone have any pointers as to how to get this going ?
>>     
>
> Was the W83627THF chip found as the "primary" or "secondary" Super-I/O
> chip? (sensors-detect should tell you)
>
>   
Hi,

It was discovered as the secondary.....

Andy.

