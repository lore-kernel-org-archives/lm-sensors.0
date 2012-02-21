From: Roland Stigge <stigge@antcom.de>
Date: Tue, 21 Feb 2012 08:40:55 +0000
Subject: Re: [lm-sensors] [Patch] hwmon: (max6639) Set Pulse per revolution loop for both channels
Message-Id: <4F435897.7080608@antcom.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAO7tRnjoSKUKoL4445e+Gud7Dhe=K9K1MYnGNCYcBs-d4X2O6A@mail.gmail.com>
In-Reply-To: <CAO7tRnjoSKUKoL4445e+Gud7Dhe=K9K1MYnGNCYcBs-d4X2O6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 02/21/2012 12:58 AM, Guenter Roeck wrote:
> On Mon, Feb 20, 2012 at 05:53:16PM -0500, Roland Stigge wrote:
>> On 20/02/12 22:58, Chris wrote:
>>> Patch to fix PPR register initialization to set both channels
>>> Signed-off-by: Chris D Schimp <silverchris <at> gmail.com>
>>
>> Looks good.
>>
>> Acked-by: Roland Stigge <stigge@antcom.de>
>>
> So << 6 instead of << 5 is ok ?

Yes, see datasheet, Register Map, Reg. 24h+25h. It's the upper 2 bits of
the 8 bit register for the 2 bits of PPR.

Further, I agree that the patch style should be improved before submitting.

Thanks,

Roland

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
