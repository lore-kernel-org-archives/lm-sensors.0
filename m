From: DwaineGarden@rogers.com (Dwaine Garden)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: i2c-2.8.0 USBVision Patch
Message-Id: <3F9772D1.2010802@rogers.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031018131614.4b3b8c95.khali@linux-fr.org>
In-Reply-To: <20031018131614.4b3b8c95.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:

>>I happen to stumble on your conversation and patch.  
>>
>>Thanks,  I will update our code base.
>>    
>>
>
>Once done, please confirm which constant you have been using and if you
>want a comment associated in i2c-id.h.
>
>Thanks.
>
>  
>
Please change the following...

.id                = I2C_HW_B_BT848,

to the following...

.id                = I2C_USBVISION,

Thanks....
Dwaine.
http://www.emuit.com/webcam.html

