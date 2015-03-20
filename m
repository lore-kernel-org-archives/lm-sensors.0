From: Cedric Le Goater <clg@fr.ibm.com>
Date: Fri, 20 Mar 2015 16:52:38 +0000
Subject: Re: [lm-sensors] [PATCH v2 0/5] hwmon: (ibmpowernv) remove dependency on OPAL index
Message-Id: <550C5056.4030603@fr.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1423117857-32759-1-git-send-email-clg@fr.ibm.com>
 <1426787085-9004-1-git-send-email-clg@fr.ibm.com>
 <20150320152611.GA10749@roeck-us.net>
In-Reply-To: <20150320152611.GA10749@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Guenter Roeck <linux@roeck-us.net>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, lm-sensors@lm-sensors.org, Neelesh Gupta <neelegup@linux.vnet.ibm.com>, skiboot@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org, Jean Delvare <jdelvare@suse.de>

On 03/20/2015 04:26 PM, Guenter Roeck wrote:
> On Thu, Mar 19, 2015 at 06:44:40PM +0100, C=E9dric Le Goater wrote:
>> Hello !
>>
>> The current implementation of the driver uses an index for the hwmon=20
>> attribute which is extracted from the device node name. This index
>> is calculated by the OPAL firmware and its usage creates a dependency=20
>> with the driver which makes changes a little more complex in OPAL.
>>
>> This patchset changes the ibmpowernv code to use its own index. It=20
>> starts with a few cleanups, mostly code shuffling around the creation=20
>> of the hwmon sysfs attributes and completes by removing the dependency.
>>
> Series applied to hwmon-next (with patch #4 fixed up).

Thanks !

C.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
