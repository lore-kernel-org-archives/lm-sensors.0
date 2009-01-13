From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 13 Jan 2009 11:11:04 +0000
Subject: Re: [lm-sensors] Updated initialization script, testers wanted
Message-Id: <20090113121104.2fc1046f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090112140236.6b74302e@hyperion.delvare>
In-Reply-To: <20090112140236.6b74302e@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Hans,

On Tue, 13 Jan 2009 09:02:33 +0100, Hans de Goede wrote:
> Jean Delvare wrote:
> > I have implemented and committed the sensors-detect side of ticket
> > #2246. Now the lm_sensors initialization script needs to be updated as
> > well, to make use of the new configuration file syntax. The
> > initialization script in our repository is meant for Red Hat
> > distributions but I don't have any, so I can't test my changes. The
> > patch I intend to apply is attached, could you (or anyone with a Red
> > Hat distribution) give it a try and confirm that it works OK?
> > Beforehand, you'll need to download and run the latest version of
> > sensors-detect:
> >=20
> > http://www.lm-sensors.org/svn/lm-sensors/branches/lm-sensors-3.0.0/prog=
/detect/sensors-detect
> >=20
> > and let it regenerate /etc/sysconfig/lm_sensors.
>=20
> Erm,
>=20
> Not tested, I'm not so happy with this change. I've read the ticker tryin=
g to=20
> find out why we would want this change, and I must say I'm not very convi=
nced=20
> with the reasoning there.
>=20
> My problem with these changes is that to me it feels like changing the co=
nfig=20
> file format without some very strong reasons, this will cause all kind of=
 pains=20
> when upgrading from an lm_sensors version with the old format to that wit=
h the=20
> new format. Do we really have to do this?

The two reasons that motivated the change are explained in the ticket,
there's not so much I can add:

1* Removing or adding a module manually is error-prone. Say you have
the following configuration file:

MODULE_0=3Dlm90
MODULE_1=3Dk8temp
MODULE_2=3Dit87

Now you change your graphics adapter and the new one no longer has a
thermal sensor, so you no longer need to load the lm90 driver. Simply
removing the first line may or may not be enough, depending on how the
initialization script is implemented. Apparently the one in openSUSE
copes with that, but the one in our repository (which I think you use
in Red Hat) doesn't.

2* The old format can't be edited with Yast's sysconfig editor, as the
editor expects fixed variable names. I find it pretty convenient for
the user to be able to edit all the system settings in a central place,
with settings put in a function-oriented tree, and a help text for every
setting. I don't know if Red Hat has an equivalent tool, but if it does
then I expect it to have the same problem with the current lm-sensors
configuration file format. It is much easier for me to tell a user to
open the sysconfig editor and change the value of variable
HWMON_MODULES to "foo bar" than to tell him/her to
open /etc/sysconfig/lm_sensors with a text editor, check the highest
MODULE_%d variable, and add a new line MODULE_%(d+1)=BAr.

On top of that, you can see that the code to generate and read the new
format is more simple. And the new format is clearer for the reader, as
it distinguishes between bus drivers and actual hardware monitoring
drivers.

I agree that there is a migration path issue when changing the format.
But it doesn't seem blocking to me. The changes I made to
sensors-detect are such that both formats will be generated for the
time being, and we can keep things that way for several releases. Each
distribution is free to switch to the new format as they see fit. If
you don't want to upgrade it now in Red Hat, just don't.

I am open to suggestions to make the migration path easier. I could
write a small shell script to convert from the old format to the new
one. This could become part of the post-install script of new
lm-sensors packages (RPM or other) so that upgrades work transparently
for the user. Would the change then be acceptable to you?

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
