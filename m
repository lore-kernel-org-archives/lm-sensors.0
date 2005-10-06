From: xanni@glasswings.com.au (Andrew Pam)
Date: Thu, 06 Oct 2005 11:13:17 +0000
Subject: [lm-sensors] Myson MTP008 driver ported to 2.6 kernel
Message-Id: <20051006091223.GU7173@kira.glasswings.com.au>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051004125511.GI7154@kira.glasswings.com.au>
In-Reply-To: <20051004125511.GI7154@kira.glasswings.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Oct 05, 2005 at 05:12:12PM +0200, Jean Delvare wrote:
> A note on hardware layout. As I understand it, the MTP008 has some pins
> which can have different functions. The original driver gave the user
> the possibility to change that, right? I do not think this is the
> correct approach. In the real world, the hardware layout is defined and
> doesn't change. The BIOS is supposed to properly setup the chip
> according to this. Unless you have evidences that systems exists with
> MTP008 chips, those BIOSes do NOT properly initialize the chip, I would
> like the driver to trust the original settings, and stick to them. This
> is less error-prone for the user, and should save some code and memory.
> 
> If we go that way, then you do not have to handle the conditions in each
> callback function. Simply do not create the sysfs files which do not
> match the current setup (that is, create in4* or temp2*, but not both
> sets.)

I agree, but according to Documentation/hwmon/sysfs-interface the
temp[1-3]_type file is Read/Write which suggests that either the driver
needs to support writes and the changes to the chip configuration that
implies, or the documentation needs to be changed.

Regards,
	Andrew
-- 
mailto:xanni@xanadu.net                         Andrew Pam
http://www.xanadu.com.au/                       Chief Scientist, Xanadu
http://www.glasswings.com.au/                   Partner, Glass Wings
http://www.sericyb.com.au/                      Manager, Serious Cybernetics
