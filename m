From: DwaineGarden@rogers.com (Dwaine Garden)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: i2c-2.8.0 USBVision Patch
Message-Id: <3F986438.20708@rogers.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031018131614.4b3b8c95.khali@linux-fr.org>
In-Reply-To: <20031018131614.4b3b8c95.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:

>>Please change the following...
>>
>>.id                = I2C_HW_B_BT848,
>>
>>to the following...
>>
>>.id                = I2C_USBVISION,
>>    
>>
>
>That ID is for an adapter, so it has to be I2C_HW_USBVISION (or even
>longer? Please take a look at i2c-id.h in the Linux kernel sources and
>tell me what you think).
>
>Also, there's a second ID you'd need to change: I2C_ALGO_BIT should
>become I2C_ALGO_USB, right?
>
>  
>
Sounds great to me....  I would like to keep it basically like 
everything else.  I checked out the i2c-id.h file.

a)  I2C_HW_B_USBVISION
b) I2C_ALGO_USB

Thanks...

Dwaine.
