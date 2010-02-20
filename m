From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sat, 20 Feb 2010 18:47:36 +0000
Subject: [lm-sensors] asus atk0110 not working on Asus P5K-V
Message-Id: <4B802E48.8030406@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 02/20/2010 05:45 PM, Otto wrote:
> Hi,
>
> At the moment my Linux server is running kernel 2.6.31-19 and using the
> asus_atk0110 kernel module. As I discussed with Hans de Goede in Dutch
> below, unfortunately the command `sensors` is only functioning on my
> system when using the 'acpi_enforce_resources=lax' kernel option. Hans
> advised me to send this email, because I have an Asus motherboard and
> it's a bad idea to use both the acp_enforce_resources option and the
> asus_atk0110 driver.
>
> Cheers,
> Otto
>

Hi Otto,

To be clear, iirc the problem is that although the asus_atk0110 driver loads
automatically, it does not work, and thus you need to specify
acpi_enforce_resources=lax and load the appropriate native drivers, correct?

I've changed the subject of this mail to reflect this, so that hopefully
it will get the attention of the right persons.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
