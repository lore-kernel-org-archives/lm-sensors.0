From: nithinkj@hcl.in (Nithin)
Date: Sat, 29 Jul 2006 13:01:04 +0000
Subject: [lm-sensors] Problem with W83792d
Message-Id: <44CB5940.8020801@hcl.in>
List-Id: <lm-sensors.vger.kernel.org>
References: <44CB36A9.9040502@hcl.in>
In-Reply-To: <44CB36A9.9040502@hcl.in>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi,
This is the output i got while issuing i2cdetect ,In this between 2c and 
2f nothing
is seeing?

> [root at helinium root]# modprobe i2c-i801
> [root at helinium root]# modprobe i2c-dev
> [root at helinium root]# i2cdetect -y 0
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-0.
> I will probe address range 0x03-0x77.
> Continue? [Y/n] y
> 0 1 2 3 4 5 6 7 8 9 a b c d e f
> 00: XX XX XX XX XX 08 XX XX XX XX XX XX XX
> 10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 30: XX XX XX 33 XX XX XX XX XX XX XX XX XX XX XX XX
> 40: XX XX XX XX 44 XX XX XX XX XX XX XX XX XX XX XX
> 50: XX XX XX 53 XX XX XX XX XX XX XX XX XX XX XX XX
> 60: XX 61 XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 70: XX XX XX XX XX XX XX XX
>


Thanks
Nithin



Mark M. Hoffman wrote:

>Hi Nithin:
>
>  
>
* Nithin <nithinkj at hcl.in> [2006-07-29 15:51:29 +0530]:

>>	I m working in "ASUS NCL-DE Board " in RHEL 3.0 UP5,with lmsensors-2.10.0 and i2c-2.10.0
>>In this board w83792d is the health monitoring chip.
>>But i am not able to get any of the values.The chip is not even detecting using sensors-detect.
>>I have inserted modules i2c-i801,i2c-proc,i2c-dev,i2c-core,w83792d.But the chip is showing in
>>/proc/sys/dev/sensors/.
>>The reply i got from 'Asus' is, it using the slave addres as 0x5e,smbus base addres 0x400.
>>But the driver for w83792d searches in 0x2c to 0x2f (static unsigned short normal_i2c_range[] = { 0x2c, 0x2f, SENSORS_I2C_END };)
>>    
>>
>
>That's probably a small misunderstanding about the I2C address space - it has
>7 bits address and the 8th is Read/!Write.  So, many device datasheets will 
>say e.g. "read at 0x5f and write at 0x5e".  Linux I2C subsystem considers 
>the address to be the 7 bits only, right justified.  So when Asus says 0x5e,
>they probably mean what Linux thinks is 0x2f.
>
>I don't think we've ever seen a sensor chip reported in the range of
>0x50-0x5f.  That is reserved on PCs for the SPD/EEPROMs on your RAM.
>
>After loading i2c-i801 and i2c-dev, what does 'i2cdetect -y 0' tell you?
>
>Regards,
>
>  
>



