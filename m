From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 20 Mar 2015 15:26:11 +0000
Subject: Re: [lm-sensors] [PATCH v2 0/5] hwmon: (ibmpowernv) remove dependency on OPAL index
Message-Id: <20150320152611.GA10749@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1423117857-32759-1-git-send-email-clg@fr.ibm.com>
 <1426787085-9004-1-git-send-email-clg@fr.ibm.com>
In-Reply-To: <1426787085-9004-1-git-send-email-clg@fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@fr.ibm.com>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, lm-sensors@lm-sensors.org, Neelesh Gupta <neelegup@linux.vnet.ibm.com>, skiboot@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org, Jean Delvare <jdelvare@suse.de>

On Thu, Mar 19, 2015 at 06:44:40PM +0100, C=E9dric Le Goater wrote:
> Hello !
>=20
> The current implementation of the driver uses an index for the hwmon=20
> attribute which is extracted from the device node name. This index
> is calculated by the OPAL firmware and its usage creates a dependency=20
> with the driver which makes changes a little more complex in OPAL.
>=20
> This patchset changes the ibmpowernv code to use its own index. It=20
> starts with a few cleanups, mostly code shuffling around the creation=20
> of the hwmon sysfs attributes and completes by removing the dependency.
>=20
Series applied to hwmon-next (with patch #4 fixed up).

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
