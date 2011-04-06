From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 06 Apr 2011 17:11:43 +0000
Subject: Re: [lm-sensors] Any idea to support Fintek F71808A
Message-Id: <4D9C9ECF.40909@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <BANLkTinFxPuMEuM-ZOandTcnAwxeWKgx5g@mail.gmail.com>
In-Reply-To: <BANLkTinFxPuMEuM-ZOandTcnAwxeWKgx5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On 04/06/2011 12:15 PM, D.B. Tsai wrote:
> Hi Hans
>
> It's regular mainboard.
>
> The motherboard I have is this one
> http://www.ecs.com.tw/ECSWebSite/Product/Product_Detail.aspx?DetailID31&CategoryID=1&MenuID6&LanID=0
>
> Do you want to test it? I can create an account with sudo permission for you.

No that won't be necessary. Ok, so with a regular motherboard, chances are
that ignoring the acpi resource conflict and loading the driver anyways will work
fine.

Please read:
http://www.lm-sensors.org/wiki/FAQ/Chapter3#Mysensorshavestoppedworkinginkernel2.6.31

And notice that there are risks to disabling the acpi resource conflict check!

If you're willing to take that risk, let me know and I'll work on an update
for the f71882fg driver to properly support the f71808a as time permits, and
get back to you when I have something for you to test.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
