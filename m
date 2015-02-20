From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 20 Feb 2015 23:52:39 +0000
Subject: Re: [lm-sensors] [RFC PATCH 0/3] hwmon: (ibmpowernv) add DTS support
Message-Id: <54E7C8C7.40001@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1423117857-32759-1-git-send-email-clg@fr.ibm.com>
 <1424444857-13805-1-git-send-email-clg@fr.ibm.com>
 <20150220165212.GE22752@roeck-us.net> <54E795FA.1090005@fr.ibm.com>
In-Reply-To: <54E795FA.1090005@fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Cedric Le Goater <clg@fr.ibm.com>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, lm-sensors@lm-sensors.org, Neelesh Gupta <neelegup@linux.vnet.ibm.com>, skiboot@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org, Jean Delvare <jdelvare@suse.de>

On 02/20/2015 12:15 PM, Cedric Le Goater wrote:
> On 02/20/2015 05:52 PM, Guenter Roeck wrote:
>> On Fri, Feb 20, 2015 at 04:07:34PM +0100, C=E9dric Le Goater wrote:
>>> Hello !
>>>
>>> These patches rework the ibmpowernv driver to support the new device
>>> tree as proposed by this patchset on the skiboot mailing list :
>>>
>>>    https://lists.ozlabs.org/pipermail/skiboot/2015-February/000457.html
>>>
>>> They are based on Linux 3.19 and were tested on IBM Power and Open Power
>>> systems running trusty.
>>>
>>> The main issue is that the new device tree is incompatible with the
>>> previous ibmpowernv drivers. The consequence is no powernv sensors
>>> on systems with such a opal/linux configuration.
>>>
>> I don't think that would be acceptable. There must be lots of such
>> systems out there. Why does it have to be incompatible ?
>> Can't it support both the old and new versions ?
>
> I should have provided more explanation in the Linux patchset. Sorry
> for that. Here is the rationale behind this brutal code change.
>
> The initial ibmpowernv driver was designed in the early days of the
> powernv platform and the device tree it is using to expose the sensors
> has some limitations that makes it difficult to add new ones. The current
> layout of the device tree is also tightly coupled to IBM Power systems
> and their service processor (FSP). Open Power systems are different and
> need a different solution.
>
> It is to get more sensors out the P8 (and there are quite a few) that
> the OPAL patchset [1] proposes a new device tree. On the Linux side, it
> feels simpler to make a jump forward and break the compatibility than
> to maintain multiple branches of code just to keep alive an early v1
> of the ibmpowernv driver.
>

Would it possibly be appropriate to write a different driver for the new
device tree ?

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
