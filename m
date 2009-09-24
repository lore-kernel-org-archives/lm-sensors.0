From: Luca Tettamanti <kronos.it@gmail.com>
Date: Thu, 24 Sep 2009 08:53:55 +0000
Subject: Re: [lm-sensors] [PATCH] asus_atk0110: add support for Asus P7P55D
Message-Id: <68676e00909240153o4ae86eeegf9b6d000668ec858@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090923191240.GA15198@dreamland.darkstar.lan>
	 <51f3faa70909232018v7e621190m84deb648b08d2135@mail.gmail.com>
In-Reply-To: <51f3faa70909232018v7e621190m84deb648b08d2135@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Robert Hancock <hancockrwd@gmail.com>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Jean Delvare <khali@linux-fr.org>

On Thu, Sep 24, 2009 at 5:18 AM, Robert Hancock <hancockrwd@gmail.com> wrote:
> On Wed, Sep 23, 2009 at 1:12 PM, Luca Tettamanti <kronos.it@gmail.com> wrote:
>> With P7P55D (and newer) boards Asus extended the output buffer (ASBF)
>> making the driver unable to read the data from the sensors.
>> Change the driver to use dynamic buffers (allocated by ACPI core); the
>> return value is cached, so the number of memory allocations is very low.
>>
>> Signed-off-by: Luca Tettamanti <kronos.it@gmail.com>
>> Tested-by: Robert Hancock <hancockrwd@gmail.com>
>
> I just noticed a problem (either with this patch or some other issue
> with the driver on this board): The readings don't seem to be
> updating, I get the same values all the time.

Jean just relayed me some information from Asus on this board, the EC
is disabled by default.
I'm working on a fix.

L

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
