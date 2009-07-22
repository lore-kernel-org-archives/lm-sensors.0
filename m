From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 22 Jul 2009 12:20:09 +0000
Subject: Re: [lm-sensors] Kernel-provided labels
Message-Id: <20090722142009.64d59eb4@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090512225508.7ab00c02@hyperion.delvare>
In-Reply-To: <20090512225508.7ab00c02@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Hubert,

On Tue, 12 May 2009 23:19:52 +0200, Hubert Kario wrote:
> On Tuesday 12 May 2009 22:55:08 you wrote:
> > Kernel-provided sensor labels can be problematic when the user tries to
> > apply a compute or ignore statement. In general, one can comment out
> > all label statements in the configuration file or run "sensors
> > -c /dev/null" to see the symbolic names of all inputs (in0, temp1
> > etc...) However, in the case where kernel-provided labels are
> > available, libsensors will process them nevertheless, so the user has
> > no way to see the symbolic name for the input.
> >
> > I can think of different approaches to solve this issue. I wonder which
> > one other developers and users think should be implemented.
> >
> > 1* A new command line parameter to disable the processing of
> >    kernel-provided labels (say: --no-kernel-labels.)
> >
> > 2* A new command line parameter to disable the processing of
> >    kernel-provided labels and configuration files (say: --raw.)
> >    This is a shorter alternative to "sensors -c /dev/null
> >    --no-kernel-label".
> >
> > 3* A new sensors output format which would display all available
> >    symbolic names of a device, possibly with kernel-provided and
> >    user-provided labels in a table.
>
> I'm voting or this one
> this could be a "verbose" output. IMO as the complexity of lm-sensors=20
> increases the need for such output mode will only rise
>=20
> also it could be used to insert detailed descriptions of specific sensors=
, so,=20
> for example, the user could get info that the "CPU temp" is, in fact the =

> "Tcase CPU temp" =E2=94=80 a heat spreader temperature ;)
>=20
> this would increase user friendliness greatly

Honestly I don't quite see the relation between my initial point and
your own proposal. I am also skeptical that there's anything that needs
to be done: if you want "Tcase CPU temp" as the label, just set the
label to this in /etc/sensors3.conf and be done with it? Attaching a
short description (label) _and_ a long description to each sensor seems
overkill to me.

> > 4* Allow kernel-provided labels to be used in compute statements
> >    instead of symbolic names.
> >
> > 5* Something else, speak up :)
> >
> > Option 4 seems technically complex to me, and error-prone
> > (kernel-provided labels are not guaranteed to be unique.) Option 1 is
> > very specific, I tend to prefer option 2 which is more generic and can
> > evolve over time. Option 3 may be interesting for other reasons,
> > including debugging and a valuable alternative to walking the sysfs
> > tree.
> >
> > As far as I can see, options 1, 2 and 3 all require that we extend the
> > libsensors API.
> >
> > Opinion anyone?

I have created a ticket to track this issue:
http://www.lm-sensors.org/ticket/2375

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
