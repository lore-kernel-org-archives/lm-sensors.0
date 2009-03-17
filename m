From: Wolfgang Grandegger <wg@grandegger.com>
Date: Tue, 17 Mar 2009 14:33:30 +0000
Subject: Re: [lm-sensors] DS75: 12-bit support question
Message-Id: <49BFB4BA.8070600@grandegger.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <49993BD6.7000303@grandegger.com>
In-Reply-To: <49993BD6.7000303@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Jean Delvare wrote:
> Hi Wolfgang,
> 
> On Mon, 16 Feb 2009 11:11:34 +0100, Wolfgang Grandegger wrote:
>> Hello,
>>
>> I have just realized that there have already been an attempt to get
>> 12-bit support into the LM75 driver:
>>
>>   http://marc.info/?t0836918500008&r=1&w=4
> 
> Yes, I remember David (Cc'd) had been working on it.
> 
>> But it's not obvious too me why it was finally abandoned. In the GIT log
>> I just find:
>>
>>      - More careful initialization.  Chips are put into 9-bit mode so
>>        the current interconversion routines will never fail.
>>
>> What have I missed?
> 
> I can't remember exactly either, I suspect there was some remaining
> polishing that never happened and the patch was lost because of this.
> This is also the time when we lost our hwmon subsystem maintainer,
> which probably didn't help keep track of floating patches. But there is
> no problem with adding 12-bit resolution support to the lm75 driver for
> chips which have this feature, if you are interested and willing to
> work on it.

OK, I see. A customer was asking for 12-bit support, but I doubt that
there is any benefit because the accuracy of the mounted DS75 is just
+-2 degree. And most LM75 compatible devices are not more accurate, I
think. If he decides to calibrate the dtt, e.g., I might get an
opportunity to add to 12-bit support.

Thanks,

Wolfgang.



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
