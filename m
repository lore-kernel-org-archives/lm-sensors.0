From: phil@edgedesign.us (Philip Edelbrock)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: Keywest detection
Message-Id: <3F31620A.1060400@edgedesign.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030806190950.6326aa8f.khali@linux-fr.org>
In-Reply-To: <20030806190950.6326aa8f.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


The driver does it's internal device detection using Open Firmware.  
Take a look at this in the kernel source:

arch/ppc/kernel/prom.c

It's sort of like a PCI device table, except it includes all sorts of 
hardware interfaces besides just PCI devices.  If you have a newer Mac 
around (made within the last few years), you can hold down option-o-f 
while booting to get into the Open Firmware 'shell'.  It's a Forth type 
interpreter which lets you do various things like browse the hardware of 
the computer or change some boot params.

Links of interest:

http://playground.sun.com/1275/home.html

Here's a great tutorial from Apple:

http://developer.apple.com/technotes/tn/tn1061.html


Phil


Jean Delvare wrote:

>Hi Benjamin, thanks for the fast reply.
>
>  
>
>>>I would like to add support for the Keywest to our sensors-detect
>>>script. I wonder if I should add it to the detectable adapters list
>>>or to the undetectable adapters list. Is there any way to detect it?
>>>Usually, we detect the adapters by matching a given PCI
>>>manufacturer:device ID and function.
>>>      
>>>
>>Hrm... On 2.4, it's not that simple, there can be 2 keywest
>>controllers, one on the northbridge, one on the southbridge, driving
>>various parts.
>>    
>>
>
>You don't really help me ;) Does it show in lspci or somewhere else?
>  
>

