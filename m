From: williamschnell@operamail.com (William)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: Missing download
Message-Id: <opr7ydv5hkk46x2i@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <opr7rnlmpsk46x2i@localhost>
In-Reply-To: <opr7rnlmpsk46x2i@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Still something wrong, as I have 8 instances of Vcore1 (all different),  
and the fans showing, but no temperatures.
When trying "make user" I get "make: *** No rule to make target `user'.   
Stop."
Wondering if it isn't time to give up on this one?

William


On Thu, 13 May 2004 15:16:01 +0200 (CEST), Jean Delvare  
<khali@linux-fr.org> wrote:

>
>> Hello;
>> Still doesn't work, this is what I get now:
>> [root@localhost william]# sensors -s
>> Can't access procfs/sysfs file
>> Unable to find i2c bus information;
>> For 2.6 kernels, make sure you have mounted sysfs and done
>> 'modprobe i2c_sensor'!
>> For older kernels, make sure you have done 'modprobe i2c-proc'!
>> [root@localhost william]# modprobe i2c_sensor
>> [root@localhost william]# sensors -s
>> No sensors found!
>>
>> I must have done something, but can't think what it could be.
>
> Most probably, you just didn't load the sensor modules you need. Load
> them and it should work better. If you can't remember what they are,
> run sensors-detect again and it should tell you.
>
> Jean
>
>
> --
> Jean "Khali" Delvare
> http://khali.linux-fr.org/



-- 
Using M2, Opera's revolutionary e-mail client: http://www.opera.com/m2/
