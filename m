From: "D.B. Tsai" <dbtsai@gmail.com>
Date: Wed, 06 Apr 2011 20:47:45 +0000
Subject: Re: [lm-sensors] Any idea to support Fintek F71808A
Message-Id: <BANLkTi=2CG9EEKOMR=nN_yx8N51xN_+tTQ@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <BANLkTinFxPuMEuM-ZOandTcnAwxeWKgx5g@mail.gmail.com>
In-Reply-To: <BANLkTinFxPuMEuM-ZOandTcnAwxeWKgx5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi

Sure, I can take the risk of the disabling acpi resource conflict
check, and I'm willing to test your code. Please let send me the code
when you finish it. By the way, I'm using Ubuntu 11.04 with kernel
2.6.38-8-server, and wondering to know that when will the mainline
kernel fix this conflict issue?

Thanks.

Best Wishes,

Dong-Bang Tsai    蔡東邦
Ph.D. Student in Applied Physics at Stanford University
史丹佛大學應用物理所博士班
-----------------------------------
Web : http://www.dbtsai.com
Phone : +1-650-383-8392  (USA)
            +886-910-008-392 (Taiwan)



On Wed, Apr 6, 2011 at 10:11 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
> On 04/06/2011 12:15 PM, D.B. Tsai wrote:
>>
>> Hi Hans
>>
>> It's regular mainboard.
>>
>> The motherboard I have is this one
>>
>> http://www.ecs.com.tw/ECSWebSite/Product/Product_Detail.aspx?DetailID31&CategoryID=1&MenuID6&LanID=0
>>
>> Do you want to test it? I can create an account with sudo permission for
>> you.
>
> No that won't be necessary. Ok, so with a regular motherboard, chances are
> that ignoring the acpi resource conflict and loading the driver anyways will
> work
> fine.
>
> Please read:
> http://www.lm-sensors.org/wiki/FAQ/Chapter3#Mysensorshavestoppedworkinginkernel2.6.31
>
> And notice that there are risks to disabling the acpi resource conflict
> check!
>
> If you're willing to take that risk, let me know and I'll work on an update
> for the f71882fg driver to properly support the f71808a as time permits, and
> get back to you when I have something for you to test.
>
> Regards,
>
> Hans
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
