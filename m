From: Luca Tettamanti <kronos.it@gmail.com>
Date: Fri, 20 Sep 2013 09:46:50 +0000
Subject: Re: [lm-sensors] Measured Fan RPM Jumps Frequently to 675000 RPM
Message-Id: <CAKPcRGp2PUS+sgxp6JQfdZ2aPmA0AJkb73ZS3P1AiFQYUtzcPw@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20130918105137.Horde.pcSHtQSX3xoA3EHBStt0YQ1@webmail.df.eu>
In-Reply-To: <20130918105137.Horde.pcSHtQSX3xoA3EHBStt0YQ1@webmail.df.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Sep 18, 2013 at 12:28 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On Wed, Sep 18, 2013 at 10:51:37AM +0200, Sascha Haupt wrote:
>>
>> Dear @ll,
>>
>> I am monitoring multiple systems (with Asus M5A78LE mainboards)
>> using sensors and Munin.
>>
>> On one node I often get a value of 675000 RPM for the FAN2 speed.
>> Usually, the value of FAN2 is approx 1950 RPM.
>>
>> The jump can frequently be seen if sensors is executed manually in a
>> fast sequence:
>>
> The driver only reports what it gets from the system through ACPI.
> I don't think there is anything we can do about it.
>
> Luca, any idea ?

Usually the ACPI code tries to read the speed from the sensor a few
times until it "makes sense" (according to some board specific logic);
if it fails it returns garbage.
If you send me the DSDT (/sys/firmware/acpi/tables/DSDT) I'll take a look.
In theory you could rewrite the method and replace the DSDT, but I
don't think it's worth the effort.

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
