From: Clemens Ladisch <clemens@ladisch.de>
Date: Sat, 24 Sep 2011 21:28:58 +0000
Subject: Re: [lm-sensors] AMD Phenom II Family 16h
Message-Id: <4E7E4B9A.7050002@ladisch.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <201109232108.25627.pablow.1422@gmail.com>
In-Reply-To: <201109232108.25627.pablow.1422@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> On Fri, 23 Sep 2011 20:50:22 -0700, Guenter Roeck wrote:
>> On Fri, Sep 23, 2011 at 08:06:19PM -0400, Pablo Fabian Wagner Boian wrote:
>>> I've got a question regarding AMD Phenom II Family 16h.
>>
>> ... the driver officially only supports up to family 15h as far
>> as I can see. Did you patch it, or does it just work ?
>
> The driver supports PCI devices (north bridge) not CPU families. Just
> as family 12h and 14h north bridges have the same PCI device ID, I can
> only guess that family 15h and 16h north bridges have the same PCI
> device ID. If this is confirmed, we can update the driver documentation
> accordingly. Andre, Clemens, any comment on this?

Phenom IIs are always Family 10h.
I'd guess this is decimal/hex confusion and not a super-secret new CPU.


Regards,
Clemens

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
