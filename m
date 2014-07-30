From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 30 Jul 2014 04:30:31 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (ads1015) Fix off-by-one for valid channel index checking
Message-Id: <CAFRkauAy7f5P+4yCkSX54tj6BCXXpZQv2WCD8UWKVDpAEp9Rug@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1406690032.6636.1.camel@phoenix>
In-Reply-To: <1406690032.6636.1.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

2014-07-30 11:28 GMT+08:00 Guenter Roeck <linux@roeck-us.net>:
> On 07/29/2014 08:13 PM, Axel Lin wrote:
>>
>> Current code uses channel as array index, so the valid channel value is
>> 0 .. ADS1015_CHANNELS - 1.
>>
>> Signed-off-by: Axel Lin <axel.lin@ingics.com>
>
>
> Amazing. How do you find this stuff ?
I just read the code. :-)

Axel

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
