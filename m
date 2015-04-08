From: Cedric Le Goater <clg@fr.ibm.com>
Date: Wed, 08 Apr 2015 17:33:37 +0000
Subject: Re: [lm-sensors] [PATCH v5 0/4] hwmon: (ibmpowernv) add DTS support
Message-Id: <55256671.7070209@fr.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1428513590-5773-1-git-send-email-clg@fr.ibm.com>
 <20150408173236.GB26109@roeck-us.net>
In-Reply-To: <20150408173236.GB26109@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Guenter Roeck <linux@roeck-us.net>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, lm-sensors@lm-sensors.org, Neelesh Gupta <neelegup@linux.vnet.ibm.com>, skiboot@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org, Jean Delvare <jdelvare@suse.de>

On 04/08/2015 07:32 PM, Guenter Roeck wrote:
> On Wed, Apr 08, 2015 at 07:19:46PM +0200, C=E9dric Le Goater wrote:
>> Hello !
>>
>> These patches extend the ibmpowernv driver to support the new OPAL firmw=
are=20
>> which now exposes in its device tree the Digital Temperature Sensors of =

>> a P8 system.
>>
>> They are based on Linux 4.0.0-rc7 + the initial cleanup serie :
>>
>>      http://lists.lm-sensors.org/pipermail/lm-sensors/2015-March/043670.=
html
>>
>> and were tested on IBM Power and Open Power systems running Trusty.
>>
> Series applied to -next.

Thanks for the review !=20

Cheers

C.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
