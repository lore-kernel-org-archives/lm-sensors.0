From: Marco <jjletho67-ml@yahoo.it>
Date: Wed, 28 Jul 2010 12:15:44 +0000
Subject: Re: [lm-sensors] asus_atk0110 on a p6td deluxe
Message-Id: <347501.60328.qm@web28505.mail.ukl.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <724895.29279.qm@web28512.mail.ukl.yahoo.com>
In-Reply-To: <724895.29279.qm@web28512.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>> However, in GIT3 I see at least the following entries that are
>> connected to the hwmon chip:
>>
>> "BCLK Frequency"
>> "CPU Voltage" (another one, but for a different register)
>> "CPU Ratio"
>> "QPI/DRAM Core Volt"
>> "DRAM Bus Voltage"
>>
>
>Hmm, this sounds like its not hwmon, but voltage and clock
>control!!
>

Hi,
I can confirm that this motherboard has the ability to modify some clock and 
voltage parameter through a software. The asus utility can do that.
Personally  i'm interested only in monitoring them, but i'm quite sure they can 
be modified at runtime.

Marco



      

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
