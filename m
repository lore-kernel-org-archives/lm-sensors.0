From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:18 +0000
Subject: Myson mtp008
Message-Id: <20041005095719.M43649@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <BAY18-DAV3QM7gyoPB200002e55@hotmail.com>
In-Reply-To: <BAY18-DAV3QM7gyoPB200002e55@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 4 Oct 2004 14:30:13 -0500, James Grossmann wrote
> I noticed that this driver has not beed added to the 2.6 kernel 
> tree.  I'm just curious if there are any plans on introducing this 
> into the tree, or if there is a way in which I could build this for 
> my tyan 1834 motherboard. I am not a great programmer, but would be 
> interested in helping if there are no plans, I have researched the 
> chip and the differences between the lm_modules and the kernel 
> drivers for a couple of different chips and so have some background 
> on the drivers.

The drivers are ported as time permits, and since it is a scare resource over
here, ports are most frequently submitted by the users themselves. This is a
good thing anyway since you need a chipset to test the code. I wrote a porting
guide (Documentation/i2c/porting-clients in linux 2.6) which is considered a
good base document. That and comparing with an already ported driver should
make it relatively easy to port the mtp008 driver. It is a fairly large
driver, but also quite similar to the lm78.

When you are happy with the code, submit it over this mailing-list for review,
from where it will be sent to Greg KH for integration into the kernel tree.

Note that I am (sadly enough) the only active code reviewer here, and my list
of drivers to review is already long (lm87, adm9240, pc87360 and a few others)
and does stack down very slowly since I am overall busy (of course, everyone
is). So, you better be ready to patiently wait before I get a chance to review
any piece of code you provide. Unless someone else can take care of it, of course.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
