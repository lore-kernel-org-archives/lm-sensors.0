From: mirko@buholzer.com (Mirko Buholzer)
Date: Mon, 05 Sep 2005 23:30:56 +0000
Subject: [lm-sensors] Random values with pcf8591 chip driver (Now as a
Message-Id: <431CB8EF.1020507@buholzer.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <431CAFE8.7020008@buholzer.com>
In-Reply-To: <431CAFE8.7020008@buholzer.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The pcf8591 is the only chip. When I do a "i2cdetect 1" and change the 
hardware address from 100 to 000 you can see the output below (The UU 
value comes from the loaded chip driver), so for me it looks like a 
detected chip?

100:
voyage:~# i2cdetect 1
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-1.
I will probe address range 0x03-0x77.
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          XX XX XX XX XX XX XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX XX XX XX XX XX UU XX XX XX XX XX XX
50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX


000:
voyage:~# i2cdetect 1
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-1.
I will probe address range 0x03-0x77.
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          XX XX XX XX XX XX XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX XX XX XX XX 48 UU XX XX XX XX XX XX
50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX


Thanks for your feedback!
Regards Mirko

Jean Delvare wrote:

>Hi Mirko,
>
>  
>
>>I load the modules as follows:
>>
>>modprobe scx200_i2c scl4 sda5
>>modprobe pcf8591 input_mode=0
>>    
>>
>
>Do you have any other chip on that I2C bus? Maybe the bus isn't working
>at all and it's not the PCF8591 fault. How did you come to these values
>for scl and sda?
>
>  
>

