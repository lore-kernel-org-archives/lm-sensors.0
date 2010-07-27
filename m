From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 27 Jul 2010 12:45:03 +0000
Subject: Re: [lm-sensors] asus_atk0110 on a p6td deluxe
Message-Id: <4C4ED4CF.6050001@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <724895.29279.qm@web28512.mail.ukl.yahoo.com>
In-Reply-To: <724895.29279.qm@web28512.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On 07/27/2010 01:03 PM, Luca Tettamanti wrote:
> On Mon, Jul 26, 2010 at 11:18 PM, Marco<jjletho67-ml@yahoo.it>  wrote:
>> i'm attaching the DSDT file. If i well understood  you are able to look inside
>> it...
>
> Ok, as expected the hwmon section does not contain additional entries.
>
> However, in GIT3 I see at least the following entries that are
> connected to the hwmon chip:
>
> "BCLK Frequency"
> "CPU Voltage" (another one, but for a different register)
> "CPU Ratio"
> "QPI/DRAM Core Volt"
> "DRAM Bus Voltage"
>

Hmm, this sounds like its not hwmon, but voltage and clock
control!!

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
