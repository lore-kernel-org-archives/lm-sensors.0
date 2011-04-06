From: "D.B. Tsai" <dbtsai@gmail.com>
Date: Wed, 06 Apr 2011 10:15:43 +0000
Subject: Re: [lm-sensors] Any idea to support Fintek F71808A
Message-Id: <BANLkTi=rSVHv9_gSgB3ipKs7v3OHYNQ==w@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <BANLkTinFxPuMEuM-ZOandTcnAwxeWKgx5g@mail.gmail.com>
In-Reply-To: <BANLkTinFxPuMEuM-ZOandTcnAwxeWKgx5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi Hans

It's regular mainboard.

The motherboard I have is this one
http://www.ecs.com.tw/ECSWebSite/Product/Product_Detail.aspx?DetailID31&CategoryID=1&MenuID6&LanID=0

Do you want to test it? I can create an account with sudo permission for you.

Thanks.

Best Wishes,

Dong-Bang Tsai    蔡東邦
Ph.D. Student in Applied Physics at Stanford University
史丹佛大學應用物理所博士班
-----------------------------------
Web : http://www.dbtsai.com
Phone : +1-650-383-8392  (USA)
            +886-910-008-392 (Taiwan)



On Wed, Apr 6, 2011 at 3:09 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
> On 04/06/2011 10:54 AM, D.B. Tsai wrote:
>>
>> Hi
>>
>> Since Fintek F71808E seems to be quick closed to F71808A, I copy
>> everything related to 71808E into F71808A in the f71882fg.c. The code
>> can be compiled, but when I try to modprobe, I got the error message
>> "FATAL: Error inserting f71882fg
>> (/lib/modules/2.6.38-8-server/kernel/drivers/hwmon/f71882fg.ko):
>> Device or resource busy
>> "
>>
>> Anything I should notice?
>
> The F71808A is not 100% compatible with the F71808E, at it has less
> voltage inputs for one. I've not yet checked the entire datasheet of
> the F71808A to see if there are any other differences.
>
> I saw further down the thread that your BIOS ACPI tables / code claims
> to own the io ranges which are used for the hwmon part. May I ask on which
> kind of device / motherboard you have a F71808A, is this in a laptop or
> on a regular motherboard, and which model?
>
> Regards,
>
> Hans
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
