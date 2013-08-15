From: Clemens Ladisch <clemens@ladisch.de>
Date: Thu, 15 Aug 2013 07:55:37 +0000
Subject: Re: [lm-sensors] reading on-die temperature sensor of AMD A10 5700 processor
Message-Id: <520C8979.8010905@ladisch.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAFSPGzQyxOOhjawcQj=wH+k1b=OC1gGf6CKWoU89TWVTykNcOQ@mail.gmail.com>
In-Reply-To: <CAFSPGzQyxOOhjawcQj=wH+k1b=OC1gGf6CKWoU89TWVTykNcOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> On 08/14/2013 09:16 PM, Dev, Kapil wrote:
>> I got a little confused about the way temperature-computation is
>> explained on page 393. The interpretation of D18F3xA4[31:21] seems to
>> be different based on the D18F3xA4[17:16] bits.

These two bits should always be 00; Linux never tries to write the
temperature value.

>> Something similar, but not exactly the same thing, is implemented in
>> k10temp.c in lines 85-90. The value (D18F3xA4[18:16])

No, this value is D18F3x64[22:16].

>> is multiplied by 500 and then 52000 is added to it. While, on page
>> 393, I see <(CurTmp[10:2]*0.5)-49>.

On page 382, I see <(HtcTmpLmt*0.5)+52>.


Regards,
Clemens

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
