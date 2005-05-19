From: merlin@merlin.org (merlin)
Date: Thu, 19 May 2005 06:23:59 +0000
Subject: Problem with i2c-amd756.o
Message-Id: <20030611182143.7B4A433826@primary.mx.nitric.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.33.0306051208440.4183-100000@lancelot.cems.umn.edu>
In-Reply-To: <Pine.LNX.4.33.0306051208440.4183-100000@lancelot.cems.umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Unfortunately the AMD 756 (and siblings) SMBUS does not seem to be
entirely reliable; I have similar problems with it locking up and not
coming back (on a similar machine). You need to disable whatever
is trying to read your hardware sensors; this will either be a GUI
application (a couple of the system monitors do this) or a daemon (e.g.,
sensord).

merlin

r/mds@paradyne.com/2003.06.09/21:29:40
>something is accessing the bus every few seconds.
>If things seem to be working anyway you can comment the messages out in the driver.
>
>Shriram Ramanathan wrote:
>> Hi,
>> 
>> I have a dual processor (AMD 1.8 GHz) machine with Redhat Linux installed.
>> I have this awfully irritating message cropping up on my terminal every
>> few seconds.
>> 
>> "i2c-amd756.o: Busy wait timeout! (0d00)
>> i2c-amd756.o: Sending abort."
>> 
>> I dont know how to fix this (I havent tried rebooting the m/c as yet)
>> Could you tell  me what is going wrong ?
>> 
>> Thanks.
>> 
>> Regards,
>> shriram
>> 
>> PS : I am a newbie to sysadmin and so might need some
>> elaboration on this....i.e. if it is not too much of a trouble for you.
