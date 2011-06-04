From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 04 Jun 2011 17:29:06 +0000
Subject: Re: [lm-sensors] MAX6642 chip detection and other stuff
Message-Id: <20110604172906.GA19782@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110528045113.GA8833@ericsson.com>
In-Reply-To: <20110528045113.GA8833@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Per,

On Wed, Jun 01, 2011 at 02:44:19AM -0400, Per Dal=E9n wrote:
> Hi Guenter and Jean,
>=20
> Sorry for the delay. Much stuff at work...
> Here's (Jean's ;) patch.
>=20
> BR
> Per
>=20
> On 05/28/2011 04:04 PM, Guenter Roeck wrote:
> > Hi Jean,
> >=20
> > On Sat, May 28, 2011 at 04:36:31AM -0400, Jean Delvare wrote:
> >> Hi Guenter,
> >>
> >> On Fri, 27 May 2011 21:51:13 -0700, Guenter Roeck wrote:
> >>> The attached patch (on top of Per's most recent patch) works quite ni=
cely.
> >>> Per, maybe you can just merge it with your patch and resubmit it.
> >>
> >> Looks good, pretty much what I had in mind. But I think you could make
> >> the code even more compact:
> >>
> >> 	/* sanity check */
> >> 	if (i2c_smbus_read_byte_data(client, 0x04) !=3D 0x4D
> >> 	 || i2c_smbus_read_byte_data(client, 0x06) !=3D 0x4D
> >> 	 || i2c_smbus_read_byte_data(client, 0xff) !=3D 0x4D)
> >> 		return -ENODEV;
> >>
> > Yes, you are right. I didn't do it to avoid a checkpatch warning, but f=
orgot
> > that I don't use a variable anymore.
> >=20
> > Guenter
>=20

> Improve the detection of MAX6642 by reading non exciting registers (0x04,=
 0x06 and 0xff). The value of those registers should be the same as the las=
t valid resister read.
>=20
> Signed-off-by: Per Dalen <per.dalen@appeartv.com>

I want to send this off to Linus with my next set of patches, so I added th=
e second set
of checks myself. No need to resubmit.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
