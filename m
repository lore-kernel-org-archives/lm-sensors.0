From: "p. stephen w" <p.stephenwille@gmail.com>
Date: Wed, 13 Nov 2013 17:40:35 +0000
Subject: Re: [lm-sensors] Nuvoton NCT6791D support
Message-Id: <CADkjvt_PiEEU_QP=bDkdSY_Uz_rRxMXMY=GUMeXibR8s+S-RGQ@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CADkjvt_edGO-+NKbsUbNwN=DXod10WTUYmfjRTrQfYq_2no2uw@mail.gmail.com>
In-Reply-To: <CADkjvt_edGO-+NKbsUbNwN=DXod10WTUYmfjRTrQfYq_2no2uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

mm...this may be a factor.  I had two NCT6775 folders.  One in Downloads,
and one in the 'stephen' dir.  I'm guessing running modprobe install from
the wrong dir could install the wrong driver.  I've removed the older
NCT6775 dir.  Let me know if you need this ran again.


On Wed, Nov 13, 2013 at 9:37 AM, p. stephen w <p.stephenwille@gmail.com>wrote:

> I'm pretty sure I did, but just in case I re-ran the install.  The
> attached includes the commands as I ran them, plus pre and post boot
> sensor/hwmon info.
>
> Let me know.
>
>
> On Wed, Nov 13, 2013 at 9:33 AM, Guenter Roeck <linux@roeck-us.net> wrote:
>
>> On Tue, Nov 12, 2013 at 11:01:44PM -0800, p. stephen w wrote:
>> > No prob.  See attached.
>> >
>> Hi,
>>
>> [ not sure if I actually sent my prevous response. Too early in the
>> morning ;-). ]
>>
>> First of all, thanks a lot for testing. For some reason, the output is
>> the same
>> as before. Yet, the latest driver version should only create the
>> "pwm*weight"
>> attributes for pwm2. So I wonder - is it possible that you did not unload
>> the
>> old driver version with "modprobe -r" before loading the new version ?
>>
>> Thanks,
>> Guenter
>>
>
>
>
> --
>
>
> _____________________________
> Stephen Wille | pstephenwille.com
> *new address p.stephenwille@gmail.com <p.stephenwille@gmail.com>*
>



-- 


_____________________________
Stephen Wille | pstephenwille.com
*new address p.stephenwille@gmail.com <p.stephenwille@gmail.com>*
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
