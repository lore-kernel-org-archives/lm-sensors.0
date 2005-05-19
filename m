From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:34 +0000
Subject: Fujitsu Siemens sensor HERMES
Message-Id: <4001CA3B.8020103@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F70765D.5060209@gmx.de>
In-Reply-To: <3F70765D.5060209@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Reinhard Nissl wrote:

> Jean Delvare wrote:
> 

>>
>>> Concerning alarms: what do you mean by comparator mode?
>>
>>
>> Some chipsets can be configured in different modes. Interrupt mode means
>> that alarms don't wear off automatically as the cause of the alarm
>> disappears. Comparator means that it does. I'm not too comfortable with
>> changing modes, since hardware may be wired so as to work in one mode
>> and not in the other. So I would leave things as they are.
> 
> 
> HERMES doesn't allow changing this behaviour (at least it is not 
> documented). So, from the above, I'd say that HERMES is using interrupt 
> mode.
> 


I think Jean has the descriptions backwards, at least as Winbond has documented it,
and we copied that terminology into the documents doc/developers/proc in our package,
and i2c/sysfs-interface in the 2.6 kernel.
The lm_sensors standard is that alarms are persistent ("don't wear off automatically")
which Winbond calls "comparator".

Drivers should configure the hardware for that mode (whatever it's called).

mds
