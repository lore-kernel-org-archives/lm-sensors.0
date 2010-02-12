From: Luca Tettamanti <kronos.it@gmail.com>
Date: Fri, 12 Feb 2010 10:05:53 +0000
Subject: Re: [lm-sensors] ATK0110 on older Asus board
Message-Id: <68676e01002120205x63d214b3l4d144fd07be2e540@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <52ae42fa1001140656w17e9e219lad760a0687db6b20@mail.gmail.com>
In-Reply-To: <52ae42fa1001140656w17e9e219lad760a0687db6b20@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Feb 11, 2010 at 9:10 PM, frollic nilsson <frollic@gmail.com> wrote:
> sorry, missed the reply to all button :\

While we are at it: don't top post :P

> On Thu, Feb 11, 2010 at 5:25 PM, Luca Tettamanti <kronos.it@gmail.com> wrote:
>> On Thu, Feb 11, 2010 at 04:36:53PM +0100, frollic nilsson wrote:
>>
>> Ok, this means that ACPI core is not even calling the add method.
>> I guess that I can happen if _STA reports that the device is not functional.
>
> with the extra code inserted, I get a AIDI = 1 in the logs

As I suspected the device is disabled by the BIOS (AI-whatever is the
commercial name of the hwmon features, I guess AIDI = AI DIsable).
You should try and see if there's a relevant option in the BIOS setup
screen (btw, is there a monitoring page? does it work?)

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
