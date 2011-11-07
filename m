From: Matthew Garrett <mjg59@srcf.ucam.org>
Date: Mon, 07 Nov 2011 17:18:45 +0000
Subject: Re: [lm-sensors] Hardware running hot and without the fan
Message-Id: <20111107171845.GB23257@srcf.ucam.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4EB1108F.6070009@gmail.com>
 <20111103020301.GA22333@ericsson.com>
 <4EB250FD.3070000@gmail.com>
 <20111103134902.GA26121@ericsson.com>
 <4EB2A46B.8080600@gmail.com>
 <1320332801.2309.60.camel@groeck-laptop>
 <4EB2B0FD.309@gmail.com>
 <20111103174635.GA12229@polaris.bitmath.org>
 <4EB3BE15.3070009@gmail.com>
In-Reply-To: <4EB3BE15.3070009@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Lars =?iso-8859-1?Q?Nood=E9n?= <lars.nooden@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, guenter.roeck@ericsson.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Fri, Nov 04, 2011 at 12:27:33PM +0200, Lars Nood=E9n wrote:

> I think there are two problems.  One is the GPU or some other part
> running hot.  The other is the sensors/fans issue: the fans don't turn
> on even when the system is hot.  Both problems are evident on two
> different models of hardware, the notebook is a MacBookPro8,2 and the
> desktop is a Macmini3,1.

Fan control is under the control of the SMC. If fans aren't working then=20
either we're supposed to be feeding data into the SMC or there's a=20
hardware problem of some description.

--=20
Matthew Garrett | mjg59@srcf.ucam.org

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
