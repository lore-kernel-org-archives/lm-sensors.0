From: Hans de Goede <hdegoede@redhat.com>
Date: Fri, 13 Aug 2010 13:27:23 +0000
Subject: Re: [lm-sensors] Support for the Fintek F71889ED ,
Message-Id: <4C65483B.1090108@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <371881832.20100807181035@eikelenboom.it>
In-Reply-To: <371881832.20100807181035@eikelenboom.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On 08/07/2010 06:10 PM, Sander Eikelenboom wrote:
> Hi Hans,
>
> In the thread mentioned below you stated that a proper driver can only be made with a datasheet.
> I have mailed fintek, but haven't got a response .. none the less when i checked today the sheets seem to be on their site (although you perhaps allready knew).
>
> http://www.fintek.com.tw/files/productfiles/F71889_ab.pdf
> http://www.fintek.com.tw/files/productfiles/F71889_V0.28P.pdf
>

Those are for the F71889 which is different from the F71889E (chipid 0x0723 versus 0x0909)

But I do have a datasheet for the F71889E now, and I have adding support for it on my
to do list, the problem though is time...

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
