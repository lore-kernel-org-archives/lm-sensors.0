From: DwaineGarden@rogers.com (Dwaine Garden)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: i2c-2.8.0 USBVision Patch
Message-Id: <3F9C38E4.3090102@rogers.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031018131614.4b3b8c95.khali@linux-fr.org>
In-Reply-To: <20031018131614.4b3b8c95.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:

>>Sounds great to me....  I would like to keep it basically like 
>>everything else.  I checked out the i2c-id.h file.
>>
>>a)  I2C_HW_B_USBVISION
>>b) I2C_ALGO_USB
>>    
>>
>
>I'm not sure about I2C_HW_B_USBVISION. I'd tend to say that _B_ is for
>adapters that use the i2c-algo-bit algorithm layer, which isn't your
>case, unless I'm missing something. So I'm now wondering if it shouldn't
>be I2C_HW_USB_USBVISION or something similar, since you are using your
>own algorithm.
>
>  
>
Ok....

a) I2C_HW_USB_USBVISION
b) I2C_ALGO_USB

Dwaine.
