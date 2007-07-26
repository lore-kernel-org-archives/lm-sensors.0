From: Eric Sandeen <sandeen@sandeen.net>
Date: Thu, 26 Jul 2007 05:14:20 +0000
Subject: Re: [lm-sensors] dme1737 very slow read...
Message-Id: <46A82DAC.5070609@sandeen.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <46A8157E.7040003@sandeen.net>
In-Reply-To: <46A8157E.7040003@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Juerg Haefliger wrote:
> Hi Eric,
> 
> 
>> I was very happy to see dme1737 support added, thank you!  Now I can get
>> all the info out of my compaq sr1710nx cheapo server.  :)
> 
> Glad you like it :-) I can finally tell my wife that the time I spent
> on the driver wasn't all wasted...

I'm impressed; I tried to dislodge a data sheet for this chip from SMSC,
with no luck.  They don't want us to know our cpu temps it seems!  ;-)

>> 1.53 seconds to read "0\n" !  :)
>>
>> Any idea if this is a hardware or software delay?  I haven't yet dug
>> into profiling the kernel code to see what might be taking so long...
> 
> It's simple: We have to read a lot of registers which we can only get
> to via I2C which is veeerrrrryyyyy sloooooowwwwww.

Ok, I thought it might be along those lines.  Is there any other
performance impact to the system while it's waiting for the I2C bus?

Thanks,

-Eric

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
