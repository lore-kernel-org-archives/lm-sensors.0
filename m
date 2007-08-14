From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Tue, 14 Aug 2007 06:52:35 +0000
Subject: Re: [lm-sensors] [PATCHES] hwmon: update against ~v2.6.23-rc2
Message-Id: <46C15133.3020004@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <11869444521807-git-send-email-mhoffman@lightlink.com>
In-Reply-To: <11869444521807-git-send-email-mhoffman@lightlink.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Mark M. Hoffman wrote:
> Hi Hans:
> 
> * Hans de Goede <j.w.r.degoede@hhs.nl> [2007-08-12 21:21:23 +0200]:
>> Mark M. Hoffman wrote:
>>> The following four patches are in my hwmon-2.6.git/release branch.  I will 
>>> ask
>>> Linus to merge this branch very soon.
>>>
>> Any chance the f71882fg driver could make it in, the second version has 
>> been acked by Darrick J. Wong now, who reviewed the first version.
>>
>> Here is the mail with the patch:
>> http://lists.lm-sensors.org/pipermail/lm-sensors/2007-July/020441.html
>>
> 
> It's not going in before v2.6.23, if that's what you mean.  I doubt Linus
> would accept it even if I tried.  It is very close to the head of my queue
> though.  Now that all the known regressions are dead, it will hit testing
> (and therefore -mm) very soon.
> 

Hmm,

Can't you atleast try. It already has many users now (without any troubles, I'm 
about to upload a verified sensors.conf for a third motherboard using this 
driver), and was requested a lot because its a popular chip. I thought Linus 
didn't mind doing new drivers after the freeze as they cannot cause regressions 
(normally) snd I dislike the idea of this driver having to wait another cycle, 
I already submitted it at the end of the 2.6.22 cycle.

Either way its your call.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
