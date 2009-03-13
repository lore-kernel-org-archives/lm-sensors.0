From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 13 Mar 2009 15:51:42 +0000
Subject: Re: [lm-sensors] unknown chips/clients
Message-Id: <20090313165142.2fb0a442@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090311104958.59769db6.shanehelms0@gmail.com>
In-Reply-To: <20090311104958.59769db6.shanehelms0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 13 Mar 2009 11:18:44 +0000, Shane Helms wrote:
> I used the latest sensors-detect script, and found some unknown chips/clients.
> Found unknown chip with ID 0x0b00
> Client found at address 0x19
> 
> I was wondering what they are - one of them is probably my fan.
> You can see them in the sensors-detect output below.
> (...)
> Is there any documentation that could help me figure out these unknown sensors?

There is no reason to believe that these devices are sensors in the
first place.

As far as the Super-I/O chip is concerned, sensors-detect already does
all the guess work you can do. The next step is to obtain detailed
technical documentation from your vendor or open the case and search
for the chip physically (rather difficult for a laptop.) But then again
chances are big that you are wasting your time anyway because not all
Super-I/O chips include sensors, especially on laptops.

For the I2C chip, you can try dumping its registers with i2cdump, and
compare the value of some registers with a list of known vendor ID
register locations and values. These values are given at the end of:
http://www.lm-sensors.org/browser/lm-sensors/trunk/doc/chips/SUMMARY
But then again please keep in mind that there are big chances that this
chips isn't a sensor chip.

Most laptops do not have sensor chips lm-sensors can use. Thermal
management is done by ACPI.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
