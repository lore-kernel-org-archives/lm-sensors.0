From: devik@cdi.cz (Martin Devera)
Date: Tue, 14 Feb 2006 16:21:18 +0000
Subject: [lm-sensors] HT-1000 smbus
Message-Id: <43F2037E.104@cdi.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <43F105D6.7000500@cdi.cz>
In-Reply-To: <43F105D6.7000500@cdi.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> 
>> I will not leave the effort un-appreciated ;-)
>> Going to dig into smbus.sys more for now.
> 
> Good. I must study for final exams...

good luck :) I just found it was working all the time only I was fooled
by I2C warnings so I even didn't test it. Now after I successfully 
disasembled and commented whole smbus.sys I found that it is really
working :-) Well dumb me ... but at least nice rev-engineering experience.
I owe you a beer, if you have some time, say, at Monday :)

Patch is attached. Is it enough to post it here to be considered ?

Martin
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: ht1000-smb.diff
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060214/865c4149/ht1000-smb.pl
