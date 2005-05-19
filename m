From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:49 +0000
Subject: Future cooperation needs.
Message-Id: <Pine.LNX.4.58.0504071826290.21101@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0503282227270.21101@desitka.sh.cvut.cz>
In-Reply-To: <Pine.LNX.4.58.0503282227270.21101@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello LH Hsu

We were pleased by your offer and we generally agree with it.
I will put my personal comments to rest of email. I cant talk as
"chairman" because we do not have any organization like this :)

>
> Hello Lm-sensors team :
> 	This is LH Hsu, software coordinator of Winbond computer related
> product. I appreciate you contribution for Linux design and kind help
> for hardware monitor development of our staff.

For us this project is like a hobby and cooperation with leading company
as yours is simply great example that Linux developement and "opensource"
developement model is working.

> 	Chunhao  works in mainland China. Currently I am in business
> trip in China. Most of time I work at Taiwan. The area of Taiwan is
> closed to mother board maker I can do my best to have cooperation.

Yes that would be nice. For us is nearly impossible to get in contact with
them.

> 	Your meaning is you need the data sheet., especially SMBus
> part. Some of mother board maker or chip set maker are not public that.
> I can not get all of data sheet or mother board information. I suggest
> you got the mother board and Winbond chip mounted Super IO, 78x or 79x).
> Please send me the mother board maker vendor, mother board model, south
> bridge brand , south bridge chipset no and your requirement. I can do my
> best to collect information. It is impossible for mother board maker to
> release chipset number of all model. I can consult mother board maker
> about Winbond product.

Yes thank you very much.

Although the best for future of the project would be to persuade chipset
makers to agree that part of documentation that was requested from
unavailable datasheet can be shared by linux community. (as a text file
with documentation for example) This already works, some documentation
from unavaiable datasheet is now part of i2c/linux kernel documentation
for SMSC superio chip (the company lawers agreed)

A lot of interfaces like SMBUS for example is in many ways "generic" the
register implementation differs in very small details. We dont need to
know fancy inovative stuff that company protects.

Important for us is to share knowledge, because people are changing and
maintainer will be somebody else. It is simply not possible that every
single person who wants to correct some bug to sign NDA. Please try to
explain this to them, we dont need whole datasheets, we want some
"uninportant parts" form IP point of view. We want to share this
information as much legal as possible.

Great example is the Ali driver, without a public datasheet nobody could
spot that register implementation changed, nobody could spot that this
cannot work that way it is programmed. Now I'm chasing the next bug and
I'm getting sure this is "new feature of chip revision" or a simple bug
in design. I cant confirm without latest datasheet.

> 	Some information of mother board maker is confidential. If it is
> required for your development, you can  let me know, too. I try to do.

It is funny that two resistors on board dividing the voltage are "top
secret" sometimes. A lot of motherboard companies is not supporting linux
HW monitoring stuff. If they would just tell us what formulas they use
they could get whole software for free for their customers. I really dont
know how to explain this simple sentence to them. Please keep telling them
that they have chances through our project. Thanks.

> 	DZShen is the coordinator of Linux development. He is familiar
> with Linux design. Please send your requirement ,too.

Yes we will CC as usual :)

Regards

Rudolf
