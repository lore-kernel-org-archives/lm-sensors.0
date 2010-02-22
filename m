From: Luca Tettamanti <kronos.it@gmail.com>
Date: Mon, 22 Feb 2010 20:57:28 +0000
Subject: Re: [lm-sensors] asus atk0110 not working on Asus P5K-V
Message-Id: <68676e01002221257m2851caeak5fd43d1ea2bbe9d@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4B802E48.8030406@hhs.nl>
In-Reply-To: <4B802E48.8030406@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Feb 20, 2010 at 7:47 PM, Hans de Goede <j.w.r.degoede@hhs.nl> wrote:
> On 02/20/2010 05:45 PM, Otto wrote:
>> At the moment my Linux server is running kernel 2.6.31-19 and using the
>> asus_atk0110 kernel module. As I discussed with Hans de Goede in Dutch
>> below, unfortunately the command `sensors` is only functioning on my
>> system when using the 'acpi_enforce_resources=lax' kernel option. Hans
>> advised me to send this email, because I have an Asus motherboard and
>> it's a bad idea to use both the acp_enforce_resources option and the
>> asus_atk0110 driver.
>
> To be clear, iirc the problem is that although the asus_atk0110 driver loads
> automatically, it does not work, and thus you need to specify
> acpi_enforce_resources=lax and load the appropriate native drivers, correct?

Otto can you send me a copy of the DSDT (/sys/firmware/acpi/tables/DSDT)?

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
