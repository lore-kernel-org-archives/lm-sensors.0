From: Martin Herrholz <martin@rzschernsdorf.de>
Date: Tue, 25 Mar 2014 10:12:46 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (it87) Add support for IT8623E
Message-Id: <5331569E.1090907@rzschernsdorf.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1354475868-10032-3-git-send-email-linux@roeck-us.net>
In-Reply-To: <1354475868-10032-3-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean and Rudolf,

i did install the module like mentioned in your linked Instructions and 
redone the sensors-detect.
I still get the same result:

Trying family `ITE'...                                      Yes
Found unknown chip with ID 0x8623
     (logical device 4 has address 0x290, could be sensors)

I had no it87 module installed prior to it, so i had nothing to remove. 
The module compiles/loads without errors.

Best Regards
Martin

On 25.03.2014 09:24, Jean Delvare wrote:
> Hi Rudolf,
>
> On Mon, 24 Mar 2014 23:23:39 +0100, Rudolf Marek wrote:
>> The attached patch adds support for the IT8623E found on Asus motherboards. It
>> has same hardware monitoring block as IT8603E.
>>
>> Signed-off-by: Rudolf Marek <r.marek@assembler.cz>
> That should do the trick, thank you. Patch applied.
>
>> Compile tested. Martin, please can you test?
> If it helps, I have updated the standalone it87 driver at:
> http://jdelvare.nerim.net/devel/lm-sensors/drivers/it87/
>
> Installation instructions are at:
> http://jdelvare.nerim.net/devel/lm-sensors/drivers/INSTALL
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
