From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:39 +0000
Subject: smart battery
Message-Id: <3D781918.7F85D556@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <marc-lm-sensors-117499240406438@msgid-missing>
In-Reply-To: <marc-lm-sensors-117499240406438@msgid-missing>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

we don't know much about 'smart batteries' but
the smart battery people were the original authors of the SMBus spec.
There are some smart battery specs on the web too -
it may be that the interface is standard.

We'd love to see the GPL code. If anybody would like to write a driver
then we will have the code to give them.

mds



James Klaas wrote:
> 
> I hope this is the right place to post this.
> 
> I don't know if anyone has e-mailed you all about the SonicBlue ProGear
> tablet computer.  This has an ali1535 smbus with an adm1024 thermal
> monitoring chip.  It also has an unidentified smart battery and something
> hanging at 0x69 which is probably a timer (as noted in your documentation).
> 
> The code for reading the battery was released and the actual code for
> retrieving the data from the battery is GPL.  The other code for
> displaying and setting the battery is of unknown license.  After reading
> through the code for the battery and your instructions for creating a chip
> driver I don't think I have the capability to write the driver.  I would
> be happy to post the GPL code if someone else is able to write the driver.
> 
> I'm also confused as to whether the smart battery is the chip (to
> create a driver for) or if there's a separate chip that drives the smart
> battery that needs to be identified.  I can see the top half of the
> circuit board but I am not comfortable with taking the circuit board out
> of the case as it's all packed rather tightly and I don't want to risk
> making the unit non-operational.  I also have no idea what I should be
> looking for.
> 
> Thank you for your help.
>
