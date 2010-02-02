From: Luca Tettamanti <kronos.it@gmail.com>
Date: Tue, 02 Feb 2010 10:09:33 +0000
Subject: Re: [lm-sensors] Help with asus_atk0110 module
Message-Id: <68676e01002020209i61c3bdaib0d5241d28ea9218@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <68676e01001290037o64afca82ra3ad2a5556ecb0e6@mail.gmail.com>
In-Reply-To: <68676e01001290037o64afca82ra3ad2a5556ecb0e6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Jan 29, 2010 at 7:03 PM, Juliano F. Ravasi <jravasi@gmail.com> wrote:
> Luca Tettamanti wrote:
>> Ok, you were bitten by this bug:
>> http://lists.lm-sensors.org/pipermail/lm-sensors/2010-January/027633.html
>>
>> Fix is already present in Linus' tree, you can find the patch here:
>> http://lists.lm-sensors.org/pipermail/lm-sensors/2010-January/027647.html
>>
>
> Thanks! That worked!
>
> But it looks like the module doesn't support PWM outputs... I couldn't
> get much information from Google, and reading the source seems like it
> only supports temp/volt/fan sensors. Is this correct? Is it planned to
> support adjusting the PWM outputs in the future?

Direct PWM adjustment: no, it's not possible with the ACPI driver.
Q-FAN: maybe, but so far I've been unable to decode the interface.

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
