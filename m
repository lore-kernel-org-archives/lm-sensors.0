From: George Joseph <george.joseph@fairview5.com>
Date: Mon, 06 Jul 2015 14:17:12 +0000
Subject: Re: [lm-sensors] Anyone working on Fintek f81768?
Message-Id: <CAHKv19APZUYUAUbdfdrQeFKFkjZK4Kbbn6_2Ycaf7SooonajGQ@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAHKv19CY4xBJwedUpOP5995JSSTB35QMoR50LDwct6pTtCEgjw@mail.gmail.com>
In-Reply-To: <CAHKv19CY4xBJwedUpOP5995JSSTB35QMoR50LDwct6pTtCEgjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Jul 6, 2015 at 6:20 AM, Jean Delvare <jdelvare@suse.de> wrote:
> Hi George,
>
> On Mon, 29 Jun 2015 10:28:17 -0600, George Joseph wrote:
>> I've got a few Jetway NF9N motherboards with the f81768 chip (id
>> 0x1210 I think).  If no one's already working on getting it added,
>> I'll take a look at adding it to one of the existing fintek drivers,
>> hopefully f71882fg.  Can't find a data sheet though. :(
>>
>> http://www.fintek.com.tw/index.php/i-o-controller-and-i-f-management/item/134-f81768
>
> This is the first request. I can't find a datasheet either. I've added
> an entry in the wiki and in sensors-detect too.

Thanks Jean.  I modified f71882fg.to accept the new id and it *seems*
to be working well for basic voltage, temp and fan operations with no
chip-specific code..  I'll be testing the auto stuff this week.  I did
have to set  pnpacpi=off though to use the driver.

>
> --
> Jean Delvare
> SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
