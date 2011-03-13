From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 13 Mar 2011 12:55:02 +0000
Subject: Re: [lm-sensors] Driver for SMSC SCH5627 needed
Message-Id: <4D7CBEA6.2080403@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4CBD8E44.8070909@ts.fujitsu.com>
In-Reply-To: <4CBD8E44.8070909@ts.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On 03/12/2011 02:21 PM, Jean Delvare wrote:
> On Sat, 12 Mar 2011 12:19:09 +0100, Jean Delvare wrote:
>> Anyway, I agree that the non-standard location of the base I/O register
>> isn't supported by sensors-detect yet. We already have some code to
>> handle non-standard SMSC chips, but the SCH5627 is non-standard in a
>> different way. I'll try to come up with something, stay tuned.
>
> Can anyone with access to a SCH5627 chip test the sensors-detect patch
> in attachment?

Thanks for doing this! I had this on my todo. Likewise I've extending
sensors detect for the new Fintek models supported by the f71882fg driver,
as well as updating the devices wiki page on my todo.

Works like a charm:

Trying family `SMSC'...                                     Yes
Found `SMSC SCH5627 Super IO'                               Success!
     (address 0x580, driver `sch5627')

(and yes that is the correct io address).

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
