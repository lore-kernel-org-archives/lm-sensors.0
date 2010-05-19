From: Huaxu Wan <huaxu.wan@linux.intel.com>
Date: Wed, 19 May 2010 00:50:32 +0000
Subject: Re: [lm-sensors] [PATCH 0/2] hwmon: Update coretemp to current
Message-Id: <20100519005032.GA26906@owl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100510035031.GD9181@owl>
 <20100514065808.GA11598@owl>
 <20100517094136.094800562@osadl.org>
 <AANLkTinQlH7LhCAz00WaHqbbslcSqipzVx4tDoQKSqIL@mail.gmail.com>
 <625BA99ED14B2D499DC4E29D8138F150181F574C31@shsmsx502.ccr.corp.intel.com>
 <AANLkTimQnaUvXs75rpTOcW7CODXWgUfzekY9FCDa5S8P@mail.gmail.com>
In-Reply-To: <AANLkTimQnaUvXs75rpTOcW7CODXWgUfzekY9FCDa5S8P@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Dmitry Gromov <gromovd@gmail.com>
Cc: "Wan, Huaxu" <huaxu.wan@intel.com>, Andrew Morton <akpm@linux-foundation.org>, LM Sensors <lm-sensors@lm-sensors.org>, LKML <linux-kernel@vger.kernel.org>, Carsten Emde <C.Emde@osadl.org>

On 02:45 Tue 18 May, Dmitry Gromov wrote:
> Hi!
>=20
> And 90C seems to be good for N200 series of Atom CPUs only - I could not
> find TjMax value published for N330 Dual Core  (quite popular one). Intel
> only published Tcase for it:
> http://ark.intel.com/Product.aspx?id5641
> So, if for N270 Tcase =3D TjMax =3D 90C, then, I'd suggest to use Tcase =
=3D 85.2C
> for N330 TjMax value.

Quoted a sentence from [1], "Unless specified otherwise, all specifications=
 for=20
the processor are at TJ =3D 90=B0C", I believe the TjMax of 330 is 90C too.

[1]http://download.intel.com/design/processor/datashts/320528.pdf

Thanks
Huaxu

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
