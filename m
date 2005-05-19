From: mirko@buholzer.com (Mirko Buholzer)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: Support of i2c-nscacb
Message-Id: <427A2087.1030304@buholzer.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4263B107.1070703@buholzer.com>
In-Reply-To: <4263B107.1070703@buholzer.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Do you have any hints or docu links where I can find more information to 
extend the lm77 driver with user-space?

Thanks Mirko


Jean Delvare wrote:

>Hi Miko,
>
>  
>
>>I did the following tasks as described below. I assume that the lm77
>>is  working properly. But I don't know why no data is transfered.
>>(...)
>># modprobe  scx200_acb
>># modprobe lm77
>>(...)
>># sensors
>>lm77-i2c-0-48
>>Adapter: SCx200 ACB0
>>    
>>
>
>The lm77 driver currently has no user-space support. You can get the raw
>values from /sys/bus/i2c/devices/0-0048. If you want "sensors" to
>display something for lm77 chips, you'll have to hack libsensors and
>sensors by yourself. If you do, we would appreciate a patch so that
>other users can benefit too.
>
>  
>
